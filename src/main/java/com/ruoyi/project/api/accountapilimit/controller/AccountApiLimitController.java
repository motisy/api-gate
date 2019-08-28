package com.ruoyi.project.api.accountapilimit.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.account.service.IApiAccountService;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimit;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimitExample;
import com.ruoyi.project.api.accountapilimit.domain.AccountApiLimitKey;
import com.ruoyi.project.api.accountapilimit.service.IAccountApiLimitService;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/accountApiLimit")
public class AccountApiLimitController extends BaseController
{
    private String prefix = "api/accountApiLimit";
    @Autowired
	RedisUtil redisUtil;
    @Autowired
	private IAccountApiLimitService accountApiLimitService;
    @Autowired
	private IApiAccountService accountService;
    @Autowired
	private IApiUrlService apiService;
	
    @RequiresPermissions("api:accountApiLimit:view")
    @GetMapping("choseApi")
	public String choseApi(Long accountId, ModelMap mmap)
	{
		mmap.put("account", accountService.selectByPrimaryKey(accountId));
		mmap.put("accountId", accountId);
	    return prefix + "/choseApi";
	}
    
    @PostMapping("/choseApiList")
	@ResponseBody
	public TableDataInfo list(Long accountId, Long apiGroupId, String apiName, String apiUrlSuffix)
	{
    	List<Long> alReadyGrant = new ArrayList<Long>();
    	AccountApiLimitExample accountApiLimitExample = new AccountApiLimitExample();
    	accountApiLimitExample.createCriteria().andAccountIdEqualTo(accountId);
    	List<AccountApiLimit> aals = accountApiLimitService.selectByExample(accountApiLimitExample);
    	for(AccountApiLimit aal:aals) {
    		alReadyGrant.add(aal.getApiId());
    	}
    	
		ApiUrlExample example = new ApiUrlExample();
		ApiUrlExample.Criteria c = example.createCriteria();
		
		if(StringUtils.isNotBlank(apiName)) {
			c.andApiNameLike("%"+apiName+"%");
		}
		if(StringUtils.isNotBlank(apiUrlSuffix)) {
			c.andApiUrlSuffixLike("%"+apiUrlSuffix+"%");
		}
		if(apiGroupId!=null) {
			if(apiGroupId!=0) {
				c.andApiGroupIdEqualTo(apiGroupId);
			}else {
				c.andApiGroupIdIsNull();
			}
		}
		if(alReadyGrant.size()>0) {
			c.andApiIdNotIn(alReadyGrant);
		}
		startPage();
        List<ApiUrl> list = apiService.selectByExample(example);
		return getDataTable(list);
	}
    
	@GetMapping()
	public String api(Long accountId, ModelMap mmap)
	{
		mmap.put("account", accountService.selectByPrimaryKey(accountId));
		mmap.put("accountId", accountId);
	    return prefix + "/accountApiLimit";
	}
	
	/**
	 * 查询api服务列表
	 */
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(Long accountId)
	{
		AccountApiLimitExample example = new AccountApiLimitExample();
		example.createCriteria().andAccountIdEqualTo(accountId);
		
		startPage();
        List<AccountApiLimit> list = accountApiLimitService.selectByExample(example);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出api服务列表
	 */
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Long accountId)
    {
    	AccountApiLimitExample example = new AccountApiLimitExample();
		example.createCriteria().andAccountIdEqualTo(accountId);
        List<AccountApiLimit> list = accountApiLimitService.selectByExample(example);
        ExcelUtil<AccountApiLimit> util = new ExcelUtil<AccountApiLimit>(AccountApiLimit.class);
        return util.exportExcel(list, "accountApiLimit");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add(Long accountId, Long apiId, ModelMap mmap)
	{
		mmap.put("accountId", accountId);
		mmap.put("account", accountService.selectByPrimaryKey(accountId));
		mmap.put("apiId", apiId);
		mmap.put("api", apiService.selectByPrimaryKey(apiId));
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(AccountApiLimit accountApiLimit)
	{		
		AccountApiLimitExample example = new AccountApiLimitExample();
		example.createCriteria().andAccountIdEqualTo(accountApiLimit.getAccountId()).andApiIdEqualTo(accountApiLimit.getApiId());
		if(accountApiLimitService.countByExample(example)>0) {
			return AjaxResult.error("api重复！");
		}
		if(accountApiLimit.getHasLimit() && accountApiLimit.getLimitRestNumber()==null && accountApiLimit.getLimitType().equals(AccountApiLimit.LIMIT_TYPE_TOTAL)) {
			accountApiLimit.setLimitRestNumber(accountApiLimit.getLimitNumber());
		}
		
		int r = accountApiLimitService.insertSelective(accountApiLimit);
		if(r>0) {
			accountService.refreshAccountApiUrlCache();
		}
		
		return toAjax(r);
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit")
	public String edit(Long accountId, Long apiId, ModelMap mmap)
	{
		AccountApiLimit accountApiLimit = accountApiLimitService.selectByPrimaryKey(new AccountApiLimitKey(accountId, apiId));
		mmap.put("accountApiLimit", accountApiLimit);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(AccountApiLimit accountApiLimit)
	{		
		if(accountApiLimitService.updateByPrimaryKey(accountApiLimit)>0) {
			accountService.refreshAccountApiUrlCache();
			
			redisUtil.del(ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+accountApiLimit.getApiAccount().getAppKey()+accountApiLimit.getApiUrl().getApiUrlSuffix());
			
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	/**
	 * 删除api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(Long accountId, String ids)
	{		
		AccountApiLimitExample example = new AccountApiLimitExample();
		example.createCriteria().andAccountIdEqualTo(accountId).andApiIdIn(getIds(ids));
		
		List<AccountApiLimit> list = accountApiLimitService.selectByExample(example);
		for(AccountApiLimit aal:list) {
			String k = ApiRedisConstants.ACCOUNT_API+aal.getApiAccount().getAppKey();
    		redisUtil.del(k);
			redisUtil.del(ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+aal.getApiAccount().getAppKey()+aal.getApiUrl().getApiUrlSuffix());

		}
		
		if(accountApiLimitService.deleteByExample(example)>0) {
			accountService.refreshAccountApiUrlCache();
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
		
	}
	
}
