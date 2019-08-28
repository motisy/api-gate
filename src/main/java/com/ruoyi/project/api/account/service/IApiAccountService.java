package com.ruoyi.project.api.account.service;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.account.domain.ApiAccountExample;

/**
 * api分组
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiAccountService extends XmlBaseService<ApiAccount, Long, ApiAccountExample>
{

	String checkNameUnique(ApiAccount apiAccount);
	
	void refreshAccountApiUrlCache();
}
