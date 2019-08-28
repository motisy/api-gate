package com.ruoyi.common.utils.http;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.io.IOUtils;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpEntityEnclosingRequestBase;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;

/**
 * 1.http连接池不是万能的,过多的长连接会占用服务器资源,导致其他服务受阻<br/>
2.http连接池只适用于请求是经常访问同一主机(或同一个接口)的情况下<br/>
3.并发数不高的情况下资源利用率低下
 * <p>Title: HttpClients</p>  
 * <p>Description: 维护各个后端服务自己的连接池</p>  
 * @author 陈阳  
 * @date 2019年8月8日
 */
public class HttpClientUtils {
	private static final Logger logger = LoggerFactory.getLogger(HttpClientUtils.class);
	
	/**
	 * 不同域名的连接池
	 */
	public static Map<String, HttpConnectionPool> clients = null;
	
	/**
	 * 请求配置
	 */
	private static final int CONNECT_TIMEOUT = Config.getHttpConnectTimeout();// 设置连接建立的超时时间为10s
    private static final int SOCKET_TIMEOUT = Config.getHttpSocketTimeout();
    
	/**
     * 对http请求进行基本设置
     * @param httpRequestBase http请求
     */
    private static void setRequestConfig(HttpRequestBase httpRequestBase){
        RequestConfig requestConfig = RequestConfig.custom().setConnectionRequestTimeout(CONNECT_TIMEOUT)
                .setConnectTimeout(CONNECT_TIMEOUT)
                .setSocketTimeout(SOCKET_TIMEOUT).build();

        httpRequestBase.setConfig(requestConfig);
    }
    
