package com.ruoyi.project.api.apitest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ruoyi.common.utils.bean.BeanUtils;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.account.domain.ApiAccountExample;
import com.ruoyi.project.api.account.service.IApiAccountService;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimit;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimitExample;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimitKey;
import com.ruoyi.project.api.accountapilimit.service.IAccountApiLimitService;
import com.ruoyi.project.api.apiurl.domain.ApiGroup;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParam;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParamExample;
import com.ruoyi.project.api.apiurl.service.IApiGroupService;
import com.ruoyi.project.api.apiurl.service.IApiUrlParamService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

/**
 * 测试页面
 * <p>Title: ApiTestController</p>  
 * <p>Description: </p>  
 * @author 陈阳  
 * @date 2019年8月26日
 */
@Controller
@RequestMapping("/api/show")
public class ApiTestController extends BaseController
{
    private String prefix = "api/test";

    @Autowired
    private IApiGroupService apiGroupService;
    
    @Autowired
    private IApiUrlService apiUrlService;
    
    @Autowired
    private IAccountApiLimitService accountApiLimitService;
    
    @Autowired
    private IApiAccountService apiAccountService;
    
    @Autowired
    private IApiUrlParamService apiUrlParamService;
    
    @GetMapping()
    public String show(ModelMap map, String appKey)
    {
    	ApiAccount account = null;
    	List<AccountApiLimit> accountApis = null;
    	if(StringUtils.isNotBlank(appKey)) {
    		ApiAccountExample apiAccountExample = new ApiAccountExample();
        	apiAccountExample.createCriteria().andAppKeyEqualTo(appKey);
        	List<ApiAccount> l = apiAccountService.selectByExample(apiAccountExample);
        	
        	if(l!=null && l.size()>0) {
        		account = l.get(0);
        		AccountApiLimitExample accountApiLimitExample = new AccountApiLimitExample();
            	accountApiLimitExample.createCriteria().andAccountIdEqualTo(account.getAccountId());
            	accountApis = accountApiLimitService.selectByExample(accountApiLimitExample);
        	}
    	}
    	
    	Map<String, List<ApiUrlData>> groupMap = new HashedMap<>();
    	List<ApiGroup> groupList = apiGroupService.selectByExample(null);
    	
    	ApiUrlExample defaultGroup = new ApiUrlExample();
    	defaultGroup.createCriteria().andApiGroupIdIsNull();
    	List<ApiUrl> dgApi = apiUrlService.selectByExample(defaultGroup);
    	dgApi = accountApi(dgApi, accountApis);
    	if(dgApi!=null && dgApi.size()>0) {
    		groupMap.put("默认组", trans(dgApi, account));
    	}
    	
    	for(ApiGroup g:groupList) {
    		ApiUrlExample groupExample = new ApiUrlExample();
    		groupExample.createCriteria().andApiGroupIdEqualTo(g.getApiGroupId());
    		List<ApiUrl> gApi = apiUrlService.selectByExample(groupExample);
    		gApi = accountApi(gApi, accountApis);
    		if(gApi!=null && gApi.size()>0) {
        		groupMap.put(g.getApiGroupName(), trans(gApi, account));
        	}
    	}
    	
    	map.put("groups", groupMap);
    	
    	map.put("account", account);
    	
        return prefix + "/show";
    }
    
    /**
     * 返回accountApis中存在的api
     * @param apis
     * @param accountApis
     * @return
     */
    private List<ApiUrl> accountApi(List<ApiUrl> apis, List<AccountApiLimit> accountApis){
    	if(accountApis!=null) {
    		List<ApiUrl> list = new ArrayList<ApiUrl>();
        	for(ApiUrl api:apis) {
        		for(AccountApiLimit accountApi:accountApis) {
            		if(api.getApiId() == accountApi.getApiId()) {
            			list.add(api);
            			break;
            		}
            	}
        	}
        	
        	return list;
    	}else {
    		return apis;
    	}
    }
    
    @GetMapping("params")
    public String show(Long apiId, ModelMap map)
    {
    	ApiUrl api = apiUrlService.selectByPrimaryKey(apiId);
    	map.put("api", api);
    	
    	ApiUrlParamExample example = new ApiUrlParamExample();
    	example.createCriteria().andApiIdEqualTo(apiId);
    	
    	List<ApiUrlParam> params = apiUrlParamService.selectByExample(example);
    	map.put("apiParams", params);
    	
        return prefix + "/showParams";
    }
    
    public List<ApiUrlData> trans(List<ApiUrl> apis, ApiAccount account) {
    	List<ApiUrlData> list = new ArrayList<>();
    	for(ApiUrl api:apis) {
    		ApiUrlData d = new ApiUrlData();
    		BeanUtils.copyBeanProp(d, api);
    		if(account!=null) {
    			AccountApiLimitKey id = new AccountApiLimitKey(account.getAccountId(), api.getApiId());
    			AccountApiLimit limit = accountApiLimitService.selectByPrimaryKey(id);
    			if(limit!=null) {
    				d.setLimit(limit);
    				limit.getDes();
    			}
    		}	
    		list.add(d);
    	}
    	return list;
    }
}

class ApiUrlData extends ApiUrl {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private AccountApiLimit limit;

	public AccountApiLimit getLimit() {
		return limit;
	}

	public void setLimit(AccountApiLimit limit) {
		this.limit = limit;
	}
}