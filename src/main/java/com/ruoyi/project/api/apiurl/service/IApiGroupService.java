package com.ruoyi.project.api.apiurl.service;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.apiurl.domain.ApiGroup;
import com.ruoyi.project.api.apiurl.domain.ApiGroupExample;

/**
 * api分组
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiGroupService extends XmlBaseService<ApiGroup, Long, ApiGroupExample>
{

	String checkNameUnique(ApiGroup apiGroup);
	
}
