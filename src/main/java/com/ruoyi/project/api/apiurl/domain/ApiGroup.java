package com.ruoyi.project.api.apiurl.domain;

import com.ruoyi.framework.web.domain.BaseEntity;

public class ApiGroup extends BaseEntity {
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long apiGroupId;

    private String apiGroupName;

    public Long getApiGroupId() {
        return apiGroupId;
    }

    public void setApiGroupId(Long apiGroupId) {
        this.apiGroupId = apiGroupId;
    }

    public String getApiGroupName() {
        return apiGroupName;
    }

    public void setApiGroupName(String apiGroupName) {
        this.apiGroupName = apiGroupName == null ? null : apiGroupName.trim();
    }

}