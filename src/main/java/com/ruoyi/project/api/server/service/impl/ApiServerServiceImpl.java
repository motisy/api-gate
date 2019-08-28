package com.ruoyi.project.api.server.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.domain.ApiServerExample;
import com.ruoyi.project.api.server.domain.ApiServerGroup;
import com.ruoyi.project.api.server.mapper.ApiServerMapper;
import com.ruoyi.project.api.server.service.IApiServerGroupService;
import com.ruoyi.project.api.server.service.IApiServerService;
import com.ruoyi.project.monitor.job.domain.Job;
import com.ruoyi.project.monitor.job.service.IJobService;

/**
 * api服务 服务层实现
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
@Service
public class ApiServerServiceImpl extends XmlBaseServiceImpl<ApiServer, Long, ApiServerMapper, ApiServerExample> implements IApiServerService
{

	@Autowired
	private RedisUtil redisUtil;
	
	@Autowired
	IJobService jobService;
	
	@Override
	public String checkNameUnique(ApiServer server) {
		Long id = StringUtils.isNull(server.getServerId()) ? -1L : server.getServerId();
		
		ApiServerExample example = new ApiServerExample();
		example.createCriteria().andServerNameEqualTo(server.getServerName());
		List<ApiServer> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getServerId()!=id)
        {
            return "1";
        }
        return "0";
	}
	
	@Override
	public String checkCodeUnique(ApiServer server) {
		Long id = StringUtils.isNull(server.getServerId()) ? -1L : server.getServerId();
		
		ApiServerExample example = new ApiServerExample();
		example.createCriteria().andServerCodeEqualTo(server.getServerCode());
		List<ApiServer> list = mapper.selectByExample(example);
        if (list!=null && list.size() > 0 && list.get(0).getServerId()!=id)
        {
            return "1";
        }
        return "0";
	}

	@Override
	public Map<ApiServerGroup, List<ApiServer>> allGroups() {
		IApiServerGroupService apiServerGroupService = SpringUtils.getBean(IApiServerGroupService.class);
		List<ApiServerGroup> list = apiServerGroupService.selectByExample(null);
		
		@SuppressWarnings("unchecked")
		Map<ApiServerGroup, List<ApiServer>> groups = new LinkedMap(list.size()+1);
		
		ApiServerGroup g1 = new ApiServerGroup();
		g1.setServerGroupId(null);
		g1.setServerGroupName("默认分组");
		ApiServerExample example1 = new ApiServerExample();
		example1.createCriteria().andServerGroupIsNull();
		groups.put(g1, mapper.selectByExample(example1));
		
		for(ApiServerGroup g:list) {
			ApiServerExample example = new ApiServerExample();
			example.createCriteria().andServerGroupIsNotNull().andServerGroupEqualTo(g.getServerGroupId());
			List<ApiServer> servers = mapper.selectByExample(example);
			groups.put(g, servers);
		}
		
        return groups;
	}

	@Override
	public void refreshApiServerCache() {
		redisUtil.deleteByPrex(ApiRedisConstants.API_SERVER);
		List<ApiServer> servers = mapper.selectByExample(null);
		Map<Object, Object> map = new HashMap<>();
		
		for(ApiServer server:servers) {
			map.put(server.getServerId().toString(), server);
		}
		redisUtil.hmset(ApiRedisConstants.API_SERVER, map);
	}
	
	/**
	 * 删除相关任务
	 * @param serverId
	 */
	public void delServerAutoCheckJob(Long serverId) {
		String jobName = "API_SERVER_CHECK_"+serverId;
		String jobGroup = "API_SERVER_CHECK";
		Job jobFilter = new Job();
		jobFilter.setJobName(jobName);
		jobFilter.setJobGroup(jobGroup);
		List<Job> jobs = jobService.selectJobList(jobFilter);
		if(jobs!=null && jobs.size()>0) {
			for(Job j:jobs) {
				try {
					jobService.deleteJob(j);
				} catch (Exception e) {
				}
			}
		}
	}
	
	/**
	 * 根据apiserver的设置，创建或删除定时任务
	 * @param server
	 */
	public void serverAutoCheck(ApiServer server) {
		String jobName = "API_SERVER_CHECK_"+server.getServerId();
		String jobGroup = "API_SERVER_CHECK";
		delServerAutoCheckJob(server.getServerId());
		
		if(server.getServerAutoCheck()) {
			Job job = new Job();
			job.setJobName(jobName);
			job.setJobGroup(jobGroup);
			job.setInvokeTarget("apiServerCheck.check("+server.getServerId()+"L)");
			job.setCronExpression("0 0/"+server.getCheckCycleMinute()+" * * * ?");
			job.setConcurrent("1");
			job.setMisfirePolicy("1");
			job.setStatus("0");
			
			try {
				jobService.insertJob(job);
				//插入后默认是暂停，手动启用一下任务
				jobService.resumeJob(job);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			
		}
	}
}
