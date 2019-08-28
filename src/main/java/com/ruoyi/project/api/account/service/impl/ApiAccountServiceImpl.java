package com.ruoyi.project.api.account.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.account.domain.ApiAccountExample;
import com.ruoyi.project.api.account.mapper.ApiAccountMapper;
import com.ruoyi.project.api.account.service.IApiAccountService;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimit;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimitExample;
import com.ruoyi.project.api.accountapilimit.service.IAccountApiLimitService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiAccountServiceImpl extends XmlBaseServiceImpl<ApiAccount, Long, ApiAccountMapper, ApiAccountExample> implements IApiAccountService
{

	@Autowired
	RedisUtil redisUtil;
	
	@Autowired
	IAccountApiLimitService accountApiLimitService;
	
	@Override
	public String checkNameUnique(ApiAccount apiAccount) {
		Long id = StringUtils.isNull(apiAccount.getAccountId()) ? -1L : apiAccount.getAccountId();
		
		ApiAccountExample example = new ApiAccountExample();
		example.createCriteria().andAccountNameEqualTo(apiAccount.getAccountName());
		List<ApiAccount> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getAccountId()!=id)
        {
            return "1";
        }
        return "0";
	}

	@Override
	public void refreshAccountApiUrlCache() {
		List<ApiAccount> accounts = selectByExample(null);
    	for(ApiAccount account:accounts) {
    		String k = ApiRedisConstants.ACCOUNT_API+account.getAppKey();
    		redisUtil.del(k);
    		
    		String k2 = ApiRedisConstants.ACCOUNT_API_LIMIT+account.getAppKey();
    		redisUtil.del(k2);
    		
    		AccountApiLimitExample accountApiLimitExample = new AccountApiLimitExample();
        	accountApiLimitExample.createCriteria().andAccountIdEqualTo(account.getAccountId());
        	List<AccountApiLimit> accountApis = accountApiLimitService.selectByExample(accountApiLimitExample);
        	
        	Map<Object, Object> accountApiLimit = new HashMap<>();
        	
        	for(AccountApiLimit apiLimit:accountApis) {
        		redisUtil.sSet(k, apiLimit.getApiUrl().getApiUrlSuffix());
//        		redisUtil.sSet(k2, JSONObject.toJSONString(apiLimit));
        		accountApiLimit.put(apiLimit.getApiUrl().getApiUrlSuffix(), apiLimit);
        	}
        	
        	redisUtil.hmset(k2, accountApiLimit);
    	}
	}
}
