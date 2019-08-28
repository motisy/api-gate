package com.ruoyi.project.api.server.service;

import java.util.List;
import java.util.Map;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.domain.ApiServerExample;
import com.ruoyi.project.api.server.domain.ApiServerGroup;

/**
 * api服务 服务层
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiServerService extends XmlBaseService<ApiServer, Long, ApiServerExample>
{

	String checkNameUnique(ApiServer server);
	
	String checkCodeUnique(ApiServer server);

	Map<ApiServerGroup, List<ApiServer>> allGroups();
	
	void refreshApiServerCache();
	
	void delServerAutoCheckJob(Long serverId);
	
	void serverAutoCheck(ApiServer server);
}
