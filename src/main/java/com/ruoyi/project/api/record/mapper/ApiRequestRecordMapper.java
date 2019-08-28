package com.ruoyi.project.api.record.mapper;

import com.ruoyi.common.base.mapper.XmlMapper;
import com.ruoyi.project.api.record.domain.ApiRequestRecord;

public interface ApiRequestRecordMapper extends XmlMapper<ApiRequestRecord> {
	void cleanAllRecord();
}