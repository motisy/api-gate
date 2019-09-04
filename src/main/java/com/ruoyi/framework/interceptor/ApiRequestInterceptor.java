package com.ruoyi.framework.interceptor;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.IteratorUtils;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.constant.ApiErrorResponseConstants;
import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.AddressUtils;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IpUtils;
import com.ruoyi.common.utils.MyMD5Util;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.http.ApiForwardUtil;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimit;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParam;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.record.service.IApiRequestRecordService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ApiRequestInterceptor extends HandlerInterceptorAdapter  {

	@Autowired
	RedisUtil redisUtil;
	
	@Autowired
	IApiUrlService apiUrlService;
	
	@Autowired
    private ApiConfig apiConfig;
	
	@Autowired
    private ApiForwardUtil apiForwardUtil;
	
	@Autowired
    private IApiRequestRecordService recordService;
	
	/**
	 * 数字匹配正则
	 */
	public static Pattern numberPattern = Pattern.compile("^[-\\+]?[\\d]*$");  
	
	/**
	 * 自定义正则缓存
	 */
	private static Map<String, Pattern> regexPatternCache = new HashMap<>();
	
	/**
	 * 拦截逻辑
	 */
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
		boolean forwarded = false;
		Map<String, Object> recordMap = new HashMap<>();
		//拿到参数用于校验
		Map<String, String> params = new HashMap<>();
		List<String> fileNames = new ArrayList<String>();
		long startTime = System.currentTimeMillis();
		try {
			//请求地址
			String requestUrl = request.getRequestURI();
			if(StringUtils.isNoneBlank(apiConfig.getContextPath())) {
				requestUrl = requestUrl.replace(apiConfig.getContextPath(), "");
			}
			if(StringUtils.isNoneBlank(apiConfig.getPreurl())) {
				requestUrl = requestUrl.replace(apiConfig.getPreurl(), "");
			}
			
			ApiUrl apiUrl = null;
			ApiAccount account = new ApiAccount();
			
			//匹配到的apiUrl后缀
			String apiUrlMatch = hasApi(requestUrl);
			try {
				
				//判断api是否存在
				if(apiUrlMatch!=null) {
					apiUrl = (ApiUrl) redisUtil.hmget(ApiRedisConstants.API_URL_ENTITY).get(apiUrlMatch);
				}else {
					return ApiErrorResponseConstants.API_NOT_EXISTS(response, null);
				}
				
			} catch (Exception e1) {
				e1.printStackTrace();
				return ApiErrorResponseConstants.API_NOT_EXISTS(response, null);
			}
			
			if (!apiUrl.getApiRequestMethod().equals("GET/POST") && !request.getMethod().equals(apiUrl.getApiRequestMethod())) {
				return ApiErrorResponseConstants.REQUEST_METHOD_NOTSUPPORT(response, null);
			}
			
			// 检测是否为多媒体上传
			if (!ServletFileUpload.isMultipartContent(request)) {
				buildParamMap(request.getParameterMap(), params);
			}else {
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				buildParamMap(multipartRequest.getParameterMap(), params);
				fileNames = IteratorUtils.toList(multipartRequest.getFileNames());
			}
			
			
			//如果是访问api
//		String apiPreurl = apiConfig.getPreurl();
			//判断有无账号
			String appKey = params.get("appKey");
			String appScrect = params.get("appScrect");
			
			if(StringUtils.isBlank(appKey) || StringUtils.isBlank(appScrect)) {
				return ApiErrorResponseConstants.PARAM_WRONG(response, "appKey和appScrect不能为空");
			}
			
			try {
				String md5 = MyMD5Util.md5(appKey, apiConfig.getMd5key());
				if(!md5.equals(appScrect)) {
					return ApiErrorResponseConstants.PARAM_WRONG(response, "appKey和appScrect不正确");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			account.setAppKey(appKey);
			account.setAppScrect(appScrect);
			
			//判断account是否有权限
			if(!accountHasApi(appKey, apiUrl.getApiUrlSuffix())) {
				return ApiErrorResponseConstants.ACCOUNT_NO_API_ACCESS(response, null);
			}
			//校验权限规则
			if(!checkLimit(response, appKey, apiUrl.getApiUrlSuffix())) {
				return false;
			}
			
			//校验参数
			if(apiUrl.getApiUrlSuffix().indexOf("*")<0) {
				if(!checkParam(fileNames, params, response, appKey, apiUrl.getApiUrlSuffix())) {
					return false;
				}
			}
			
			//放置记录参数
			recordMap.put("appKey", appKey);
			recordMap.put("apiId", apiUrl.getApiId());
			recordMap.put("requestUrl", request.getRequestURL().toString());
			recordMap.put("requestUrI", request.getRequestURI());
			String ip = IpUtils.getIpAddr(request);
			recordMap.put("requestIp", ip);
			recordMap.put("requestLocation", AddressUtils.getRealAddressByIP(ip));
			recordMap.put("requestMethod", request.getMethod());
			
			
			//转发请求
			log.info("请求："+request.getRequestURL());
			forwarded = true;
			apiForwardUtil.forward(recordMap, fileNames, params, request, response, apiUrl, account);
		} catch (Exception e) {
			e.printStackTrace();
			return ApiErrorResponseConstants.ERROR(response, null);
		} finally {
			if(forwarded) {
				long endTime = System.currentTimeMillis();
				recordMap.put("useTime", ((Long)(endTime-startTime)).intValue());
				params.remove("appKey");
				params.remove("appScrect");
				recordService.asyncRecord(recordMap, request, params, fileNames);
			}
		}
		
		return false;
	}
	
	/**
	 * 参数转配普通map
	 * <p>Title: buildParamMap</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月21日
	 * @param parameterMap
	 * @param param
	 */
	private void buildParamMap(Map<String, String[]> parameterMap, Map<String, String> param) {
        for (Entry<String, String[]> entry : parameterMap.entrySet()) {
            String key = entry.getKey();
            String[] value = entry.getValue();
            if (!ArrayUtils.isEmpty(value)) {
                if (StringUtils.isNotBlank(value[0])) {
                    param.put(key, value[0]);
                }
            } else {
                continue;
            }
        }
    }

	/**
	 * 判断请求地址是否在权限api中，支持通配符匹配，先匹配普通url再匹配通配符，匹配按照最长路径优先的规则
	 * <p>Title: hasApi</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月21日
	 * @param requestUrl 请求地址
	 * @return 匹配到的api后缀，未匹配到就返回null
	 */
	public String hasApi(String requestUrl) {
		if(StringUtils.isBlank(requestUrl)) {
			return null;
		}
		Set<Object> ss = redisUtil.ZGet(ApiRedisConstants.API_URL_SORT);
		
//		Set<Object> sortSet = new TreeSet<Object>(new Comparator<Object>() {
//            @Override
//            public int compare(Object o1, Object o2) {
//                return o2.toString().split("/").length-o1.toString().split("/").length;//降序排列
//            }
//        });
//        sortSet.addAll(ss);
		
		if(ss.contains(requestUrl)) {
			return requestUrl;
		}else {
			//匹配*模式
			for(Object s:ss) {
				if(s.toString().indexOf("*")>0) {
					//看是不是直接访问没有后缀
					if(s.toString().substring(0, s.toString().length()-2).equals(requestUrl)) {
						return s.toString();
					}
					if(wildcardMatch(requestUrl.toCharArray(), s.toString().toCharArray())) {
						return s.toString();
					}
				}
			}
			return null;
		}
	}
	
	/**
	 * 检查账号是否有api权限
	 * <p>Title: accountHasApi</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月21日
	 * @param appKey
	 * @param url
	 * @return
	 */
	public Boolean accountHasApi(String appKey, String url) {
		String k = ApiRedisConstants.ACCOUNT_API+appKey;
		Set<Object> ss = redisUtil.sGet(k);
		return ss.contains(url);
	}
	
	/**
	 * 检查访问次数限制
	 * <p>Title: checkLimit</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月20日
	 * @param reponse
	 * @param appKey
	 * @param url
	 * @return
	 */
	public boolean checkLimit(HttpServletResponse reponse, String appKey, String url) {
		String k2 = ApiRedisConstants.ACCOUNT_API_LIMIT+appKey;
		Map<Object, Object> map = redisUtil.hmget(k2);
		AccountApiLimit o = (AccountApiLimit) map.get(url);
		if(!o.getHasLimit()) {
			//无限制
			return true;
		}else {
			//有限制，检查一下,限制类型，time_limit是时间范围内次数限制，total_limit是总次数限制
			String limitType = o.getLimitType();
			
			String k = ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+appKey+url;
			Object restNumber = redisUtil.get(k);
			
			if(limitType.equals(AccountApiLimit.LIMIT_TYPE_TOTAL)) {
				if(restNumber==null) {
					redisUtil.set(k, o.getLimitNumber());
					redisUtil.decr(k, 1);
				}else {
					if(Integer.parseInt(restNumber.toString())>0) {
						redisUtil.decr(k, 1);
					}else {
						return ApiErrorResponseConstants.ACCOUNT_API_REQUESTTIMES_LIMIT(reponse, null);
					}
				}
			}else {
				//时间范围的单位，minute/hour/day
				String unit = o.getLimitTimeUnit();
				
				if(restNumber==null) {
					redisUtil.set(k, o.getLimitNumber());
					if(!unit.equals("day")) {
						redisUtil.expire(k, o.getLimitTimeNumber()* (unit.equals("minute")?60:3600));
					}else {
						//过期时间设为零点
						String date = DateUtils.getDate()+" 11:59:59";
						try {
							redisUtil.expireAt(k, DateUtils.parseDate(date, DateUtils.YYYY_MM_DD_HH_MM_SS));
						} catch (ParseException e) {
							e.printStackTrace();
						}
					}
					redisUtil.decr(k, 1);
				}else {
					if(Integer.parseInt(restNumber.toString())>0) {
						redisUtil.decr(k, 1);
					}else {
						return ApiErrorResponseConstants.ACCOUNT_API_REQUESTTIMES_LIMIT(reponse, null);
					}
				}
			}
			
			return true;
		}
	}
	
	/**
	 * 检查参数配置
	 * <p>Title: checkParam</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月20日
	 * @param params
	 * @param reponse
	 * @param appKey
	 * @param url
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean checkParam(List<String> fileNames, Map<String, String> params, HttpServletResponse reponse, String appKey, String url) {
		params.remove("appKey");
		params.remove("appScrect");
		String k = ApiRedisConstants.API_URL_PARAM+url;
		Object k_value = redisUtil.get(k);
		//所有的参数配置
		Map<String, ApiUrlParam> urlParams;
		if(k_value==null) {
			urlParams = new HashMap<>();
		}else {
			urlParams = (Map<String, ApiUrlParam>) k_value;
		}
		
		//提交的参数个数不能大于参数配置的个数
		if((params.size())>urlParams.size()) {
			return ApiErrorResponseConstants.PARAM_WRONG(reponse, "提交的参数过多，请不要提交多余的参数！");
		}
		//检查必填参数
		List<String> requiredParamButEmpty = new ArrayList<>();
		//检查参数类型
		List<String> paramTypeNotmatch = new ArrayList<>();
		//正则表达式检查
		List<String> paramRegexNotmatch = new ArrayList<>();
		for(Entry<String, ApiUrlParam> entry:urlParams.entrySet()) {
			String paramName = entry.getKey();
			ApiUrlParam urlParam = entry.getValue();
			if(urlParam.getParamRequired() && (params.get(paramName)==null || StringUtils.isBlank(params.get(paramName))) && !fileNames.contains(paramName)) {
				requiredParamButEmpty.add(paramName);
			}else{
				//有值的话
				String value = params.get(paramName);
				if(StringUtils.isNotBlank(value)) {
					//检查类型
//					string,number,date,boolean,json,file,other
					switch (urlParam.getParamType()) {
					case "number":
				        if(!numberPattern.matcher(value).matches()) {
				        	paramTypeNotmatch.add("参数"+paramName+"应该是数字");
				        }
						break;
					case "date":
						Date d = DateUtils.parseDate(value);
						if(d==null) {
							paramTypeNotmatch.add("参数"+paramName+"应该是日期");
						}
						break;
					case "boolean":
						if(!(value.equals("1") || value.equals("0") || value.equals("true") ||value.equals("false"))) {
							paramTypeNotmatch.add("参数"+paramName+"应该是布尔值");
						}
						break;
					case "json":
						try {
							if(!isJson(value)) {
								paramTypeNotmatch.add("参数"+paramName+"应该是json格式");
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
						break;
					case "file":
//						if(fileMap.get(paramName)==null) {
							paramTypeNotmatch.add("参数"+paramName+"应该是文件");
//						}
						break;
					default:
						break;
					}
					
					//检查正则
					if(StringUtils.isNotBlank(urlParam.getParamCheckRegex())) {
						Pattern pattern = regexPatternCache.get(urlParam.getParamCheckRegex());
						if(pattern!=null) {
							if(!pattern.matcher(value).matches()) {
								paramRegexNotmatch.add(paramName);
							}
						}else {
							Pattern p = Pattern.compile(urlParam.getParamCheckRegex());
							regexPatternCache.put(urlParam.getParamCheckRegex(), p);
							if(!p.matcher(value).matches()) {
								paramRegexNotmatch.add(paramName);
							}
						}
					}
				}else {
					if(fileNames.contains(paramName)) {
						if(!urlParam.getParamType().equals("file")) {
							paramTypeNotmatch.add("参数"+paramName+"应该是文件");
						}
					}
				}
			}
		}
		if(requiredParamButEmpty.size()>0) {
			return ApiErrorResponseConstants.PARAM_WRONG(reponse, "参数"+StringUtils.join(requiredParamButEmpty, ",")+"不能为空！");
		}
		if(paramTypeNotmatch.size()>0) {
			return ApiErrorResponseConstants.PARAM_WRONG(reponse, StringUtils.join(paramTypeNotmatch, ","));

		}
		if(paramRegexNotmatch.size()>0) {
			return ApiErrorResponseConstants.PARAM_WRONG(reponse, "参数"+StringUtils.join(paramRegexNotmatch, ",")+"校验未通过！");

		}
		
		//检查是否有其他参数
		for(Entry<String, String> entry:params.entrySet()) {
			String paramName = entry.getKey();
			ApiUrlParam urlParam = urlParams.get(paramName);
			
			if(urlParam==null) {
				
				return ApiErrorResponseConstants.PARAM_WRONG(reponse, "请不要提交不相关的参数！");
			}
		}
		for(String fileNameKey:fileNames) {
			if(urlParams.get(fileNameKey)==null) {
				return ApiErrorResponseConstants.PARAM_WRONG(reponse, "请不要提交不相关的参数！");
			}
			
		}
		
		return true;
	}
	
	private boolean isJson(String text) {
		try {
			JSONObject.parseObject(text);
			return true;
		} catch (Exception e) {
			try {
				JSONArray.parseArray(text);
				return true;
			} catch (Exception e2) {
				return false;
			}
		}
	}
	
	/**
     * 通配符验证 strsc 是否包含 strc
     * @param strc
     * @param strsc 标准串
     * @return
     */
    public static boolean wildcardMatch(char[] strc, char[] strsc){
        int cl = strc.length;
        int scl = strsc.length;
        int cli = 0;
        int i = 0;
        boolean next = false; // 通配符查找模式
        boolean prOk = false; // 上一次匹配成功
        int ni = 0;
        for (; i < scl; i++) {
            char n = strsc[i];
            char bn = strc[cli];
            if (n == '*') {
                if (!prOk)
                    return false; // 说明 两星号之间的部分判断失败
                else if (i == scl -1)
                    return true;// 最后一位为 * 号 上一位相等 条件成立
                ni = i;
                next = true;
                prOk = false;
                continue; // 继续匹配
            }
            if (!(prOk = bn == n) && !next) { // 非匹配模式下 条件不成立
                return false;
            }
            if (next && !prOk) {
                i = ni; // 统配符模式匹配失败 标准串下标原地等待
            }
            if (++cli >= cl)
                return prOk && i + 1 == scl ; // 长度不匹配
        }
        return prOk && cli == cl;
    }
	
    /**
	 * 通配符匹配
	 * <p>Title: wildcardMatch</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月21日
	 * @param s
	 * @param p
	 * @return
	 */
	public static boolean wildcardMatch2(String s, String p) {
		int i = 0;
		int j = 0;
		int starIndex = -1;
		int iIndex = -1;
	 
		while (i < s.length()) {
			if (j < p.length() && (p.charAt(j) == '?' || p.charAt(j) == s.charAt(i))) {
				++i;
				++j;
			} else if (j < p.length() && p.charAt(j) == '*') {
				starIndex = j;		
				iIndex = i;
				j++;//'*' can match 0 or above 0 characters
			} else if (starIndex != -1) {
	                       //such as "abggggb","*b"  
	                       //so every time matching starts form the fisrt index of *
	                       //can avoid the case above
	                        j = starIndex + 1;
				i = iIndex+1;
				iIndex++;
			} else {
				return false;
			}
		}
	 
		while (j < p.length() && p.charAt(j) == '*') {
			++j;
		}
	 
		return j == p.length();
	}
}
