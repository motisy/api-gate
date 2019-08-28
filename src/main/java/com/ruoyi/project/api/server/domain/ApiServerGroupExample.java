package com.ruoyi.project.api.server.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ApiServerGroupExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ApiServerGroupExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andServerGroupIdIsNull() {
            addCriterion("server_group_id is null");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdIsNotNull() {
            addCriterion("server_group_id is not null");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdEqualTo(Long value) {
            addCriterion("server_group_id =", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdNotEqualTo(Long value) {
            addCriterion("server_group_id <>", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdGreaterThan(Long value) {
            addCriterion("server_group_id >", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdGreaterThanOrEqualTo(Long value) {
            addCriterion("server_group_id >=", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdLessThan(Long value) {
            addCriterion("server_group_id <", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdLessThanOrEqualTo(Long value) {
            addCriterion("server_group_id <=", value, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdIn(List<Long> values) {
            addCriterion("server_group_id in", values, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdNotIn(List<Long> values) {
            addCriterion("server_group_id not in", values, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdBetween(Long value1, Long value2) {
            addCriterion("server_group_id between", value1, value2, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupIdNotBetween(Long value1, Long value2) {
            addCriterion("server_group_id not between", value1, value2, "serverGroupId");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameIsNull() {
            addCriterion("server_group_name is null");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameIsNotNull() {
            addCriterion("server_group_name is not null");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameEqualTo(String value) {
            addCriterion("server_group_name =", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameNotEqualTo(String value) {
            addCriterion("server_group_name <>", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameGreaterThan(String value) {
            addCriterion("server_group_name >", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameGreaterThanOrEqualTo(String value) {
            addCriterion("server_group_name >=", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameLessThan(String value) {
            addCriterion("server_group_name <", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameLessThanOrEqualTo(String value) {
            addCriterion("server_group_name <=", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameLike(String value) {
            addCriterion("server_group_name like", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameNotLike(String value) {
            addCriterion("server_group_name not like", value, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameIn(List<String> values) {
            addCriterion("server_group_name in", values, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameNotIn(List<String> values) {
            addCriterion("server_group_name not in", values, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameBetween(String value1, String value2) {
            addCriterion("server_group_name between", value1, value2, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupNameNotBetween(String value1, String value2) {
            addCriterion("server_group_name not between", value1, value2, "serverGroupName");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeIsNull() {
            addCriterion("server_group_code is null");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeIsNotNull() {
            addCriterion("server_group_code is not null");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeEqualTo(String value) {
            addCriterion("server_group_code =", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeNotEqualTo(String value) {
            addCriterion("server_group_code <>", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeGreaterThan(String value) {
            addCriterion("server_group_code >", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeGreaterThanOrEqualTo(String value) {
            addCriterion("server_group_code >=", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeLessThan(String value) {
            addCriterion("server_group_code <", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeLessThanOrEqualTo(String value) {
            addCriterion("server_group_code <=", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeLike(String value) {
            addCriterion("server_group_code like", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeNotLike(String value) {
            addCriterion("server_group_code not like", value, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeIn(List<String> values) {
            addCriterion("server_group_code in", values, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeNotIn(List<String> values) {
            addCriterion("server_group_code not in", values, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeBetween(String value1, String value2) {
            addCriterion("server_group_code between", value1, value2, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andServerGroupCodeNotBetween(String value1, String value2) {
            addCriterion("server_group_code not between", value1, value2, "serverGroupCode");
            return (Criteria) this;
        }

        public Criteria andCreateByIsNull() {
            addCriterion("create_by is null");
            return (Criteria) this;
        }

        public Criteria andCreateByIsNotNull() {
            addCriterion("create_by is not null");
            return (Criteria) this;
        }

        public Criteria andCreateByEqualTo(String value) {
            addCriterion("create_by =", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByNotEqualTo(String value) {
            addCriterion("create_by <>", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByGreaterThan(String value) {
            addCriterion("create_by >", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByGreaterThanOrEqualTo(String value) {
            addCriterion("create_by >=", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByLessThan(String value) {
            addCriterion("create_by <", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByLessThanOrEqualTo(String value) {
            addCriterion("create_by <=", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByLike(String value) {
            addCriterion("create_by like", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByNotLike(String value) {
            addCriterion("create_by not like", value, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByIn(List<String> values) {
            addCriterion("create_by in", values, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByNotIn(List<String> values) {
            addCriterion("create_by not in", values, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByBetween(String value1, String value2) {
            addCriterion("create_by between", value1, value2, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateByNotBetween(String value1, String value2) {
            addCriterion("create_by not between", value1, value2, "createBy");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNull() {
            addCriterion("create_time is null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNotNull() {
            addCriterion("create_time is not null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeEqualTo(Date value) {
            addCriterion("create_time =", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotEqualTo(Date value) {
            addCriterion("create_time <>", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThan(Date value) {
            addCriterion("create_time >", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("create_time >=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThan(Date value) {
            addCriterion("create_time <", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThanOrEqualTo(Date value) {
            addCriterion("create_time <=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIn(List<Date> values) {
            addCriterion("create_time in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotIn(List<Date> values) {
            addCriterion("create_time not in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeBetween(Date value1, Date value2) {
            addCriterion("create_time between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotBetween(Date value1, Date value2) {
            addCriterion("create_time not between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andUpdateByIsNull() {
            addCriterion("update_by is null");
            return (Criteria) this;
        }

        public Criteria andUpdateByIsNotNull() {
            addCriterion("update_by is not null");
            return (Criteria) this;
        }

        public Criteria andUpdateByEqualTo(String value) {
            addCriterion("update_by =", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByNotEqualTo(String value) {
            addCriterion("update_by <>", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByGreaterThan(String value) {
            addCriterion("update_by >", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByGreaterThanOrEqualTo(String value) {
            addCriterion("update_by >=", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByLessThan(String value) {
            addCriterion("update_by <", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByLessThanOrEqualTo(String value) {
            addCriterion("update_by <=", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByLike(String value) {
            addCriterion("update_by like", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByNotLike(String value) {
            addCriterion("update_by not like", value, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByIn(List<String> values) {
            addCriterion("update_by in", values, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByNotIn(List<String> values) {
            addCriterion("update_by not in", values, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByBetween(String value1, String value2) {
            addCriterion("update_by between", value1, value2, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateByNotBetween(String value1, String value2) {
            addCriterion("update_by not between", value1, value2, "updateBy");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIsNull() {
            addCriterion("update_time is null");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIsNotNull() {
            addCriterion("update_time is not null");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeEqualTo(Date value) {
            addCriterion("update_time =", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotEqualTo(Date value) {
            addCriterion("update_time <>", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeGreaterThan(Date value) {
            addCriterion("update_time >", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("update_time >=", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeLessThan(Date value) {
            addCriterion("update_time <", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeLessThanOrEqualTo(Date value) {
            addCriterion("update_time <=", value, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeIn(List<Date> values) {
            addCriterion("update_time in", values, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotIn(List<Date> values) {
            addCriterion("update_time not in", values, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeBetween(Date value1, Date value2) {
            addCriterion("update_time between", value1, value2, "updateTime");
            return (Criteria) this;
        }

        public Criteria andUpdateTimeNotBetween(Date value1, Date value2) {
            addCriterion("update_time not between", value1, value2, "updateTime");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNull() {
            addCriterion("remark is null");
            return (Criteria) this;
        }

        public Criteria andRemarkIsNotNull() {
            addCriterion("remark is not null");
            return (Criteria) this;
        }

        public Criteria andRemarkEqualTo(String value) {
            addCriterion("remark =", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotEqualTo(String value) {
            addCriterion("remark <>", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThan(String value) {
            addCriterion("remark >", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkGreaterThanOrEqualTo(String value) {
            addCriterion("remark >=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThan(String value) {
            addCriterion("remark <", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLessThanOrEqualTo(String value) {
            addCriterion("remark <=", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkLike(String value) {
            addCriterion("remark like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotLike(String value) {
            addCriterion("remark not like", value, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkIn(List<String> values) {
            addCriterion("remark in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotIn(List<String> values) {
            addCriterion("remark not in", values, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkBetween(String value1, String value2) {
            addCriterion("remark between", value1, value2, "remark");
            return (Criteria) this;
        }

        public Criteria andRemarkNotBetween(String value1, String value2) {
            addCriterion("remark not between", value1, value2, "remark");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}