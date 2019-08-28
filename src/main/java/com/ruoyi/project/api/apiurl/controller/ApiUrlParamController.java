package com.ruoyi.project.api.apiurl.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParam;
import com.ruoyi.project.api.apiurl.domain.ApiUrlParamExample;
import com.ruoyi.project.api.apiurl.service.IApiUrlParamService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/apiUrlParam")
public class ApiUrlParamController extends BaseController
{
    private String prefix = "api/apiUrlParam";
	
    @Autowired
	private IApiUrlParamService apiParamService;
    @Autowired
	private IApiUrlService apiService;
	
    @RequiresPermissions("api:param:view")
	@GetMapping()
	public String api(Long apiId, ModelMap mmap)
	{
		mmap.put("api", apiService.selectByPrimaryKey(apiId));
		mmap.put("apiId", apiId);
	    return prefix + "/param";
	}
	
	/**
	 * 查询api服务列表
	 */
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(Long apiId)
	{
		ApiUrlParamExample example = new ApiUrlParamExample();
		example.createCriteria().andApiIdEqualTo(apiId);
		
		startPage();
        List<ApiUrlParam> list = apiParamService.selectByExample(example);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出api服务列表
	 */
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Long apiId)
    {
		ApiUrlParamExample example = new ApiUrlParamExample();
		example.createCriteria().andApiIdEqualTo(apiId);
		List<ApiUrlParam> list = apiParamService.selectByExample(example);
        ExcelUtil<ApiUrlParam> util = new ExcelUtil<ApiUrlParam>(ApiUrlParam.class);
        return util.exportExcel(list, "api");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add(Long apiId, ModelMap mmap)
	{
		mmap.put("apiId", apiId);
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(ApiUrlParam apiUrlParam)
	{		
		ApiUrlParamExample example = new ApiUrlParamExample();
		example.createCriteria().andParamNameEqualTo(apiUrlParam.getParamName());
		if(apiParamService.countByExample(example)>0) {
			return AjaxResult.error("api参数名称重复！");
		}
		apiParamService.refreshApiUrlParamCache(SpringUtils.getBean(IApiUrlService.class).selectByPrimaryKey(apiUrlParam.getApiId()), false);
		return toAjax(apiParamService.insertSelective(apiUrlParam));
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{paramId}")
	public String edit(@PathVariable("paramId") Long paramId, ModelMap mmap)
	{
		ApiUrlParam api = apiParamService.selectByPrimaryKey(paramId);
		mmap.put("urlParam", api);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiUrlParam apiParam)
	{		
		if(apiParamService.updateByPrimaryKey(apiParam)>0) {
			apiParamService.refreshApiUrlParamCache(SpringUtils.getBean(IApiUrlService.class).selectByPrimaryKey(apiParam.getApiId()), false);
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
	public AjaxResult remove(String ids)
	{		
		List<Long> realIds = getIds(ids);
		ApiUrlParamExample example = new ApiUrlParamExample();
		example.createCriteria().andParamIdIn(realIds);
		
		apiParamService.refreshApiUrlParamCache(SpringUtils.getBean(IApiUrlService.class).selectByPrimaryKey(apiParamService.selectByPrimaryKey(realIds.get(0)).getApiId()), false);
		
		if(apiParamService.deleteByExample(example)>0) {
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
		
	}
	
}
