package com.ruoyi.project.api.server.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.project.api.server.domain.ApiServerGroup;
import com.ruoyi.project.api.server.domain.ApiServerGroupExample;
import com.ruoyi.project.api.server.mapper.ApiServerGroupMapper;
import com.ruoyi.project.api.server.service.IApiServerGroupService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiServerGroupServiceImpl extends XmlBaseServiceImpl<ApiServerGroup, Long, ApiServerGroupMapper, ApiServerGroupExample> implements IApiServerGroupService
{

	@Override
	public String checkNameUnique(ApiServerGroup serverGroup) {
		Long id = StringUtils.isNull(serverGroup.getServerGroupId()) ? -1L : serverGroup.getServerGroupId();
		
		ApiServerGroupExample example = new ApiServerGroupExample();
		example.createCriteria().andServerGroupNameEqualTo(serverGroup.getServerGroupName());
		List<ApiServerGroup> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getServerGroupId()!=id)
        {
            return "1";
        }
        return "0";
	}
}
