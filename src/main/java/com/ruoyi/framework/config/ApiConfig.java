package com.ruoyi.framework.config;

import org.apache.commons.lang3.StringUtils;
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
	
//	server:
//		  # 服务器的HTTP端口，默认为80
//		  port: 8089
//		  servlet:
//		    # 应用的访问路径
//		    context-path: /apiGate
	@Value("${server.port}")
	public String port;
	
	@Value("${server.servlet.context-path}")
	public String contextPath;
	
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
		if(StringUtils.isBlank(domain)) {
			this.domain = "http://localhost:"+port+contextPath;
		}
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

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getContextPath() {
		return contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
}