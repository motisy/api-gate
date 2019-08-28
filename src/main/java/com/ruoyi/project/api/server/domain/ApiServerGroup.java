package com.ruoyi.project.api.server.domain;

import com.ruoyi.framework.web.domain.BaseEntity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * api服务表 api_server
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class ApiServerGroup extends BaseEntity
{
	
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	
	/** 主键 */
	private Long serverGroupId;
	/** 服务名称 */
	private String serverGroupName;
	/** 服务编号 */
	private String serverGroupCode;
}
