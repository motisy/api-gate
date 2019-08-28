package com.ruoyi.project.api.record.domain;

import com.ruoyi.framework.aspectj.lang.annotation.Excel;
import com.ruoyi.framework.web.domain.BaseEntity;

public class ApiRequestRecord extends BaseEntity {
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long id;

	@Excel(name = "appKey")
    private String appKey;

    private Long apiId;

    @Excel(name = "请求的api名称")
    private String apiName;

    @Excel(name = "请求的api访问后缀")
    private String apiUrl;

    private Long serverId;
    
    @Excel(name = "操作ip")
    private String requestIp;
    
    @Excel(name = "操作地点")
    private String requestLocation;
    
    @Excel(name = "请求地址")
    private String requestUrl;

    @Excel(name = "转发地址")
    private String forwardUrl;
    
    @Excel(name = "请求方式")
    private String requestMethod;
    
    @Excel(name = "转发的服务器名称")
    private String serverName;
    
    @Excel(name = "转发用时ms")
    private Integer useTime;
    
    @Excel(name = "请求参数")
    private String requestParams;

    @Excel(name = "响应数据类型")
    private String responseContentType;

    @Excel(name = "转发是否成功")
    private Boolean forwardSuccess;
    
    @Excel(name = "失败原因")
    private String failedReasons;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAppKey() {
        return appKey;
    }

    public void setAppKey(String appKey) {
        this.appKey = appKey == null ? null : appKey.trim();
    }

    public Long getApiId() {
        return apiId;
    }

    public void setApiId(Long apiId) {
        this.apiId = apiId;
    }

    public Long getServerId() {
        return serverId;
    }

    public void setServerId(Long serverId) {
        this.serverId = serverId;
    }

    public String getRequestUrl() {
        return requestUrl;
    }

    public void setRequestUrl(String requestUrl) {
        this.requestUrl = requestUrl == null ? null : requestUrl.trim();
    }

    public String getForwardUrl() {
        return forwardUrl;
    }

    public void setForwardUrl(String forwardUrl) {
        this.forwardUrl = forwardUrl == null ? null : forwardUrl.trim();
    }

    public Integer getUseTime() {
        return useTime;
    }

    public void setUseTime(Integer useTime) {
        this.useTime = useTime;
    }

    public String getResponseContentType() {
        return responseContentType;
    }

    public void setResponseContentType(String responseContentType) {
        this.responseContentType = responseContentType == null ? null : responseContentType.trim();
    }

    public Boolean getForwardSuccess() {
        return forwardSuccess;
    }

    public void setForwardSuccess(Boolean forwardSuccess) {
        this.forwardSuccess = forwardSuccess;
    }

	public String getRequestParams() {
		return requestParams;
	}

	public void setRequestParams(String requestParams) {
		this.requestParams = requestParams;
	}

	public String getFailedReasons() {
		return failedReasons;
	}

	public void setFailedReasons(String failedReasons) {
		this.failedReasons = failedReasons;
	}

	public String getRequestMethod() {
		return requestMethod;
	}

	public void setRequestMethod(String requestMethod) {
		this.requestMethod = requestMethod;
	}

	public String getApiName() {
		return apiName;
	}

	public void setApiName(String apiName) {
		this.apiName = apiName;
	}

	public String getApiUrl() {
		return apiUrl;
	}

	public void setApiUrl(String apiUrl) {
		this.apiUrl = apiUrl;
	}

	public String getRequestIp() {
		return requestIp;
	}

	public void setRequestIp(String requestIp) {
		this.requestIp = requestIp;
	}

	public String getRequestLocation() {
		return requestLocation;
	}

	public void setRequestLocation(String requestLocation) {
		this.requestLocation = requestLocation;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}
	
}