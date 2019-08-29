package com.ruoyi.common.utils.http;

import java.io.IOException;
import java.net.URI;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ruoyi.common.constant.AjaxResultType;
import com.ruoyi.common.constant.ApiErrorResponseConstants;
import com.ruoyi.common.exception.ApiException;
import com.ruoyi.common.utils.loadbalance.LoadBanlanceUtil;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.server.domain.ApiServer;

@Component
public class ApiForwardUtil {

	@Autowired
	private ApiConfig apiConfig;
	
	public void forward(Map<String,Object> recordMap, List<String> fileNames, Map<String, String> params, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, ApiUrl apiUrl, ApiAccount apiAccount) throws IOException, ServletException {
		CloseableHttpResponse response = null;
		try {
			//负载均衡算法找到服务器
			ApiServer server = LoadBanlanceUtil.selectServer(apiUrl);
			if(server==null) {
				ApiErrorResponseConstants.NO_SERVER(httpServletResponse, null);
				recordMap.put("forwardSuccess", false);
	        	recordMap.put("failedReasons", "未找到服务器");
			}
			
	        recordMap.put("serverId", server.getServerId());
	        //拿到httpClient连接池
	        String httpConnectionPoolKey = server.getServerUrl();
	        HttpConnectionPool httpConnectionPool = HttpClientUtils.clients.get(httpConnectionPoolKey);
	        String uri = server.getServerUrl()+apiUrl.getApiServerUrlSuffix();
	        String requestUrI = recordMap.get("requestUrI").toString();
	        //找到api
	        //如果是*匹配模式，替换为真实请求，逻辑为将requestUrI中*之后的替换到后端请求中
	        if(apiUrl.getApiUrlSuffix().indexOf("*")>0) {
	        	String apiUrlSuffix = apiUrl.getApiUrlSuffix();
	            String apiUrlSuffixBeforeWildcard = apiUrlSuffix.substring(0, apiUrlSuffix.indexOf("*"));
	            
	            String realRequestSuffix = requestUrI.replace(apiConfig.getPreurl(), "");
	            realRequestSuffix = realRequestSuffix.substring(realRequestSuffix.indexOf(apiUrlSuffixBeforeWildcard)+1, realRequestSuffix.length());
	            uri = uri.replace("*", realRequestSuffix);
	        }
	        
	        recordMap.put("forwardUrl", uri);
	        CloseableHttpClient httpclient = httpConnectionPool.getHttpClient();
	        String reqMethod = recordMap.get("requestMethod").toString();
	        
	        //转发请求
	     // 检测是否为多媒体上传
 			if (!ServletFileUpload.isMultipartContent(httpServletRequest)) {
 				response = normalRequest(recordMap, reqMethod, uri, httpServletRequest, response, httpclient);
 			}else {
 				response = multiPartRequest(recordMap, fileNames, params, uri, httpServletRequest, response, httpclient);
 			}
	        
	        // 目前只测试了html，js，css，png  其他返回类型还要测试
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                //处理响应
                doResponse(httpServletResponse, response);
                recordMap.put("responseContentType", response.getFirstHeader("Content-Type").getValue());
                //处理响应结果
                ServletOutputStream out = httpServletResponse.getOutputStream();
                HttpEntity entity = response.getEntity();
                fileHandle(entity, out);
            } else {
//                httpServletResponse.sendError(response.getStatusLine().getStatusCode());
                String resultString = EntityUtils.toString(response.getEntity(), "UTF-8");
//                ApiErrorResponseConstants.FORWARD_ERROR(httpServletResponse, resultString);
                ApiErrorResponseConstants.response(httpServletResponse, resultString, null, "转发失败", AjaxResultType.ERROR);
                recordMap.put("forwardSuccess", false);
	        	recordMap.put("failedReasons", resultString);
            }
            recordMap.put("forwardSuccess", true);
        } catch (Exception e) {
        	recordMap.put("forwardSuccess", false);
        	recordMap.put("failedReasons", StringUtils.isNotBlank(e.getMessage())?e.getMessage():e.toString());
            throw new ApiException(e.getMessage(), e);
        } finally {
            try {
//                httpclient.close();   //关了会报连接池关闭异常
                if (null != response) {
                    response.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
	
	/**
	 * 带文件的请求转发
	 * <p>Title: multiPartRequest</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月27日
	 * @param recordMap
	 * @param fileNames
	 * @param params
	 * @param uri
	 * @param httpServletRequest
	 * @param response
	 * @param httpclient
	 * @return
	 */
	public CloseableHttpResponse multiPartRequest(Map<String,Object> recordMap, List<String> fileNames, Map<String, String> params, String uri, HttpServletRequest httpServletRequest, CloseableHttpResponse response, CloseableHttpClient httpclient) {
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) httpServletRequest;

			HttpPost httpPost = new HttpPost(uri);
	        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
	        builder.setCharset(java.nio.charset.Charset.forName("UTF-8"));
	        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
	        
	        for(String fileName:fileNames) {
	        	List<MultipartFile> multipartFiles = multipartRequest.getFiles(fileName);
	        	
	        	for (int i = 0; i < multipartFiles.size(); i++) {
	        		MultipartFile multipartFile = multipartFiles.get(i);
		            String originalFilename = multipartFile.getOriginalFilename();
		            builder.addBinaryBody(fileName, multipartFile.getInputStream(), ContentType.MULTIPART_FORM_DATA, originalFilename);// 文件流
		        }
	        }
	        
	        //决中文乱码
	        ContentType contentType = ContentType.create("text/plain", "UTF-8");
	        for (Entry<String, String> entry : params.entrySet()) {
	            if(entry.getValue() == null)
	                continue;
	            // 类似浏览器表单提交，对应input的name和value
	            builder.addTextBody(entry.getKey(), entry.getValue(), contentType);
	        }
	        HttpEntity entity = builder.build();
	        httpPost.setEntity(entity);
	        response = httpclient.execute(httpPost);// 执行提交
		} catch (Exception e) {
            throw new ApiException(e.getMessage(), e);
		}
        
        return response;
	}
	
	/**
	 * 普通请求转发
	 * <p>Title: normalRequest</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月27日
	 * @param recordMap
	 * @param reqMethod
	 * @param uri
	 * @param httpServletRequest
	 * @param response
	 * @param httpclient
	 * @return
	 */
	public CloseableHttpResponse normalRequest(Map<String,Object> recordMap, String reqMethod, String uri, HttpServletRequest httpServletRequest, CloseableHttpResponse response, CloseableHttpClient httpclient) {
        try {
			if ("POST".equals(reqMethod)) {
			    HttpPost httpPost = new HttpPost(uri);

			    //将前台的请求体放到我的请求体里
			    httpPost.setEntity(new InputStreamEntity(httpServletRequest.getInputStream()));

			    response = httpclient.execute(httpPost);
			}
			if ("GET".equals(reqMethod)) {
			    URIBuilder builder = new URIBuilder(uri);
			    Enumeration<String> enumeration = httpServletRequest.getParameterNames();
			    //将前台的参数放到我的请求里
			    while (enumeration.hasMoreElements()) {
			        String next = enumeration.nextElement();
			        builder.setParameter(next, httpServletRequest.getParameter(next));
			    }
			    HttpGet httpGet = new HttpGet(builder.build());

			    response = httpclient.execute(httpGet);
			}
		} catch (Exception e) {
            throw new ApiException(e.getMessage(), e);
		}
        
        return response;
	}
	
	/**
     * 处理响应
     *
     * @param servletRes
     * @param proxyRes
     */
    public void doResponse(HttpServletResponse servletRes, CloseableHttpResponse proxyRes) {
        // 处理消息头
        Header[] headers = proxyRes.getAllHeaders();
        if (headers != null) {
//            System.out.println("相应头");
//            log.info("响应头");
            for (Header header : headers) {
//                System.out.println(header.getName() + " : " + header.getValue());
//                log.info(header.getName() + " : " + header.getValue());
                servletRes.addHeader(header.getName(), header.getValue());
            }
        }
    }

    //非html直接返回
    public void fileHandle(HttpEntity entity, ServletOutputStream out) {
        try {
            entity.writeTo(out);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static String doGet(CloseableHttpClient httpClient, String url, Map<String, String> param) {

        String resultString = "";
        CloseableHttpResponse response = null;
        try {
            // 创建uri
            URIBuilder builder = new URIBuilder(url);
            if (param != null) {
                for (String key : param.keySet()) {
                    builder.addParameter(key, param.get(key));
                }
            }
            URI uri = builder.build();

            // 创建http GET请求
            HttpGet httpGet = new HttpGet(uri);

            // 执行请求
            response = httpClient.execute(httpGet);
            // 判断返回状态是否为200
            if (response.getStatusLine().getStatusCode() == 200) {
                resultString = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } catch (Exception e) {
            throw new ApiException(e.getMessage(), e);
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }

}