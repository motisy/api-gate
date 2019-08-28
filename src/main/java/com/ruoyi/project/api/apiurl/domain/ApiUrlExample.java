package com.ruoyi.project.api.apiurl.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ApiUrlExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ApiUrlExample() {
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

        public Criteria andApiIdIsNull() {
            addCriterion("api_id is null");
            return (Criteria) this;
        }

        public Criteria andApiIdIsNotNull() {
            addCriterion("api_id is not null");
            return (Criteria) this;
        }

        public Criteria andApiIdEqualTo(Long value) {
            addCriterion("api_id =", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdNotEqualTo(Long value) {
            addCriterion("api_id <>", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdGreaterThan(Long value) {
            addCriterion("api_id >", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdGreaterThanOrEqualTo(Long value) {
            addCriterion("api_id >=", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdLessThan(Long value) {
            addCriterion("api_id <", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdLessThanOrEqualTo(Long value) {
            addCriterion("api_id <=", value, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdIn(List<Long> values) {
            addCriterion("api_id in", values, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdNotIn(List<Long> values) {
            addCriterion("api_id not in", values, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdBetween(Long value1, Long value2) {
            addCriterion("api_id between", value1, value2, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiIdNotBetween(Long value1, Long value2) {
            addCriterion("api_id not between", value1, value2, "apiId");
            return (Criteria) this;
        }

        public Criteria andApiNameIsNull() {
            addCriterion("api_name is null");
            return (Criteria) this;
        }

        public Criteria andApiNameIsNotNull() {
            addCriterion("api_name is not null");
            return (Criteria) this;
        }

        public Criteria andApiNameEqualTo(String value) {
            addCriterion("api_name =", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameNotEqualTo(String value) {
            addCriterion("api_name <>", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameGreaterThan(String value) {
            addCriterion("api_name >", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameGreaterThanOrEqualTo(String value) {
            addCriterion("api_name >=", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameLessThan(String value) {
            addCriterion("api_name <", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameLessThanOrEqualTo(String value) {
            addCriterion("api_name <=", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameLike(String value) {
            addCriterion("api_name like", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameNotLike(String value) {
            addCriterion("api_name not like", value, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameIn(List<String> values) {
            addCriterion("api_name in", values, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameNotIn(List<String> values) {
            addCriterion("api_name not in", values, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameBetween(String value1, String value2) {
            addCriterion("api_name between", value1, value2, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiNameNotBetween(String value1, String value2) {
            addCriterion("api_name not between", value1, value2, "apiName");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdIsNull() {
            addCriterion("api_group_id is null");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdIsNotNull() {
            addCriterion("api_group_id is not null");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdEqualTo(Long value) {
            addCriterion("api_group_id =", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdNotEqualTo(Long value) {
            addCriterion("api_group_id <>", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdGreaterThan(Long value) {
            addCriterion("api_group_id >", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdGreaterThanOrEqualTo(Long value) {
            addCriterion("api_group_id >=", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdLessThan(Long value) {
            addCriterion("api_group_id <", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdLessThanOrEqualTo(Long value) {
            addCriterion("api_group_id <=", value, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdIn(List<Long> values) {
            addCriterion("api_group_id in", values, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdNotIn(List<Long> values) {
            addCriterion("api_group_id not in", values, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdBetween(Long value1, Long value2) {
            addCriterion("api_group_id between", value1, value2, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiGroupIdNotBetween(Long value1, Long value2) {
            addCriterion("api_group_id not between", value1, value2, "apiGroupId");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodIsNull() {
            addCriterion("api_request_method is null");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodIsNotNull() {
            addCriterion("api_request_method is not null");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodEqualTo(String value) {
            addCriterion("api_request_method =", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodNotEqualTo(String value) {
            addCriterion("api_request_method <>", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodGreaterThan(String value) {
            addCriterion("api_request_method >", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodGreaterThanOrEqualTo(String value) {
            addCriterion("api_request_method >=", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodLessThan(String value) {
            addCriterion("api_request_method <", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodLessThanOrEqualTo(String value) {
            addCriterion("api_request_method <=", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodLike(String value) {
            addCriterion("api_request_method like", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodNotLike(String value) {
            addCriterion("api_request_method not like", value, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodIn(List<String> values) {
            addCriterion("api_request_method in", values, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodNotIn(List<String> values) {
            addCriterion("api_request_method not in", values, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodBetween(String value1, String value2) {
            addCriterion("api_request_method between", value1, value2, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiRequestMethodNotBetween(String value1, String value2) {
            addCriterion("api_request_method not between", value1, value2, "apiRequestMethod");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsIsNull() {
            addCriterion("api_server_ids is null");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsIsNotNull() {
            addCriterion("api_server_ids is not null");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsEqualTo(String value) {
            addCriterion("api_server_ids =", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsNotEqualTo(String value) {
            addCriterion("api_server_ids <>", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsGreaterThan(String value) {
            addCriterion("api_server_ids >", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsGreaterThanOrEqualTo(String value) {
            addCriterion("api_server_ids >=", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsLessThan(String value) {
            addCriterion("api_server_ids <", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsLessThanOrEqualTo(String value) {
            addCriterion("api_server_ids <=", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsLike(String value) {
            addCriterion("api_server_ids like", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsNotLike(String value) {
            addCriterion("api_server_ids not like", value, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsIn(List<String> values) {
            addCriterion("api_server_ids in", values, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsNotIn(List<String> values) {
            addCriterion("api_server_ids not in", values, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsBetween(String value1, String value2) {
            addCriterion("api_server_ids between", value1, value2, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiServerIdsNotBetween(String value1, String value2) {
            addCriterion("api_server_ids not between", value1, value2, "apiServerIds");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixIsNull() {
            addCriterion("api_url_suffix is null");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixIsNotNull() {
            addCriterion("api_url_suffix is not null");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixEqualTo(String value) {
            addCriterion("api_url_suffix =", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixNotEqualTo(String value) {
            addCriterion("api_url_suffix <>", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixGreaterThan(String value) {
            addCriterion("api_url_suffix >", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixGreaterThanOrEqualTo(String value) {
            addCriterion("api_url_suffix >=", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixLessThan(String value) {
            addCriterion("api_url_suffix <", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixLessThanOrEqualTo(String value) {
            addCriterion("api_url_suffix <=", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixLike(String value) {
            addCriterion("api_url_suffix like", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixNotLike(String value) {
            addCriterion("api_url_suffix not like", value, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixIn(List<String> values) {
            addCriterion("api_url_suffix in", values, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixNotIn(List<String> values) {
            addCriterion("api_url_suffix not in", values, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixBetween(String value1, String value2) {
            addCriterion("api_url_suffix between", value1, value2, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiUrlSuffixNotBetween(String value1, String value2) {
            addCriterion("api_url_suffix not between", value1, value2, "apiUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixIsNull() {
            addCriterion("api_server_url_suffix is null");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixIsNotNull() {
            addCriterion("api_server_url_suffix is not null");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixEqualTo(String value) {
            addCriterion("api_server_url_suffix =", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixNotEqualTo(String value) {
            addCriterion("api_server_url_suffix <>", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixGreaterThan(String value) {
            addCriterion("api_server_url_suffix >", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixGreaterThanOrEqualTo(String value) {
            addCriterion("api_server_url_suffix >=", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixLessThan(String value) {
            addCriterion("api_server_url_suffix <", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixLessThanOrEqualTo(String value) {
            addCriterion("api_server_url_suffix <=", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixLike(String value) {
            addCriterion("api_server_url_suffix like", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixNotLike(String value) {
            addCriterion("api_server_url_suffix not like", value, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixIn(List<String> values) {
            addCriterion("api_server_url_suffix in", values, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixNotIn(List<String> values) {
            addCriterion("api_server_url_suffix not in", values, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixBetween(String value1, String value2) {
            addCriterion("api_server_url_suffix between", value1, value2, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerUrlSuffixNotBetween(String value1, String value2) {
            addCriterion("api_server_url_suffix not between", value1, value2, "apiServerUrlSuffix");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayIsNull() {
            addCriterion("api_server_request_way is null");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayIsNotNull() {
            addCriterion("api_server_request_way is not null");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayEqualTo(String value) {
            addCriterion("api_server_request_way =", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayNotEqualTo(String value) {
            addCriterion("api_server_request_way <>", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayGreaterThan(String value) {
            addCriterion("api_server_request_way >", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayGreaterThanOrEqualTo(String value) {
            addCriterion("api_server_request_way >=", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayLessThan(String value) {
            addCriterion("api_server_request_way <", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayLessThanOrEqualTo(String value) {
            addCriterion("api_server_request_way <=", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayLike(String value) {
            addCriterion("api_server_request_way like", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayNotLike(String value) {
            addCriterion("api_server_request_way not like", value, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayIn(List<String> values) {
            addCriterion("api_server_request_way in", values, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayNotIn(List<String> values) {
            addCriterion("api_server_request_way not in", values, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayBetween(String value1, String value2) {
            addCriterion("api_server_request_way between", value1, value2, "apiServerRequestWay");
            return (Criteria) this;
        }

        public Criteria andApiServerRequestWayNotBetween(String value1, String value2) {
            addCriterion("api_server_request_way not between", value1, value2, "apiServerRequestWay");
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