    /**
     * 设置普通请求的参数
     * @param httpPost
     * @param params
     */
    private static void setPostParams(HttpEntityEnclosingRequestBase httpRequest, Map<String, String> params){
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        Set<String> keys = params.keySet();
        for (String key: keys){
            nvps.add(new BasicNameValuePair(key, params.get(key)));
        }
        try {
        	httpRequest.setEntity(new UrlEncodedFormEntity(nvps, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 设置Multipart表单参数
     * <p>Title: setMultipartParams</p>  
     * <p>Description: </p>
     * @author 陈阳  
     * @date 2019年8月9日
     * @param httpRequest
     * @param params
     */
    private static void setMultipartParams(HttpEntityEnclosingRequestBase httpRequest, Map<String, List<MultipartFile>> files, Map<String, Object> params){
    	MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setCharset(java.nio.charset.Charset.forName("UTF-8"));
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        
        for(Entry<String, List<MultipartFile>> entry:files.entrySet()) {
        	String fileKey = entry.getKey();
        	List<MultipartFile> multipartFiles = entry.getValue();
        	String fileName = null;
	        MultipartFile multipartFile = null;
	        for (int i = 0; i < multipartFiles.size(); i++) {
	            multipartFile = multipartFiles.get(i);
	            fileName = multipartFile.getOriginalFilename();
	            try {
					builder.addBinaryBody(fileKey, multipartFile.getInputStream(), ContentType.MULTIPART_FORM_DATA, fileName);
				} catch (IOException e) {
					logger.info("添加文件参数失败");
				}// 文件流
	        }
        }
        //决中文乱码
        ContentType contentType = ContentType.create("text/plain", Consts.UTF_8);
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            if(entry.getValue() == null)
                continue;
            // 类似浏览器表单提交，对应input的name和value
            builder.addTextBody(entry.getKey(), entry.getValue().toString(), contentType);
        }
        HttpEntity entity = builder.build();
        httpRequest.setEntity(entity);
    }
	
	/**
	* post提交multipart/form-data数据实现多文件上传
	* @param url 请求地址
	* @param multipartFiles post提交的文件列表
	* @param fileParName fileKey
	* @param params 附带的文本参数
	* @param timeout 请求超时时间(毫秒)
	* @return
	* @author alexli
	* @date 2018年5月8日 上午10:26:15
	*/
	public static Map<String, String> multipartPost(CloseableHttpClient httpClient, String url, Map<String, List<MultipartFile>> files, Map<String, Object> params) {
	    Map<String, String> resultMap = new HashMap<String, String>();
	    String result = "";
	    try {
	    	HttpPost httpPost = new HttpPost(url);
	    	setMultipartParams(httpPost, files, params);
	        HttpResponse response = httpClient.execute(httpPost);// 执行提交

	        // 设置连接超时时间
	        setRequestConfig(httpPost);

	        HttpEntity responseEntity = response.getEntity();
	        resultMap.put("scode", String.valueOf(response.getStatusLine().getStatusCode()));
	        resultMap.put("data", "");
	        if (responseEntity != null) {
	            // 将响应内容转换为字符串
	            result = EntityUtils.toString(responseEntity, java.nio.charset.Charset.forName("UTF-8"));
	            resultMap.put("data", result);
	        }
	    } catch (Exception e) {
	        resultMap.put("scode", "error");
	        resultMap.put("data", "HTTP请求出现异常: " + e.getMessage());

	        Writer w = new StringWriter();
	        e.printStackTrace(new PrintWriter(w));
	        logger.error("HTTP请求出现异常: " + w.toString());
	    } finally {
	        try {
	            httpClient.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return resultMap;
	}
	
	/**
	 * json格式post方式提交数据
	 * <p>Title: post</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月9日
	 * @param httpClient
	 * @param url
	 * @param params
	 * @return
	 */
	public static JSONObject postJson(CloseableHttpClient httpClient, String url, Map<String, String> params){
        HttpPost httpPost = new HttpPost(url);
        setRequestConfig(httpPost);
        setPostParams(httpPost, params);
        CloseableHttpResponse response = null;
        InputStream in = null;
        JSONObject object = null;
        try {
            response = httpClient.execute(httpPost, HttpClientContext.create());
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                in = entity.getContent();
                String result = IOUtils.toString(in, "utf-8");
                object = JSONObject.parseObject(result);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try{
                if (in != null) in.close();
                if (response != null) response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return object;
    }
	
	public static JSONObject getJson(CloseableHttpClient httpClient, String url, Map<String, String> params){
		URI uri = null;
		try {
			// 创建uri
			URIBuilder builder = new URIBuilder(url);
			if (params != null) {
			    for (String key : params.keySet()) {
			        builder.addParameter(key, params.get(key));
			    }
			}
			uri = builder.build();
		} catch (URISyntaxException e1) {
			e1.printStackTrace();
		}

        // 创建http GET请求
        HttpGet httpGet = new HttpGet(uri);
        
        
        setRequestConfig(httpGet);
        CloseableHttpResponse response = null;
        InputStream in = null;
        JSONObject object = null;
        try {
            response = httpClient.execute(httpGet, HttpClientContext.create());
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                in = entity.getContent();
                String result = IOUtils.toString(in, "utf-8");
                object = JSONObject.parseObject(result);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try{
                if (in != null) in.close();
                if (response != null) response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return object;
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
            e.printStackTrace();
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
                httpClient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }

    public static String doPost(CloseableHttpClient httpClient, String url, Map<String, String> param) {
        // 创建Httpclient对象
        CloseableHttpResponse response = null;
        String resultString = "";
        try {
            // 创建Http Post请求
            HttpPost httpPost = new HttpPost(url);
            // 创建参数列表
            if (param != null) {
                List<NameValuePair> paramList = new ArrayList<>();
                for (String key : param.keySet()) {
                    paramList.add(new BasicNameValuePair(key, param.get(key)));
                }
                // 模拟表单
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(paramList);
                httpPost.setEntity(entity);
            }
            // 执行http请求
            response = httpClient.execute(httpPost);
            resultString = EntityUtils.toString(response.getEntity(), "utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return resultString;
    }
	
	public static void main(String[] args) throws InterruptedException {
		HttpConnectionPool httpclientPool = new HttpConnectionPool("http://192.168.8.132", 8080);
		CloseableHttpClient httpclient = httpclientPool.getHttpClient();
		
		Map<String, String> params = new HashMap<>();
		params.put("id", "1");
		
		JSONObject json = HttpClientUtils.getJson(httpclient, "http://192.168.8.132:8080/app/user/getUserById", params);
		System.out.println(json.toJSONString());
		Thread.sleep(10000);
		System.out.println("关闭连接池");
		httpclientPool.closeConnectionPool();
	}
}
