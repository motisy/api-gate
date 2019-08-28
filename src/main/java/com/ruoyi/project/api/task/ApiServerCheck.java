package com.ruoyi.project.api.task;

import org.apache.http.impl.client.CloseableHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ruoyi.common.utils.JsonParseUtil;
import com.ruoyi.common.utils.http.ApiForwardUtil;
import com.ruoyi.common.utils.http.HttpClientUtils;
import com.ruoyi.common.utils.http.HttpConnectionPool;
import com.ruoyi.common.utils.loadbalance.LoadBanlanceUtil;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.service.IApiServerService;

/**
 * 检查server的状态，通过server中设置的检查url的结果来验证
 * @author 陈阳
 *
 */
@Component("apiServerCheck")
public class ApiServerCheck {
	
	@Autowired
	private IApiServerService apiServerService;
	
	public void check(Long serverId) {
		ApiServer apiServer = apiServerService.selectByPrimaryKey(serverId);
		String uri = apiServer.getServerCheckUrl();
		
		String result = null;
		
		CloseableHttpClient httpclient = null;
		try {
			String httpConnectionPoolKey = apiServer.getServerUrl();
			HttpConnectionPool httpConnectionPool = HttpClientUtils.clients.get(httpConnectionPoolKey);
			httpclient = httpConnectionPool.getHttpClient();
		} catch (Exception e1) {
			//没拿到就不管，连接池出错，一般不得出问题
			e1.printStackTrace();
			return;
		}
        try {
	        result = ApiForwardUtil.doGet(httpclient, uri, null);
        }catch (Exception e) {
        	//没拿到结果，说明服务器出错了
        	//置为失效
			serverDown(apiServer);
			return;
		}
        
        //拿到了结果，进行验证
        if(apiServer.getServerAutoCheck()) {
			switch (apiServer.getCheckResultType()) {
			case "string":
				//检查结果为正常时
				if((apiServer.getCheckType().equals("contain") && result.contains(apiServer.getCheckValue()))
						|| (apiServer.getCheckType().equals("notContain") && !result.contains(apiServer.getCheckValue())) ) {
					//原结果失效重置为正常
					if(!apiServer.getServerLive()) {
						//置为正常
						serverRun(apiServer);
					}
				}else {
					//检查不正常，但原结果为正常
					if(apiServer.getServerLive()) {
						//置为失效
						serverDown(apiServer);
					}
				}
				break;
			case "json":
				//检查结果为正常时
				String val = null;
				try {
					val = JsonParseUtil.getNodeValue(result, apiServer.getCheckJsonKey().startsWith("JSON")?apiServer.getCheckJsonKey():("JSON."+apiServer.getCheckJsonKey()));
				} catch (Exception e) {
					e.printStackTrace();
				}
				if((apiServer.getCheckValue().equals(val) && apiServer.getCheckType().equals("contain"))
						||(!apiServer.getCheckValue().equals(val) && apiServer.getCheckType().equals("notContain"))) {
					//原结果失效重置为正常
					if(!apiServer.getServerLive()) {
						//置为正常
						serverRun(apiServer);
					}
				}else {
					//检查不正常，但原结果为正常
					if(apiServer.getServerLive()) {
						serverDown(apiServer);
					}
				}
				break;
			default:
				break;
			}
		}
	}
	
	public void serverDown(ApiServer apiServer) {
		apiServer.setServerLive(false);
		apiServerService.updateByPrimaryKeySelective(apiServer);
		//变化了，需要重置缓存
		LoadBanlanceUtil.reloadLoadBanlanceSelector(apiServer.getServerId());
	}
	
	public void serverRun(ApiServer apiServer) {
		apiServer.setServerLive(true);
		apiServerService.updateByPrimaryKeySelective(apiServer);
		//变化了，需要重置缓存
		LoadBanlanceUtil.reloadLoadBanlanceSelector(apiServer.getServerId());
	}
}
