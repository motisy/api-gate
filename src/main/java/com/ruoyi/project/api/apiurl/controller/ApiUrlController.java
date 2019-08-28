package com.ruoyi.project.api.apiurl.controller;

import java.util.ArrayList;
import java.util.List;

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

import com.ruoyi.common.utils.http.HttpClientUtils;
import com.ruoyi.common.utils.http.HttpConnectionPool;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.config.ApiConfig;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.service.IApiGroupService;
import com.ruoyi.project.api.apiurl.service.IApiUrlParamService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.server.service.IApiServerService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/apiUrl")
public class ApiUrlController extends BaseController
{
    private String prefix = "api/apiUrl";
	
    @Autowired
    private ApiConfig apiConfig;
    
    @Autowired
	private IApiUrlService apiService;
    
    @Autowired
	private IApiGroupService apiGroupService;
    
    @Autowired
    private IApiServerService apiServerService;
	
	@RequiresPermissions("api:url:view")
	@GetMapping()
	public String api()
	{
	    return prefix + "/api";
	}
	
	/**
	 * 查询api服务列表
	 */
	@RequiresPermissions("api:url:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(ApiUrl api)
	{
		ApiUrlExample example = new ApiUrlExample();
		ApiUrlExample.Criteria c = example.createCriteria();
		
		if(StringUtils.isNotBlank(api.getApiName())) {
			c.andApiNameLike("%"+api.getApiName()+"%");
		}
		if(StringUtils.isNotBlank(api.getApiUrlSuffix())) {
			c.andApiUrlSuffixLike("%"+api.getApiUrlSuffix()+"%");
		}
		if(api.getApiGroupId()!=null) {
			if(api.getApiGroupId()!=0) {
				c.andApiGroupIdEqualTo(api.getApiGroupId());
			}else {
				c.andApiGroupIdIsNull();
			}
		}
		startPage();
        List<ApiUrl> list = apiService.selectByExample(example);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出api服务列表
	 */
	@RequiresPermissions("api:url:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiUrl api)
    {
    	List<ApiUrl> list = apiService.selectByExample(null);
        ExcelUtil<ApiUrl> util = new ExcelUtil<ApiUrl>(ApiUrl.class);
        return util.exportExcel(list, "api");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add(ModelMap mmap)
	{
		mmap.addAttribute("groups", apiGroupService.selectByExample(null));
		mmap.addAttribute("gateurl", apiConfig.getPreurl());
		mmap.addAttribute("domian", apiConfig.getDomain());
		mmap.addAttribute("allGroups", apiServerService.allGroups());
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@RequiresPermissions("api:url:add")
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(ApiUrl api)
	{		
		ApiUrlExample example = new ApiUrlExample();
		example.createCriteria().andApiUrlSuffixEqualTo(api.getApiUrlSuffix());
		if(apiService.countByExample(example)>0) {
			return AjaxResult.error("api地址重复！");
		}

		int r = apiService.insertSelective(api);
		if(r>0) {
			apiService.refreshApiUrlCache();
		}
		
		return toAjax(r);
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{apiId}")
	public String edit(@PathVariable("apiId") Long apiId, ModelMap mmap)
	{
		ApiUrl api = apiService.selectByPrimaryKey(apiId);
		mmap.put("api", api);
		mmap.addAttribute("groups", apiGroupService.selectByExample(null));
		mmap.addAttribute("gateurl", apiConfig.getPreurl());
		mmap.addAttribute("domian", apiConfig.getDomain());
		mmap.addAttribute("allGroups", apiServerService.allGroups());
		
		List<Long> serverIds = new ArrayList<Long>();
		for(String i:api.getApiServerIds().split(",")) {
			serverIds.add(Long.parseLong(i));
		}
		mmap.addAttribute("serverIds", serverIds);
		
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@RequiresPermissions("api:url:edit")
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiUrl api)
	{		
		if(apiService.updateByPrimaryKey(api)>0) {
			apiService.refreshApiUrlCache();
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	/**
	 * 删除api服务
	 */
	@RequiresPermissions("api:url:remove")
	@Log(title = "api服务", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		ApiUrlExample example = new ApiUrlExample();
		example.createCriteria().andApiIdIn(getIds(ids));
		if(apiService.deleteByExample(example)>0) {
			
			for(ApiUrl api:apiService.selectByExample(example)) {
				HttpConnectionPool olPool = HttpClientUtils.clients.get(api.getApiUrlSuffix());
				olPool.closeConnectionPool();
				
	    		HttpClientUtils.clients.remove(api.getApiUrlSuffix());
	    		
	    		SpringUtils.getBean(IApiUrlParamService.class).refreshApiUrlParamCache(api, true);
			}
			
			apiService.refreshApiUrlCache();
			
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
		
	}
	
	@PostMapping("/checkNameUnique")
    @ResponseBody
    public String checkNameUnique(ApiUrl api)
    {
        return apiService.checkNameUnique(api);
    }
}
