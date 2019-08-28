package com.ruoyi.project.api.apiurl.service;

import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.domain.ApiUrlExample;

/**
 * api服务 服务层
 * 
 * @author 陈阳
 * @date 2019-08-05
 */
public interface IApiUrlService extends XmlBaseService<ApiUrl, Long, ApiUrlExample>
{

	String checkNameUnique(ApiUrl apiUrl);
	
	/**
	 * 刷新redis中api的缓存
	 * <p>Title: refreshApiUrlCache</p>  
	 * <p>Description: </p>
	 * @author 陈阳  
	 * @date 2019年8月19日
	 */
	void refreshApiUrlCache();
	
}
