package com.ruoyi.framework.apprinitunner;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.http.HttpClientUtils;
import com.ruoyi.common.utils.http.HttpConnectionPool;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.project.api.account.service.IApiAccountService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.service.IApiServerService;

/**
 * 
 * <p>Title: ApplicationRunnerImpl</p>  
 * <p>Description: 在spring boot项目启动后执行</p>  
 * @author 陈阳  
 * @date 2019年8月8日
 */
@Component
public class ApplicationInitRunnerImpl implements ApplicationRunner {
	
	@Autowired
	private IApiUrlService apiService;
	
	
	@Autowired
	private IApiAccountService accountService;
	
	@Autowired
	private RedisUtil redisUtil;
	
    @Override
    public void run(ApplicationArguments args) throws Exception {
    	IApiServerService apiServerService = SpringUtils.getBean(IApiServerService.class);
    	
    	//初始化后端服务
    	List<ApiServer> servers = apiServerService.selectByExample(null);
    	HttpClientUtils.clients = new HashMap<String, HttpConnectionPool>(servers.size());
    	for(ApiServer server : servers) {
    		HttpClientUtils.clients.put(server.getServerUrl(), new HttpConnectionPool(server.getServerDomain(), server.getServerPort()));
    		apiServerService.serverAutoCheck(server);
    	}
    	
    	redisUtil.del(ApiRedisConstants.API_SERVER);
    	redisUtil.deleteByPrex(ApiRedisConstants.API_URL+"*");
    	redisUtil.deleteByPrex(ApiRedisConstants.ACCOUNT_API+"*");
    	
    	//服务器缓存
    	apiServerService.refreshApiServerCache();
    	
    	//缓存所有api至redis
    	apiService.refreshApiUrlCache();
    	
    	//缓存account的api权限
		accountService.refreshAccountApiUrlCache();
//    	Set<Object> ss = redisUtil.sGet("account_api1hGBBbzU0F");
//    	System.out.println(ss);
    }
}
