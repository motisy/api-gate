package com.ruoyi.project.api.apiurl.domain;

import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.framework.web.domain.BaseEntity;

public class ApiUrl extends BaseEntity {
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long apiId;

    private String apiName;

    private Long apiGroupId;
    
    private String apiRequestMethod;

    private String apiServerIds;

    private String apiUrlSuffix;

    private String apiServerUrlSuffix;

    private String apiServerRequestWay;
    
    private String requestUrl;

    public Long getApiId() {
        return apiId;
    }

    public void setApiId(Long apiId) {
        this.apiId = apiId;
    }

    public String getApiName() {
        return apiName;
    }

    public void setApiName(String apiName) {
        this.apiName = apiName == null ? null : apiName.trim();
    }

    public Long getApiGroupId() {
        return apiGroupId;
    }

    public void setApiGroupId(Long apiGroupId) {
        this.apiGroupId = apiGroupId;
    }

    public String getApiServerIds() {
        return apiServerIds;
    }

    public void setApiServerIds(String apiServerIds) {
        this.apiServerIds = apiServerIds == null ? null : apiServerIds.trim();
    }

    public String getApiUrlSuffix() {
        return apiUrlSuffix;
    }

    public void setApiUrlSuffix(String apiUrlSuffix) {
        this.apiUrlSuffix = apiUrlSuffix == null ? null : apiUrlSuffix.trim();
    }

    public String getApiServerUrlSuffix() {
        return apiServerUrlSuffix;
    }

    public void setApiServerUrlSuffix(String apiServerUrlSuffix) {
        this.apiServerUrlSuffix = apiServerUrlSuffix == null ? null : apiServerUrlSuffix.trim();
    }

    public String getApiServerRequestWay() {
        return apiServerRequestWay;
    }

    public void setApiServerRequestWay(String apiServerRequestWay) {
        this.apiServerRequestWay = apiServerRequestWay == null ? null : apiServerRequestWay.trim();
    }

	public String getRequestUrl() {
		ApiConfig apiConfig = SpringUtils.getBean(ApiConfig.class);
		requestUrl = apiConfig.getDomain()+apiConfig.getPreurl()+apiUrlSuffix;
		return requestUrl;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public String getApiRequestMethod() {
		return apiRequestMethod;
	}

	public void setApiRequestMethod(String apiRequestMethod) {
		this.apiRequestMethod = apiRequestMethod;
	}
}