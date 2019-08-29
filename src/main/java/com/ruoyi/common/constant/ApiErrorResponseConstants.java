package com.ruoyi.common.constant;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.framework.web.domain.AjaxResult;

/**
 * 一系列json错误，统一返回false，表示有错误
 * <p>Title: ApiResponseConstants</p>  
 * <p>Description: </p>  
 * @author 陈阳  
 * @date 2019年8月21日
 */
public class ApiErrorResponseConstants {
	
	public final static Integer API_NOT_EXISTS = 401;
	
	public final static Boolean API_NOT_EXISTS(HttpServletResponse response, String message) {
		return response(response, message, "此api不存在", AjaxResultType.API_NOT_EXISTS);
	}
	
	public final static Boolean REQUEST_METHOD_NOTSUPPORT(HttpServletResponse response, String message) {
		return response(response, message, "请求方式不支持", AjaxResultType.REQUEST_METHOD_NOTSUPPORT);
	}
	
	public final static Boolean PARAM_WRONG(HttpServletResponse response, String message) {
		return response(response, message, "参数不正确", AjaxResultType.PARAM_WRONG);
	}
	
	public final static Boolean ACCOUNT_NO_API_ACCESS(HttpServletResponse response, String message) {
		return response(response, message, "账号无权限", AjaxResultType.ACCOUNT_NO_API_ACCESS);
	}
	
	public final static Boolean ACCOUNT_API_REQUESTTIMES_LIMIT(HttpServletResponse response, String message) {
		return response(response, message, "访问次数已达上限！", AjaxResultType.ACCOUNT_API_REQUESTTIMES_LIMIT);
	}
	
	public final static Boolean NO_SERVER(HttpServletResponse response, String message) {
		return response(response, message, "未找到服务器", AjaxResultType.ERROR);
	}
	
	public final static Boolean FORWARD_ERROR(HttpServletResponse response, String message) {
		return response(response, message, "转发失败", AjaxResultType.ERROR);
	}
	
	public final static Boolean ERROR(HttpServletResponse response, String message) {
		return response(response, message, "系统错误", AjaxResultType.ERROR);
	}
	
	public final static Boolean response(HttpServletResponse response, String message, String defaultMessage, AjaxResultType type) {
		AjaxResult result = new AjaxResult(type, StringUtils.isNotBlank(message)?message:defaultMessage, null);
		JSONObject jsonObj = (JSONObject) JSON.toJSON(result);
		return reponseJson(response, jsonObj);
	}
	
	public final static Boolean response(HttpServletResponse response, Object data, String message, String defaultMessage, AjaxResultType type) {
		AjaxResult result = new AjaxResult(type, StringUtils.isNotBlank(message)?message:defaultMessage, data);
		JSONObject jsonObj = (JSONObject) JSON.toJSON(result);
		return reponseJson(response, jsonObj);
	}
	
	public static boolean reponseJson(HttpServletResponse reponse, JSONObject json) {
		reponse.setCharacterEncoding("utf-8");
		reponse.setContentType("application/json; charset=utf-8");
		PrintWriter writer=null;
		try {
			writer = reponse.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		writer.write(json.toString());
		
		writer.close();
		try {
			reponse.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
