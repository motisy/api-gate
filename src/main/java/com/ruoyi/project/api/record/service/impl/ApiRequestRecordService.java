package com.ruoyi.project.api.record.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.base.mapper.XmlMapper;
import com.ruoyi.common.base.service.impl.XmlBaseServiceImpl;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.MapBeanUtil;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;
import com.ruoyi.project.api.record.domain.ApiRequestRecord;
import com.ruoyi.project.api.record.domain.ApiRequestRecordExample;
import com.ruoyi.project.api.record.mapper.ApiRequestRecordMapper;
import com.ruoyi.project.api.record.service.IApiRequestRecordService;
import com.ruoyi.project.api.server.domain.ApiServer;
import com.ruoyi.project.api.server.service.IApiServerService;

@Service
public class ApiRequestRecordService extends XmlBaseServiceImpl<ApiRequestRecord, Long, XmlMapper<ApiRequestRecord>, ApiRequestRecordExample> implements IApiRequestRecordService {

	@Autowired
	private IApiUrlService apiUrlService;
	
	@Autowired
	private IApiServerService apiServerService; 
	
	@Override
	public void cleanAllRecord() {
		((ApiRequestRecordMapper)mapper).cleanAllRecord();
	}

	@Async
	@Override
	public void asyncRecord(Map<String, Object> recordMap, HttpServletRequest request, Map<String, String> params, List<String> fileNames) {
		recordMap.put("requestParams", buildParamJson(request, params, fileNames));
		ApiRequestRecord record = null;
		try {
			record = MapBeanUtil.mapToBean(recordMap, ApiRequestRecord.class);
			
			record.setCreateBy("System");
			record.setCreateTime(DateUtils.getNowDate());
			
			ApiUrl api = apiUrlService.selectByPrimaryKey(record.getApiId());
			record.setApiName(api.getApiName());
			record.setApiUrl(api.getApiUrlSuffix());
			
			ApiServer server = apiServerService.selectByPrimaryKey(record.getServerId());
			record.setServerName(server.getServerName());
			
//			mapper.insert(record);
		} catch (Exception e) {
//			e.printStackTrace();
		} finally {
			if(record!=null) {
				mapper.insert(record);
			}
		}
	}

	private String buildParamJson(HttpServletRequest request, Map<String, String> params, List<String> fileNames) {
		JSONObject normalParams = JSONObject.parseObject(JSONObject.toJSONString(params));
		if(fileNames!=null && fileNames.size()>0) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			for(String fileNameKey : fileNames) {
				List<MultipartFile> files =  multipartRequest.getFiles(fileNameKey);
				List<String> fNames = new ArrayList<>();
				for(MultipartFile f:files) {
					fNames.add(f.getOriginalFilename());
				}
				normalParams.put(fileNameKey, fNames);
			}
		}
		return normalParams.toJSONString();
	}

}
