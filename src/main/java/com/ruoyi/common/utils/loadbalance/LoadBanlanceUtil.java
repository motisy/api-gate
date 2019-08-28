package com.ruoyi.common.utils.loadbalance;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.loadbalance.weightroundrobin.WeightedRoundRobin;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.server.domain.ApiServer;

public class LoadBanlanceUtil {
	private static ConcurrentHashMap<String, ILoadBanlance> loadBanlances = new ConcurrentHashMap<>();

	public synchronized static void refresh(List<ApiUrl> apis) {
		loadBanlances.clear();
		for(ApiUrl api:apis) {
			addApiLoadBanlance(api);
		}
	}
	
	/**
	 * 添加选择器至缓存
	 * @param api
	 * @return
	 */
	public synchronized static ILoadBanlance addApiLoadBanlance(ApiUrl api) {
		ILoadBanlance loadBanlance = null;
		
//		loadBanlances.remove(api.getApiUrlSuffix());
		
		RedisUtil redisUtil = SpringUtils.getBean(RedisUtil.class);
		
		String serverIds[] = api.getApiServerIds().split(",");
		List<ApiServer> apiservers = new ArrayList<ApiServer>();
		for(int i=0; i< serverIds.length; i++) {
			Object vv = redisUtil.hmget(ApiRedisConstants.API_SERVER).get(serverIds[i]);
			if(vv!=null && ((ApiServer)vv).getServerLive()) {
				apiservers.add((ApiServer)vv);
			}
		}
		
		String loadBanlanceType = api.getApiServerRequestWay();
		switch (loadBanlanceType) {
		default:
			//"weight_round_robin"
			ApiServer[] ss = new ApiServer[apiservers.size()];
			apiservers.toArray(ss);
			
			WeightedRoundRobin weightedRoundRobin = new WeightedRoundRobin();
			weightedRoundRobin.addServer(ss);
			loadBanlances.put(api.getApiUrlSuffix(), weightedRoundRobin);
			loadBanlance = weightedRoundRobin;
			break;
		}
		
		return loadBanlance;
	}
	
	/**
	 * 当server状态改变时，更新负载均衡选择器的缓存
	 * @param server
	 */
	public synchronized static void reloadLoadBanlanceSelector(Long serverId) {
		IApiUrlService apiUrlService = SpringUtils.getBean(IApiUrlService.class);
		List<ApiUrl> shouldUpdate = new ArrayList<>();
		
		ApiUrlExample example = new ApiUrlExample();
		ApiUrlExample.Criteria c1 = example.createCriteria();
		c1.andApiServerIdsEqualTo(serverId.toString());
		
		ApiUrlExample.Criteria c2 = example.createCriteria();
		c2.andApiServerIdsLike("%"+serverId+",%");
		
		ApiUrlExample.Criteria c3 = example.createCriteria();
		c3.andApiServerIdsLike("%,"+serverId+"%");
		
		ApiUrlExample.Criteria c4 = example.createCriteria();
		c4.andApiServerIdsLike("%,"+serverId+",%");
		
		example.or(c2);
		example.or(c3);
		example.or(c4);
		
		shouldUpdate = apiUrlService.selectByExample(example);
		
		for(ApiUrl u :shouldUpdate) {
			loadBanlances.remove(u.getApiUrlSuffix());
			addApiLoadBanlance(u);
		}
	}
	
	/**
	 * 通过api的负载均衡方式来进行服务器的选择
	 * @param api
	 * @return
	 */
	public static ApiServer selectServer(ApiUrl api) {
		ILoadBanlance loadBanlance = loadBanlances.get(api.getApiUrlSuffix());
		if(loadBanlance==null) {
			loadBanlance = addApiLoadBanlance(api);
		}
		
		return loadBanlance.selectServer();
	}
}
