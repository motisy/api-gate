package com.ruoyi.project.api.apiurl.service;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParam;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParamExample;

/**
 * api服务 服务层
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiUrlParamService extends XmlBaseService<ApiUrlParam, Long, ApiUrlParamExample>
{
	void refreshApiUrlParamCache(ApiUrl api, boolean del);
}
