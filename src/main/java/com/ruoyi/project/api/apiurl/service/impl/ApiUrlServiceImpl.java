package com.ruoyi.project.api.apiurl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.loadbalance.LoadBanlanceUtil;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.mapper.ApiUrlMapper;
import com.ruoyi.project.api.apiurl.service.IApiUrlParamService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiUrlServiceImpl extends XmlBaseServiceImpl<ApiUrl, Long, ApiUrlMapper, ApiUrlExample> implements IApiUrlService
{

	@Autowired
	RedisUtil redisUtil;
	
	@Autowired
	IApiUrlParamService apiParamService;
	
	@Override
	public String checkNameUnique(ApiUrl server) {
		Long id = StringUtils.isNull(server.getApiId()) ? -1L : server.getApiId();
		
		ApiUrlExample example = new ApiUrlExample();
		example.createCriteria().andApiNameEqualTo(server.getApiName());
		List<ApiUrl> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getApiId()!=id)
        {
            return "1";
        }
        return "0";
	}

	private void zset(String ...values) {
		for(String s:values) {
			redisUtil.ZSet(ApiRedisConstants.API_URL_SORT, s, ((Integer)s.split("/").length).doubleValue());
		}
	}
	
	@Override
	public void refreshApiUrlCache() {
		//缓存所有api至redis
    	List<ApiUrl> apis = selectByExample(null);
    	redisUtil.deleteByPrex(ApiRedisConstants.API_URL+"*");
    	redisUtil.del(ApiRedisConstants.API_URL);
    	redisUtil.del(ApiRedisConstants.API_URL_ENTITY);
    	redisUtil.deleteByPrex(ApiRedisConstants.API_URL_PARAM+"*");
    	Map<Object,Object> map = new HashMap<>();
    	for(ApiUrl api:apis) {
    		redisUtil.sSet(ApiRedisConstants.API_URL, api.getApiUrlSuffix());
    		
    		zset(api.getApiUrlSuffix());
    		
    		map.put(api.getApiUrlSuffix(), api);
    		
    		apiParamService.refreshApiUrlParamCache(api, false);
    		
    	}
    	LoadBanlanceUtil.refresh(apis);
    	redisUtil.hmset(ApiRedisConstants.API_URL_ENTITY, map);
	}
}
