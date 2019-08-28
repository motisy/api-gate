package com.ruoyi.project.api.server.controller;

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
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.domain.ApiServerExample;
import com.ruoyi.project.api.server.domain.ApiServerGroup;
import com.ruoyi.project.api.server.domain.ApiServerGroupExample;
import com.ruoyi.project.api.server.service.IApiServerGroupService;
import com.ruoyi.project.api.server.service.IApiServerService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/serverGroup")
public class ApiServerGroupController extends BaseController
{
    private String prefix = "api/serverGroup";
	
    @Autowired
	private IApiServerGroupService serverGroupService;
    
    @Autowired
	private IApiServerService serverService;
	
	@GetMapping()
	public String serverGroup()
	{
	    return prefix + "/serverGroup";
	}
	
	@GetMapping("/treeData")
    @ResponseBody
    public List<Ztree> treeData()
    {
		List<ApiServerGroup> list = serverGroupService.selectByExample(null);
		
		List<Ztree> ztrees = new ArrayList<Ztree>();
		Ztree t = new Ztree();
        t.setId(0L);
        t.setpId(-1L);
        t.setName("默认分组");
        t.setTitle("默认分组");
        ztrees.add(t);
		
        for (ApiServerGroup group : list)
        {
        	Ztree ztree = new Ztree();
            ztree.setId(group.getServerGroupId());
            ztree.setpId(-1L);
            ztree.setName(group.getServerGroupName());
            ztree.setTitle(group.getServerGroupName());
            ztrees.add(ztree);
        }
        return ztrees;
    }
	
	
	/**
	 * 导出api服务列表
	 */
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiServerGroup serverGroup)
    {
    	List<ApiServerGroup> list = serverGroupService.selectByExample(null);
        ExcelUtil<ApiServerGroup> util = new ExcelUtil<ApiServerGroup>(ApiServerGroup.class);
        return util.exportExcel(list, "serverGroup");
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
	public AjaxResult addSave(ApiServerGroup serverGroup)
	{		
		return toAjax(serverGroupService.insert(serverGroup));
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{serverId}")
	public String edit(@PathVariable("serverId") Long serverId, ModelMap mmap)
	{
		ApiServerGroup serverGroup = serverGroupService.selectByPrimaryKey(serverId);
		mmap.put("serverGroup", serverGroup);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiServerGroup serverGroup)
	{		
		return toAjax(serverGroupService.updateByPrimaryKeySelective(serverGroup));
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
		ApiServerGroupExample example = new ApiServerGroupExample();
		example.createCriteria().andServerGroupIdIn(realIds);
		
		if(serverGroupService.deleteByExample(example)>0) {
			ApiServerExample apiServerExample = new ApiServerExample();
			apiServerExample.createCriteria().andServerGroupIn(realIds);
			List<ApiServer> servers = serverService.selectByExample(apiServerExample);
			for(ApiServer server:servers) {
				server.setServerGroup(null);
				serverService.updateByPrimaryKey(server);
			}
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	@PostMapping("/checkNameUnique")
    @ResponseBody
    public String checkLoginNameUnique(ApiServerGroup serverGroup)
    {
        return serverGroupService.checkNameUnique(serverGroup);
    }
	
}
