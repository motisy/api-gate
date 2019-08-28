package com.ruoyi.common.constant;

/**
 * 状态类型
 */
public enum AjaxResultType
{
    /** 成功 */
    SUCCESS(0),
    /** 警告 */
    WARN(301),
    /** 错误 */
    ERROR(500),
	/** api不存在*/
	API_NOT_EXISTS(501),
	/** 请求方式不支持 */
	REQUEST_METHOD_NOTSUPPORT(502),
	/** 参数错误 */
	PARAM_WRONG(503), 
	/** 无权限 */
	ACCOUNT_NO_API_ACCESS(504), 
	/** 访问次数已达上限 */
	ACCOUNT_API_REQUESTTIMES_LIMIT(505);
	
    public int value;

    AjaxResultType(int value)
    {
        this.value = value;
    }

    public int value()
    {
        return this.value;
    }
}
