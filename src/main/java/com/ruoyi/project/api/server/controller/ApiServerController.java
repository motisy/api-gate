package com.ruoyi.project.api.server.controller;

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
import com.ruoyi.common.utils.loadbalance.LoadBanlanceUtil;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.domain.ApiServerExample;
import com.ruoyi.project.api.server.service.IApiServerGroupService;
import com.ruoyi.project.api.server.service.IApiServerService;

/**
 * api服务信息操作处理
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Controller
@RequestMapping("/api/server")
public class ApiServerController extends BaseController
{
    private String prefix = "api/server";
	
    @Autowired
	private IApiServerService serverService;
    
    @Autowired
	private IApiServerGroupService serverGroupService;
	
	@RequiresPermissions("api:server:view")
	@GetMapping()
	public String server()
	{
	    return prefix + "/server";
	}
	
	/**
	 * 查询api服务列表
	 */
	@RequiresPermissions("api:server:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(ApiServer server)
	{
		ApiServerExample example = new ApiServerExample();
		ApiServerExample.Criteria c = example.createCriteria();
		
		if(StringUtils.isNotBlank(server.getServerName())) {
			c.andServerNameLike(server.getServerName()+"%");
		}
		if(StringUtils.isNotBlank(server.getServerCode())) {
			c.andServerNameLike("%"+server.getServerCode()+"%");
		}
		if(StringUtils.isNotBlank(server.getServerUrl())) {
			c.andServerUrlLike("%"+server.getServerUrl()+"%");
		}
		if(server.getServerLive()!=null) {
			c.andServerLiveEqualTo(server.getServerLive());
		}
		if(server.getServerGroup()!=null) {
			if(server.getServerGroup()!=0) {
				c.andServerGroupEqualTo(server.getServerGroup());
			}else {
				c.andServerGroupIsNull();
			}
		}
		
		startPage();
        List<ApiServer> list = serverService.selectByExample(example);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出api服务列表
	 */
	@RequiresPermissions("api:server:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiServer server)
    {
    	List<ApiServer> list = serverService.selectByExample(null);
        ExcelUtil<ApiServer> util = new ExcelUtil<ApiServer>(ApiServer.class);
        return util.exportExcel(list, "server");
    }
	
	/**
	 * 新增api服务
	 */
	@GetMapping("/add")
	public String add(ModelMap mmap)
	{
		mmap.addAttribute("groups", serverGroupService.selectByExample(null));
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存api服务
	 */
	@RequiresPermissions("api:server:add")
	@Log(title = "api服务", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(ApiServer server)
	{		
		ApiServerExample example = new ApiServerExample();
		example.createCriteria().andServerDomainEqualTo(server.getServerDomain()).andServerPortEqualTo(server.getServerPort()).andServerSuffixEqualTo(server.getServerSuffix());
		if(serverService.countByExample(example)>0) {
			return AjaxResult.error("服务地址重复！");
		}
		String k = server.getServerUrl();
		HttpClientUtils.clients.put(k, new HttpConnectionPool(server.getServerDomain(), server.getServerPort()));
		
		int r = serverService.insertSelective(server);
		if(r>0) {
			serverService.refreshApiServerCache();
			serverService.serverAutoCheck(server);
		}
		return toAjax(r);
	}

	/**
	 * 修改api服务
	 */
	@GetMapping("/edit/{serverId}")
	public String edit(@PathVariable("serverId") Long serverId, ModelMap mmap)
	{
		ApiServer server = serverService.selectByPrimaryKey(serverId);
		mmap.put("server", server);
		mmap.addAttribute("groups", serverGroupService.selectByExample(null));
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存api服务
	 */
	@RequiresPermissions("api:server:edit")
	@Log(title = "api服务", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(ApiServer server)
	{		
		ApiServer old = serverService.selectByPrimaryKey(server.getServerId());
		if(serverService.updateByPrimaryKeySelective(server)>0) {
			if(!old.getServerUrl().equals(server.getServerUrl())) {
				HttpConnectionPool olPool = HttpClientUtils.clients.get(old.getServerUrl());
				olPool.closeConnectionPool();
				
				HttpClientUtils.clients.remove(old.getServerUrl());
				HttpClientUtils.clients.put(server.getServerUrl(), new HttpConnectionPool(server.getServerDomain(), server.getServerPort()));
			}
			
			//手动状态下状态改变了，修改server的负载均衡缓存
			if((!server.getServerAutoCheck() && server.getServerLive().booleanValue() != old.getServerLive().booleanValue()
					|| (server.getServerWeight()!=old.getServerWeight()))) {
				LoadBanlanceUtil.reloadLoadBanlanceSelector(server.getServerId());
			}
			
			serverService.refreshApiServerCache();
			serverService.serverAutoCheck(server);
			return AjaxResult.success();
		}else {
			return AjaxResult.error();
		}
	}
	
	/**
	 * 删除api服务
	 */
	@RequiresPermissions("api:server:remove")
	@Log(title = "api服务", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		Boolean haveInUse = false;
		IApiUrlService apiUrlService = SpringUtils.getBean(IApiUrlService.class);
		List<Long> readIds = getIds(ids);
		for(Long id: readIds) {
			ApiUrlExample example = new ApiUrlExample();
			ApiUrlExample.Criteria c1 = example.createCriteria();
			c1.andApiServerIdsEqualTo(id.toString());
			
			ApiUrlExample.Criteria c2 = example.createCriteria();
			c2.andApiServerIdsLike("%"+id+",%");
			
			ApiUrlExample.Criteria c3 = example.createCriteria();
			c3.andApiServerIdsLike("%,"+id+"%");
			
			example.or(c2);
			example.or(c3);
			
			long inUse = apiUrlService.countByExample(example);
			if(inUse>0) {
				haveInUse = true;
				break;
			}
		}
		
		if(haveInUse) {
			return AjaxResult.error("请先删除正在使用此服务的api");
		}else {
			ApiServerExample example = new ApiServerExample();
			example.createCriteria().andServerIdIn(readIds);
			if(serverService.deleteByExample(example)>0) {
				
				for(ApiServer server:serverService.selectByExample(example)) {
					HttpConnectionPool olPool = HttpClientUtils.clients.get(server.getServerUrl());
					olPool.closeConnectionPool();
					
		    		HttpClientUtils.clients.remove(server.getServerUrl());
				}
				serverService.refreshApiServerCache();
				
				for(Long serverId:readIds) {
					serverService.delServerAutoCheckJob(serverId);
				}
				
				return AjaxResult.success();
			}else {
				return AjaxResult.error();
			}
		}
	}
	
	@PostMapping("/checkNameUnique")
    @ResponseBody
    public String checkNameUnique(ApiServer server)
    {
        return serverService.checkNameUnique(server);
    }
	
	@PostMapping("/checkCodeUnique")
    @ResponseBody
    public String checkCodeUnique(ApiServer server)
    {
        return serverService.checkCodeUnique(server);
    }
}
