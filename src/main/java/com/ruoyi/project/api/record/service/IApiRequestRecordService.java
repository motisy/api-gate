package com.ruoyi.project.api.record.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.record.domain.ApiRequestRecord;
import com.ruoyi.project.api.record.domain.ApiRequestRecordExample;

public interface IApiRequestRecordService extends XmlBaseService<ApiRequestRecord, Long, ApiRequestRecordExample> {

	void cleanAllRecord();

	void asyncRecord(Map<String, Object> recordMap, HttpServletRequest request, Map<String, String> params, List<String> fileNames);
}
