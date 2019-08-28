package com.ruoyi.project.api.apiurl.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.domain.Ztree;
import com.ruoyi.project.api.apiurl.domain.ApiGroup;
import com.ruoyi.project.api.apiurl.domain.ApiGroupExample;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.service.IApiGroupService;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/apiGroup")
public class ApiGroupController extends BaseController
{
    private String prefix = "api/apiGroup";
	
    @Autowired
	private IApiGroupService apiGroupService;
    
    @Autowired
	private IApiUrlService apiUrlService;
	
	@GetMapping()
	public String apiGroup()
	{
	    return prefix + "/apiGroup";
	}
	
	@GetMapping("/treeData")
    @ResponseBody
    public List<Ztree> treeData()
    {
		List<ApiGroup> list = apiGroupService.selectByExample(null);
		
		List<Ztree> ztrees = new ArrayList<Ztree>();
		Ztree t = new Ztree();
        t.setId(0L);
        t.setpId(-1L);
        t.setName("默认分组");
        t.setTitle("默认分组");
        ztrees.add(t);
		
        for (ApiGroup group : list)
        {
        	Ztree ztree = new Ztree();
            ztree.setId(group.getApiGroupId());
            ztree.setpId(-1L);
            ztree.setName(group.getApiGroupName());
            ztree.setTitle(group.getApiGroupName());
            ztrees.add(ztree);
        }
        return ztrees;
    }
	
	/**
	 * 导出api服务列表
	 */
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiGroup apiGroup)
    {
    	List<ApiGroup> list = apiGroupService.selectByExample(null);
        ExcelUtil<ApiGroup> util = new ExcelUtil<ApiGroup>(ApiGroup.class);
        return util.exportExcel(list, "apiGroup");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(ApiGroup apiGroup)
	{		
		return toAjax(apiGroupService.insert(apiGroup));
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{serverId}")
	public String edit(@PathVariable("serverId") Long serverId, ModelMap mmap)
	{
		ApiGroup apiGroup = apiGroupService.selectByPrimaryKey(serverId);
		mmap.put("apiGroup", apiGroup);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiGroup apiGroup)
	{		
		return toAjax(apiGroupService.updateByPrimaryKeySelective(apiGroup));
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
		ApiGroupExample example = new ApiGroupExample();
		example.createCriteria().andApiGroupIdIn(realIds);
		
		if(apiGroupService.deleteByExample(example)>0) {
			ApiUrlExample apiServerExample = new ApiUrlExample();
			apiServerExample.createCriteria().andApiGroupIdIn(realIds);
			List<ApiUrl> apis = apiUrlService.selectByExample(apiServerExample);
			for(ApiUrl api:apis) {
				api.setApiGroupId(null);
				apiUrlService.updateByPrimaryKey(api);
			}
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	@PostMapping("/checkNameUnique")
    @ResponseBody
    public String checkLoginNameUnique(ApiGroup apiGroup)
    {
        return apiGroupService.checkNameUnique(apiGroup);
    }
	
}
