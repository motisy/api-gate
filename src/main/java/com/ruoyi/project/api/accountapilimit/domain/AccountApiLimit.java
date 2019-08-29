package com.ruoyi.project.api.accountapilimit.domain;

import java.text.ParseException;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.framework.web.domain.BaseEntity;
import com.ruoyi.project.api.account.domain.ApiAccount;
import com.ruoyi.project.api.account.service.IApiAccountService;
import com.ruoyi.project.api.apiurl.domain.ApiUrl;
import com.ruoyi.project.api.apiurl.service.IApiUrlService;

public class AccountApiLimit extends BaseEntity {
	
	public final static String LIMIT_TYPE_TIME = "time_limit";
	public final static String LIMIT_TYPE_TOTAL = "total_limit";
	
	public final static String LIMIT_TYPE_TIME_UNIT_MINUTE = "minute";
	public final static String LIMIT_TYPE_TIME_UNIT_HOUR = "hour";
	public final static String LIMIT_TYPE_TIME_UNIT_DAY = "day";
	
    /** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Boolean hasLimit;

    private String limitType;

    private Integer limitNumber;

    private Integer limitTimeNumber;

    private String limitTimeUnit;
    
    private Integer limitRestNumber;
    
    private Long accountId;

    private Long apiId;
    
    private ApiAccount apiAccount;
    private ApiUrl apiUrl;
    
    private String des;
    
    public ApiAccount getApiAccount() {
    	if(accountId!=null) {
    		this.apiAccount = SpringUtils.getBean(IApiAccountService.class).selectByPrimaryKey(accountId);
    	}
		return apiAccount;
	}

	public void setApiAccount(ApiAccount apiAccount) {
		this.apiAccount = apiAccount;
	}

	public ApiUrl getApiUrl() {
		if(apiId!=null) {
    		this.apiUrl = SpringUtils.getBean(IApiUrlService.class).selectByPrimaryKey(apiId);
    	}
		return apiUrl;
	}

	public void setApiUrl(ApiUrl apiUrl) {
		this.apiUrl = apiUrl;
	}

	public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Long getApiId() {
        return apiId;
    }

    public void setApiId(Long apiId) {
        this.apiId = apiId;
    }

    public Boolean getHasLimit() {
        return hasLimit;
    }

    public void setHasLimit(Boolean hasLimit) {
        this.hasLimit = hasLimit;
    }

    public String getLimitType() {
        return limitType;
    }

    public void setLimitType(String limitType) {
        this.limitType = limitType == null ? null : limitType.trim();
    }

    public Integer getLimitNumber() {
        return limitNumber;
    }

    public void setLimitNumber(Integer limitNumber) {
        this.limitNumber = limitNumber;
    }

    public Integer getLimitTimeNumber() {
        return limitTimeNumber;
    }

    public void setLimitTimeNumber(Integer limitTimeNumber) {
        this.limitTimeNumber = limitTimeNumber;
    }

    public String getLimitTimeUnit() {
        return limitTimeUnit;
    }

    public void setLimitTimeUnit(String limitTimeUnit) {
        this.limitTimeUnit = limitTimeUnit == null ? null : limitTimeUnit.trim();
    }

	public Integer getLimitRestNumber() {
		String k = ApiRedisConstants.ACCOUNT_API_LIMIT_REST_NUMBER+getApiAccount().getAppKey()+getApiUrl().getApiUrlSuffix();
		RedisUtil redisUtil = SpringUtils.getBean(RedisUtil.class);
		
		Object restNumber = redisUtil.get(k);
		
		if(hasLimit && restNumber==null) {
			
			if(limitType.equals(AccountApiLimit.LIMIT_TYPE_TOTAL)) {
				redisUtil.set(k, getLimitNumber());
			}else {
				//时间范围的单位，minute/hour/day
				String unit = getLimitTimeUnit();
				
				redisUtil.set(k, getLimitNumber());
				if(!unit.equals("day")) {
					redisUtil.expire(k, getLimitTimeNumber()* (unit.equals("minute")?60:3600));
				}else {
					//过期时间设为零点
					String date = DateUtils.getDate()+" 11:59:59";
					try {
						redisUtil.expireAt(k, DateUtils.parseDate(date, DateUtils.YYYY_MM_DD_HH_MM_SS));
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
		limitRestNumber = (Integer) redisUtil.get(k);
		return limitRestNumber;
	}

	public void setLimitRestNumber(Integer limitRestNumber) {
		this.limitRestNumber = limitRestNumber;
	}

	public String getDes() {
		if(this.des == null) {
			if(hasLimit) {
				if(limitType.equals("time_limit")) {
//					minute/hour/day
					String unit = this.limitTimeUnit.equals("minute")?"分钟":(this.limitTimeUnit.equals("hour")?"小时":"天");
					this.des = this.limitNumber+"次/" + this.limitTimeNumber + unit;
				}else {
					this.des = "总访问次数为"+this.limitTimeNumber+"次";
				}
			}else {
				this.des = "无限制";
			}
			
		}
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}
}