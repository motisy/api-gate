package com.ruoyi.project.api.accountapilimit.domain;

public class AccountApiLimitKey {
    private Long accountId;

    private Long apiId;

    public AccountApiLimitKey() {}
    public AccountApiLimitKey(Long accountId, Long apiId) {
    	this.accountId = accountId;
    	this.apiId = apiId;
    }
    
    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Long getApiId() {
        return apiId;
    }

    public void setApiId(Long apiId) {
        this.apiId = apiId;
    }
}