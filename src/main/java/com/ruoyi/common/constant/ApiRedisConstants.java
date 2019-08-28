package com.ruoyi.common.constant;

public class ApiRedisConstants {
	/**
	 * api的url字符串，set结构，用于快速判断是否存在api，set里的值是url
	 */
	public final static String API_URL = "api_url";
	
	/**
	 * api的url字符串,sortSet结构，按照url路径长度从大到小排列，用于匹配访问请求
	 */
	public final static String API_URL_SORT = "api_url_sort";
	
	/**
	 * api实体类，为了快速获取实体信息，而不进行sql查询，map结构，map中key是url
	 */
	public final static String API_URL_ENTITY = "api_url_entity";
	
	/**
	 * api配置的限制参数，kv结构，key是API_URL_PARAM+url
	 */
	public final static String API_URL_PARAM = "api_url_param";
	
	/**
	 * 账号分配了权限的api，set结构，key是ACCOUNT_API+appKey
	 */
	public final static String ACCOUNT_API = "account_api";
	
	/**
	 * 具体的账号权限，map结构，key是ACCOUNT_API_LIMIT+appKey，map中key是url，v是AccountApiLimit
	 */
	public final static String ACCOUNT_API_LIMIT = "account_api_limit";
	
	/**
	 * 某账号对某api的剩余调用次数限制，kv结构，key是ACCOUNT_API_LIMIT_REST_NUMBER+appKey+url，value是数值
	 */
	public final static String ACCOUNT_API_LIMIT_REST_NUMBER = "account_api_limit_rest_number";
	
	/**
	 * 后端服务器，，map结构，map中的key是serverId
	 */
	public final static String API_SERVER = "api_server";
	
}
