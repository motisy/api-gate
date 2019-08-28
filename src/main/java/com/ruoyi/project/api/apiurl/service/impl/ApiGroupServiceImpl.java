package com.ruoyi.project.api.apiurl.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.project.api.apiurl.domain.ApiGroup;
import com.ruoyi.project.api.apiurl.domain.ApiGroupExample;
import com.ruoyi.project.api.apiurl.mapper.ApiGroupMapper;
import com.ruoyi.project.api.apiurl.service.IApiGroupService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiGroupServiceImpl extends XmlBaseServiceImpl<ApiGroup, Long, ApiGroupMapper, ApiGroupExample> implements IApiGroupService
{

	@Override
	public String checkNameUnique(ApiGroup apiGroup) {
		Long id = StringUtils.isNull(apiGroup.getApiGroupId()) ? -1L : apiGroup.getApiGroupId();
		
		ApiGroupExample example = new ApiGroupExample();
		example.createCriteria().andApiGroupNameEqualTo(apiGroup.getApiGroupName());
		List<ApiGroup> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getApiGroupId()!=id)
        {
            return "1";
        }
        return "0";
	}
}
