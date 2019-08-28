package com.ruoyi.project.api.record.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.aspectj.lang.annotation.Log;
import com.ruoyi.framework.aspectj.lang.enums.BusinessType;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.framework.web.domain.AjaxResult;
import com.ruoyi.framework.web.page.TableDataInfo;
import com.ruoyi.project.api.record.domain.ApiRequestRecord;
import com.ruoyi.project.api.record.domain.ApiRequestRecordExample;
import com.ruoyi.project.api.record.service.IApiRequestRecordService;

/**
 * 操作日志记录
 * 
 * @author ruoyi
 */
@Controller
@RequestMapping("/api/record")
public class ApiRequestRecordController extends BaseController
{
    private String prefix = "api/record";

    @Autowired
    private IApiRequestRecordService apiRequestRecordService;

    @RequiresPermissions("api:record:view")
    @GetMapping()
    public String operlog()
    {
        return prefix + "/requestRecord";
    }

    @RequiresPermissions("api:record:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(ApiRequestRecord apiRequestRecord)
    {
        startPage();
        
        ApiRequestRecordExample example = new ApiRequestRecordExample();
        ApiRequestRecordExample.Criteria c = example.createCriteria();
        if(apiRequestRecord.getApiId()!=null) {
        	c.andApiIdEqualTo(apiRequestRecord.getApiId());
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getAppKey())) {
        	c.andAppKeyLike(apiRequestRecord.getAppKey()+"%");
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getApiUrl())) {
        	c.andApiUrlLike(apiRequestRecord.getApiUrl()+"%");
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getForwardUrl())) {
        	c.andForwardUrlLike(apiRequestRecord.getForwardUrl()+"%");
        }
        if(apiRequestRecord.getForwardSuccess()!=null) {
        	c.andForwardSuccessEqualTo(apiRequestRecord.getForwardSuccess());
        }
        Map<String, Object> params = apiRequestRecord.getParams()==null?new HashMap<String, Object>():apiRequestRecord.getParams();
		if(params.get("beginTime")!=null && StringUtils.isNotBlank(params.get("beginTime").toString())) {
			try {
				c.andCreateTimeGreaterThanOrEqualTo(DateUtils.parseDate(params.get("beginTime").toString()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(params.get("endTime")!=null && StringUtils.isNotBlank(params.get("endTime").toString())) {
			try {
				c.andCreateTimeLessThanOrEqualTo(DateUtils.parseDate(params.get("endTime").toString()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		example.setOrderByClause("create_time desc");
        List<ApiRequestRecord> list = apiRequestRecordService.selectByExample(example);
        return getDataTable(list);
    }

    @Log(title = "操作日志", businessType = BusinessType.EXPORT)
    @RequiresPermissions("api:record:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(ApiRequestRecord apiRequestRecord)
    {
    	ApiRequestRecordExample example = new ApiRequestRecordExample();
        ApiRequestRecordExample.Criteria c = example.createCriteria();
        if(apiRequestRecord.getApiId()!=null) {
        	c.andApiIdEqualTo(apiRequestRecord.getApiId());
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getAppKey())) {
        	c.andAppKeyLike(apiRequestRecord.getAppKey()+"%");
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getApiUrl())) {
        	c.andApiUrlLike(apiRequestRecord.getApiUrl()+"%");
        }
        if(StringUtils.isNotBlank(apiRequestRecord.getForwardUrl())) {
        	c.andForwardUrlLike(apiRequestRecord.getForwardUrl()+"%");
        }
        if(apiRequestRecord.getForwardSuccess()!=null) {
        	c.andForwardSuccessEqualTo(apiRequestRecord.getForwardSuccess());
        }
        Map<String, Object> params = apiRequestRecord.getParams()==null?new HashMap<String, Object>():apiRequestRecord.getParams();
		if(params.get("beginTime")!=null && StringUtils.isNotBlank(params.get("beginTime").toString())) {
			try {
				c.andCreateTimeGreaterThanOrEqualTo(DateUtils.parseDate(params.get("beginTime").toString()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(params.get("endTime")!=null && StringUtils.isNotBlank(params.get("endTime").toString())) {
			try {
				c.andCreateTimeLessThanOrEqualTo(DateUtils.parseDate(params.get("endTime").toString()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		example.setOrderByClause("create_time desc");
        List<ApiRequestRecord> list = apiRequestRecordService.selectByExample(example);
        
        ExcelUtil<ApiRequestRecord> util = new ExcelUtil<ApiRequestRecord>(ApiRequestRecord.class);
        return util.exportExcel(list, "请求日志");
    }

    @RequiresPermissions("api:record:detail")
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Long id, ModelMap mmap)
    {
        mmap.put("record", apiRequestRecordService.selectByPrimaryKey(id));
        return prefix + "/detail";
    }
    
    @Log(title = "操作日志", businessType = BusinessType.CLEAN)
    @RequiresPermissions("api:record:remove")
    @PostMapping("/clean")
    @ResponseBody
    public AjaxResult clean()
    {
        apiRequestRecordService.cleanAllRecord();
        return success();
    }
}
