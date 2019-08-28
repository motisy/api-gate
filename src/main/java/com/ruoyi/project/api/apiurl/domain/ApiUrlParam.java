package com.ruoyi.project.api.apiurl.domain;

import com.ruoyi.framework.web.domain.BaseEntity;

public class ApiUrlParam extends BaseEntity {
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long paramId;

    private Long apiId;

    private String paramName;

    private Boolean paramRequired;

    private Boolean paramNotEmpty;

    /**
     * string,number,date,boolean,json,file,other
     */
    private String paramType;

    private String paramCheckRegex;

    public Long getParamId() {
        return paramId;
    }

    public void setParamId(Long paramId) {
        this.paramId = paramId;
    }

    public Long getApiId() {
        return apiId;
    }

    public void setApiId(Long apiId) {
        this.apiId = apiId;
    }

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName == null ? null : paramName.trim();
    }

    public Boolean getParamRequired() {
        return paramRequired;
    }

    public void setParamRequired(Boolean paramRequired) {
        this.paramRequired = paramRequired;
    }

    public String getParamType() {
        return paramType;
    }

    public void setParamType(String paramType) {
        this.paramType = paramType == null ? null : paramType.trim();
    }

    public String getParamCheckRegex() {
        return paramCheckRegex;
    }

    public void setParamCheckRegex(String paramCheckRegex) {
        this.paramCheckRegex = paramCheckRegex == null ? null : paramCheckRegex.trim();
    }

	public Boolean getParamNotEmpty() {
		return paramNotEmpty;
	}

	public void setParamNotEmpty(Boolean paramNotEmpty) {
		this.paramNotEmpty = paramNotEmpty;
	}

}