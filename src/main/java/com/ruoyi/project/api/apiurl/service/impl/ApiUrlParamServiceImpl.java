package com.ruoyi.project.api.apiurl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParam;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParamExample;
import com.ruoyi.project.api.apiurl.mapper.ApiUrlParamMapper;
import com.ruoyi.project.api.apiurl.service.IApiUrlParamService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiUrlParamServiceImpl extends XmlBaseServiceImpl<ApiUrlParam, Long, ApiUrlParamMapper, ApiUrlParamExample> implements IApiUrlParamService
{

	@Autowired
	private RedisUtil redisUtil;
	
	@Override
	public void refreshApiUrlParamCache(ApiUrl api, boolean del) {
		String k = ApiRedisConstants.API_URL_PARAM+api.getApiUrlSuffix();
		redisUtil.del(k);
		
		if(del==false) {
			ApiUrlParamExample example = new ApiUrlParamExample();
			example.createCriteria().andApiIdEqualTo(api.getApiId());
			List<ApiUrlParam> params = selectByExample(example);
			Map<String, ApiUrlParam> map = new HashMap<>();
			for(ApiUrlParam p:params) {
				map.put(p.getParamName(), p);
			}
			redisUtil.set(k, map);
		}
	}

}
