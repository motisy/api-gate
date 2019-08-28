package com.ruoyi.project.api.server.service;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.server.domain.ApiServerGroup;
import com.ruoyi.project.api.server.domain.ApiServerGroupExample;

/**
 * api服务 服务层
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiServerGroupService extends XmlBaseService<ApiServerGroup, Long, ApiServerGroupExample>
{

	String checkNameUnique(ApiServerGroup serverGroup);
	
}
