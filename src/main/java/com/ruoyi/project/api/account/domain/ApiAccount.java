package com.ruoyi.project.api.account.domain;

import java.util.List;

import com.ruoyi.framework.web.domain.BaseEntity;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimit;

public class ApiAccount extends BaseEntity {
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long accountId;

    private String accountName;

    private String appKey;

    private String appScrect;
    
    private List<AccountApiLimit> apis;

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName == null ? null : accountName.trim();
    }

    public String getAppKey() {
        return appKey;
    }

    public void setAppKey(String appKey) {
        this.appKey = appKey == null ? null : appKey.trim();
    }

    public String getAppScrect() {
        return appScrect;
    }

    public void setAppScrect(String appScrect) {
        this.appScrect = appScrect == null ? null : appScrect.trim();
    }

	public List<AccountApiLimit> getApis() {
		return apis;
	}

	public void setApis(List<AccountApiLimit> apis) {
		this.apis = apis;
	}
}