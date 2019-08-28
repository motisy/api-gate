package com.ruoyi.project.api.server.domain;

import org.apache.commons.lang3.StringUtils;

import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.web.domain.BaseEntity;
import com.ruoyi.project.api.server.mapper.ApiServerGroupMapper;

/**
 * api服务表 api_server
 * 
 * @author 陈阳
 * @date 2019-08-05
 */

public class ApiServer extends BaseEntity
{
	
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	
	/** 主键 */
	private Long serverId;
	/** 服务名称 */
	private String serverName;
	/** 服务编号 */
	private String serverCode;
	/** 服务域名/ip */
	private String serverDomain;
	/** 服务地址头 */
	private Integer serverPort;
	/** 服务地址访问后缀 */
	private String serverSuffix;
	/** 服务访问地址 */
	private String serverUrl;
	/**
	 * 是否自动检查可用性
	 */
	private Boolean serverAutoCheck;
	/** 服务检查地址 */
	private String serverCheckUrl;
	/** 服务是否可用 */
	private Boolean serverLive;
	/** 服务器组 */
	private Long serverGroup;
	
	private ApiServerGroup apiServerGroup;
	
	/**
	 * 检查结果类型，string或json
	 */
    private String checkResultType;

    /**
     * 检查方式，string是包含和不包含，json是等于和不等于
     */
    private String checkType;

    /**
     * 检查结果是json时的key值
     */
    private String checkJsonKey;
    
    /**
     * 检查结果是json时的key值
     */
    private String checkValue;

    /**
     * 检查周期，单位是分钟
     */
    private Integer checkCycleMinute;
    
    private Integer serverWeight;

	public void setServerId(Long serverId) 
	{
		this.serverId = serverId;
	}

	public Long getServerId() 
	{
		return serverId;
	}
	public void setServerName(String serverName) 
	{
		this.serverName = serverName;
	}

	public String getServerName() 
	{
		return serverName;
	}
	public void setServerCode(String serverCode) 
	{
		this.serverCode = serverCode;
	}

	public String getServerCode() 
	{
		return serverCode;
	}
	public void setServerDomain(String serverDomain) 
	{
		this.serverDomain = serverDomain;
	}

	public String getServerDomain() 
	{
		return serverDomain;
	}
	public void setServerSuffix(String serverSuffix) 
	{
		this.serverSuffix = serverSuffix;
	}

	public String getServerSuffix() 
	{
		return serverSuffix;
	}
	public void setServerUrl(String serverUrl) 
	{
		this.serverUrl = serverUrl;
	}

	public String getServerUrl() 
	{
		if(StringUtils.isBlank(serverUrl) && serverPort!=null && StringUtils.isNotBlank(serverDomain)) {
			this.serverUrl = serverDomain + ":"+ serverPort + serverSuffix;
		}
		return serverUrl;
	}
	
	public void setServerCheckUrl(String serverCheckUrl) 
	{
		this.serverCheckUrl = serverCheckUrl;
	}

	public String getServerCheckUrl() 
	{
		return serverCheckUrl;
	}
	public void setServerLive(Boolean serverLive) 
	{
		this.serverLive = serverLive;
	}

	public Boolean getServerLive() 
	{
		return serverLive;
	}
	public void setServerGroup(Long serverGroup) 
	{
		this.serverGroup = serverGroup;
	}

	public Long getServerGroup() 
	{
		return serverGroup;
	}

	public ApiServerGroup getApiServerGroup() {
		if(this.serverGroup!=null) {
			ApiServerGroup g = SpringUtils.getBean(ApiServerGroupMapper.class).selectByPrimaryKey(serverGroup);
			if(g!=null) {
				apiServerGroup = g;
			}
		}
		return apiServerGroup;
	}

	public void setApiServerGroup(ApiServerGroup apiServerGroup) {
		this.apiServerGroup = apiServerGroup;
	}

	public Boolean getServerAutoCheck() {
		return serverAutoCheck;
	}

	public void setServerAutoCheck(Boolean serverAutoCheck) {
		this.serverAutoCheck = serverAutoCheck;
	}

	public String getCheckResultType() {
		return checkResultType;
	}

	public void setCheckResultType(String checkResultType) {
		this.checkResultType = checkResultType;
	}

	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public String getCheckJsonKey() {
		return checkJsonKey;
	}

	public void setCheckJsonKey(String checkJsonKey) {
		this.checkJsonKey = checkJsonKey;
	}

	public Integer getCheckCycleMinute() {
		return checkCycleMinute;
	}

	public void setCheckCycleMinute(Integer checkCycleMinute) {
		this.checkCycleMinute = checkCycleMinute;
	}

	public String getCheckValue() {
		return checkValue;
	}

	public void setCheckValue(String checkValue) {
		this.checkValue = checkValue;
	}

	public Integer getServerPort() {
		return serverPort;
	}

	public void setServerPort(Integer serverPort) {
		this.serverPort = serverPort;
	}

	public Integer getServerWeight() {
		return serverWeight;
	}

	public void setServerWeight(Integer serverWeight) {
		this.serverWeight = serverWeight;
	}
	
}
