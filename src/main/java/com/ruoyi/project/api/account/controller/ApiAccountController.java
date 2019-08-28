package com.ruoyi.project.api.account.controller;

import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.MyMD5Util;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.account.domain.ApiAccountExample;
import com.ruoyi.project.api.account.service.IApiAccountService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/account")
public class ApiAccountController extends BaseController
{
    private String prefix = "api/account";
	
    @Autowired
	RedisUtil redisUtil;
    
    @Autowired
    private ApiConfig apiConfig;
    
    @Autowired
	private IApiAccountService apiAccountService;
    
	@RequiresPermissions("api:account:view")
	@GetMapping()
	public String api()
	{
	    return prefix + "/account";
	}
	
	/**
	 * 查询api服务列表
	 */
	@RequiresPermissions("api:account:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(ApiAccount api)
	{
		ApiAccountExample example = new ApiAccountExample();
		ApiAccountExample.Criteria c = example.createCriteria();
		
		if(StringUtils.isNotBlank(api.getAccountName())) {
			c.andAccountNameLike("%"+api.getAccountName()+"%");
		}
		startPage();
        List<ApiAccount> list = apiAccountService.selectByExample(example);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出api服务列表
	 */
	@RequiresPermissions("api:account:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiAccount api)
    {
    	List<ApiAccount> list = apiAccountService.selectByExample(null);
        ExcelUtil<ApiAccount> util = new ExcelUtil<ApiAccount>(ApiAccount.class);
        return util.exportExcel(list, "api");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add(ModelMap mmap)
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@RequiresPermissions("api:account:add")
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(ApiAccount api)
	{		
		String appKey = RandomStringUtils.random(10, true, true);
		String appScrect = "";
		try {
			appScrect = MyMD5Util.md5(appKey, apiConfig.getMd5key());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		api.setAppKey(appKey);
		api.setAppScrect(appScrect);
		
		int r = apiAccountService.insertSelective(api);
		if(r>0) {
			apiAccountService.refreshAccountApiUrlCache();
		}
		
		return toAjax(r);
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{apiId}")
	public String edit(@PathVariable("apiId") Long apiId, ModelMap mmap)
	{
		ApiAccount account = apiAccountService.selectByPrimaryKey(apiId);
		mmap.put("account", account);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@RequiresPermissions("api:account:edit")
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiAccount api)
	{		
		if(apiAccountService.updateByPrimaryKeySelective(api)>0) {
			redisUtil.deleteByPrex(ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+api.getAppKey()+"*");
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	/**
	 * 删除api服务
	 */
	@RequiresPermissions("api:account:remove")
	@Log(title = "api服务", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		ApiAccountExample example = new ApiAccountExample();
		example.createCriteria().andAccountIdIn(getIds(ids));
		
		RedisUtil redisUtil = SpringUtils.getBean(RedisUtil.class);
		List<ApiAccount> accounts = apiAccountService.selectByExample(example);
		for(ApiAccount a:accounts) {
			String k = ApiRedisConstants.ACCOUNT_API+a.getAppKey();
			redisUtil.del(k);
			redisUtil.deleteByPrex(ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+a.getAppKey()+"*");
		}
		
		if(apiAccountService.deleteByExample(example)>0) {
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
		
	}
	
	@PostMapping("/checkNameUnique")
    @ResponseBody
    public String checkNameUnique(ApiAccount api)
    {
        return apiAccountService.checkNameUnique(api);
    }
}
