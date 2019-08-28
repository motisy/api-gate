package com.ruoyi.framework.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 读取项目相关配置
 * 
 * @author ruoyi
 */
@Component
public class ApiConfig
{
    /** 项目名称 */
	@Value("${openapi.domain}")
	public String domain;
	
	@Value("${openapi.preurl}")
	public String preurl;
	
	@Value("${openapi.md5key}")
	public String md5key;

	public String getMd5key() {
		return md5key;
	}

	public void setMd5key(String md5key) {
		this.md5key = md5key;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public String getPreurl() {
		return preurl;
	}

	public void setPreurl(String preurl) {
		this.preurl = preurl;
	}
}