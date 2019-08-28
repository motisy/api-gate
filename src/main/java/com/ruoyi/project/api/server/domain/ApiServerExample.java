package com.ruoyi.project.api.server.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ApiServerExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ApiServerExample() {
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

        public Criteria andServerIdIsNull() {
            addCriterion("server_id is null");
            return (Criteria) this;
        }

        public Criteria andServerIdIsNotNull() {
            addCriterion("server_id is not null");
            return (Criteria) this;
        }

        public Criteria andServerIdEqualTo(Long value) {
            addCriterion("server_id =", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdNotEqualTo(Long value) {
            addCriterion("server_id <>", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdGreaterThan(Long value) {
            addCriterion("server_id >", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdGreaterThanOrEqualTo(Long value) {
            addCriterion("server_id >=", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdLessThan(Long value) {
            addCriterion("server_id <", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdLessThanOrEqualTo(Long value) {
            addCriterion("server_id <=", value, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdIn(List<Long> values) {
            addCriterion("server_id in", values, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdNotIn(List<Long> values) {
            addCriterion("server_id not in", values, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdBetween(Long value1, Long value2) {
            addCriterion("server_id between", value1, value2, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerIdNotBetween(Long value1, Long value2) {
            addCriterion("server_id not between", value1, value2, "serverId");
            return (Criteria) this;
        }

        public Criteria andServerNameIsNull() {
            addCriterion("server_name is null");
            return (Criteria) this;
        }

        public Criteria andServerNameIsNotNull() {
            addCriterion("server_name is not null");
            return (Criteria) this;
        }

        public Criteria andServerNameEqualTo(String value) {
            addCriterion("server_name =", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameNotEqualTo(String value) {
            addCriterion("server_name <>", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameGreaterThan(String value) {
            addCriterion("server_name >", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameGreaterThanOrEqualTo(String value) {
            addCriterion("server_name >=", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameLessThan(String value) {
            addCriterion("server_name <", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameLessThanOrEqualTo(String value) {
            addCriterion("server_name <=", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameLike(String value) {
            addCriterion("server_name like", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameNotLike(String value) {
            addCriterion("server_name not like", value, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameIn(List<String> values) {
            addCriterion("server_name in", values, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameNotIn(List<String> values) {
            addCriterion("server_name not in", values, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameBetween(String value1, String value2) {
            addCriterion("server_name between", value1, value2, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerNameNotBetween(String value1, String value2) {
            addCriterion("server_name not between", value1, value2, "serverName");
            return (Criteria) this;
        }

        public Criteria andServerCodeIsNull() {
            addCriterion("server_code is null");
            return (Criteria) this;
        }

        public Criteria andServerCodeIsNotNull() {
            addCriterion("server_code is not null");
            return (Criteria) this;
        }

        public Criteria andServerCodeEqualTo(String value) {
            addCriterion("server_code =", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeNotEqualTo(String value) {
            addCriterion("server_code <>", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeGreaterThan(String value) {
            addCriterion("server_code >", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeGreaterThanOrEqualTo(String value) {
            addCriterion("server_code >=", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeLessThan(String value) {
            addCriterion("server_code <", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeLessThanOrEqualTo(String value) {
            addCriterion("server_code <=", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeLike(String value) {
            addCriterion("server_code like", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeNotLike(String value) {
            addCriterion("server_code not like", value, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeIn(List<String> values) {
            addCriterion("server_code in", values, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeNotIn(List<String> values) {
            addCriterion("server_code not in", values, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeBetween(String value1, String value2) {
            addCriterion("server_code between", value1, value2, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerCodeNotBetween(String value1, String value2) {
            addCriterion("server_code not between", value1, value2, "serverCode");
            return (Criteria) this;
        }

        public Criteria andServerDomainIsNull() {
            addCriterion("server_domain is null");
            return (Criteria) this;
        }

        public Criteria andServerDomainIsNotNull() {
            addCriterion("server_domain is not null");
            return (Criteria) this;
        }

        public Criteria andServerDomainEqualTo(String value) {
            addCriterion("server_domain =", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainNotEqualTo(String value) {
            addCriterion("server_domain <>", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainGreaterThan(String value) {
            addCriterion("server_domain >", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainGreaterThanOrEqualTo(String value) {
            addCriterion("server_domain >=", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainLessThan(String value) {
            addCriterion("server_domain <", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainLessThanOrEqualTo(String value) {
            addCriterion("server_domain <=", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainLike(String value) {
            addCriterion("server_domain like", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainNotLike(String value) {
            addCriterion("server_domain not like", value, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainIn(List<String> values) {
            addCriterion("server_domain in", values, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainNotIn(List<String> values) {
            addCriterion("server_domain not in", values, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainBetween(String value1, String value2) {
            addCriterion("server_domain between", value1, value2, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerDomainNotBetween(String value1, String value2) {
            addCriterion("server_domain not between", value1, value2, "serverDomain");
            return (Criteria) this;
        }

        public Criteria andServerPortIsNull() {
            addCriterion("server_port is null");
            return (Criteria) this;
        }

        public Criteria andServerPortIsNotNull() {
            addCriterion("server_port is not null");
            return (Criteria) this;
        }

        public Criteria andServerPortEqualTo(Integer value) {
            addCriterion("server_port =", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortNotEqualTo(Integer value) {
            addCriterion("server_port <>", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortGreaterThan(Integer value) {
            addCriterion("server_port >", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortGreaterThanOrEqualTo(Integer value) {
            addCriterion("server_port >=", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortLessThan(Integer value) {
            addCriterion("server_port <", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortLessThanOrEqualTo(Integer value) {
            addCriterion("server_port <=", value, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortIn(List<Integer> values) {
            addCriterion("server_port in", values, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortNotIn(List<Integer> values) {
            addCriterion("server_port not in", values, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortBetween(Integer value1, Integer value2) {
            addCriterion("server_port between", value1, value2, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerPortNotBetween(Integer value1, Integer value2) {
            addCriterion("server_port not between", value1, value2, "serverPort");
            return (Criteria) this;
        }

        public Criteria andServerSuffixIsNull() {
            addCriterion("server_suffix is null");
            return (Criteria) this;
        }

        public Criteria andServerSuffixIsNotNull() {
            addCriterion("server_suffix is not null");
            return (Criteria) this;
        }

        public Criteria andServerSuffixEqualTo(String value) {
            addCriterion("server_suffix =", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixNotEqualTo(String value) {
            addCriterion("server_suffix <>", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixGreaterThan(String value) {
            addCriterion("server_suffix >", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixGreaterThanOrEqualTo(String value) {
            addCriterion("server_suffix >=", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixLessThan(String value) {
            addCriterion("server_suffix <", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixLessThanOrEqualTo(String value) {
            addCriterion("server_suffix <=", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixLike(String value) {
            addCriterion("server_suffix like", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixNotLike(String value) {
            addCriterion("server_suffix not like", value, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixIn(List<String> values) {
            addCriterion("server_suffix in", values, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixNotIn(List<String> values) {
            addCriterion("server_suffix not in", values, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixBetween(String value1, String value2) {
            addCriterion("server_suffix between", value1, value2, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerSuffixNotBetween(String value1, String value2) {
            addCriterion("server_suffix not between", value1, value2, "serverSuffix");
            return (Criteria) this;
        }

        public Criteria andServerUrlIsNull() {
            addCriterion("server_url is null");
            return (Criteria) this;
        }

        public Criteria andServerUrlIsNotNull() {
            addCriterion("server_url is not null");
            return (Criteria) this;
        }

        public Criteria andServerUrlEqualTo(String value) {
            addCriterion("server_url =", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlNotEqualTo(String value) {
            addCriterion("server_url <>", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlGreaterThan(String value) {
            addCriterion("server_url >", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlGreaterThanOrEqualTo(String value) {
            addCriterion("server_url >=", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlLessThan(String value) {
            addCriterion("server_url <", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlLessThanOrEqualTo(String value) {
            addCriterion("server_url <=", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlLike(String value) {
            addCriterion("server_url like", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlNotLike(String value) {
            addCriterion("server_url not like", value, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlIn(List<String> values) {
            addCriterion("server_url in", values, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlNotIn(List<String> values) {
            addCriterion("server_url not in", values, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlBetween(String value1, String value2) {
            addCriterion("server_url between", value1, value2, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerUrlNotBetween(String value1, String value2) {
            addCriterion("server_url not between", value1, value2, "serverUrl");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckIsNull() {
            addCriterion("server_auto_check is null");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckIsNotNull() {
            addCriterion("server_auto_check is not null");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckEqualTo(Boolean value) {
            addCriterion("server_auto_check =", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckNotEqualTo(Boolean value) {
            addCriterion("server_auto_check <>", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckGreaterThan(Boolean value) {
            addCriterion("server_auto_check >", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckGreaterThanOrEqualTo(Boolean value) {
            addCriterion("server_auto_check >=", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckLessThan(Boolean value) {
            addCriterion("server_auto_check <", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckLessThanOrEqualTo(Boolean value) {
            addCriterion("server_auto_check <=", value, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckIn(List<Boolean> values) {
            addCriterion("server_auto_check in", values, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckNotIn(List<Boolean> values) {
            addCriterion("server_auto_check not in", values, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckBetween(Boolean value1, Boolean value2) {
            addCriterion("server_auto_check between", value1, value2, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerAutoCheckNotBetween(Boolean value1, Boolean value2) {
            addCriterion("server_auto_check not between", value1, value2, "serverAutoCheck");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlIsNull() {
            addCriterion("server_check_url is null");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlIsNotNull() {
            addCriterion("server_check_url is not null");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlEqualTo(String value) {
            addCriterion("server_check_url =", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlNotEqualTo(String value) {
            addCriterion("server_check_url <>", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlGreaterThan(String value) {
            addCriterion("server_check_url >", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlGreaterThanOrEqualTo(String value) {
            addCriterion("server_check_url >=", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlLessThan(String value) {
            addCriterion("server_check_url <", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlLessThanOrEqualTo(String value) {
            addCriterion("server_check_url <=", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlLike(String value) {
            addCriterion("server_check_url like", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlNotLike(String value) {
            addCriterion("server_check_url not like", value, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlIn(List<String> values) {
            addCriterion("server_check_url in", values, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlNotIn(List<String> values) {
            addCriterion("server_check_url not in", values, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlBetween(String value1, String value2) {
            addCriterion("server_check_url between", value1, value2, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerCheckUrlNotBetween(String value1, String value2) {
            addCriterion("server_check_url not between", value1, value2, "serverCheckUrl");
            return (Criteria) this;
        }

        public Criteria andServerLiveIsNull() {
            addCriterion("server_live is null");
            return (Criteria) this;
        }

        public Criteria andServerLiveIsNotNull() {
            addCriterion("server_live is not null");
            return (Criteria) this;
        }

        public Criteria andServerLiveEqualTo(Boolean value) {
            addCriterion("server_live =", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveNotEqualTo(Boolean value) {
            addCriterion("server_live <>", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveGreaterThan(Boolean value) {
            addCriterion("server_live >", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveGreaterThanOrEqualTo(Boolean value) {
            addCriterion("server_live >=", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveLessThan(Boolean value) {
            addCriterion("server_live <", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveLessThanOrEqualTo(Boolean value) {
            addCriterion("server_live <=", value, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveIn(List<Boolean> values) {
            addCriterion("server_live in", values, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveNotIn(List<Boolean> values) {
            addCriterion("server_live not in", values, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveBetween(Boolean value1, Boolean value2) {
            addCriterion("server_live between", value1, value2, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerLiveNotBetween(Boolean value1, Boolean value2) {
            addCriterion("server_live not between", value1, value2, "serverLive");
            return (Criteria) this;
        }

        public Criteria andServerGroupIsNull() {
            addCriterion("server_group is null");
            return (Criteria) this;
        }

        public Criteria andServerGroupIsNotNull() {
            addCriterion("server_group is not null");
            return (Criteria) this;
        }

        public Criteria andServerGroupEqualTo(Long value) {
            addCriterion("server_group =", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupNotEqualTo(Long value) {
            addCriterion("server_group <>", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupGreaterThan(Long value) {
            addCriterion("server_group >", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupGreaterThanOrEqualTo(Long value) {
            addCriterion("server_group >=", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupLessThan(Long value) {
            addCriterion("server_group <", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupLessThanOrEqualTo(Long value) {
            addCriterion("server_group <=", value, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupIn(List<Long> values) {
            addCriterion("server_group in", values, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupNotIn(List<Long> values) {
            addCriterion("server_group not in", values, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupBetween(Long value1, Long value2) {
            addCriterion("server_group between", value1, value2, "serverGroup");
            return (Criteria) this;
        }

        public Criteria andServerGroupNotBetween(Long value1, Long value2) {
            addCriterion("server_group not between", value1, value2, "serverGroup");
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

        public Criteria andCheckResultTypeIsNull() {
            addCriterion("check_result_type is null");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeIsNotNull() {
            addCriterion("check_result_type is not null");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeEqualTo(String value) {
            addCriterion("check_result_type =", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeNotEqualTo(String value) {
            addCriterion("check_result_type <>", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeGreaterThan(String value) {
            addCriterion("check_result_type >", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeGreaterThanOrEqualTo(String value) {
            addCriterion("check_result_type >=", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeLessThan(String value) {
            addCriterion("check_result_type <", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeLessThanOrEqualTo(String value) {
            addCriterion("check_result_type <=", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeLike(String value) {
            addCriterion("check_result_type like", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeNotLike(String value) {
            addCriterion("check_result_type not like", value, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeIn(List<String> values) {
            addCriterion("check_result_type in", values, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeNotIn(List<String> values) {
            addCriterion("check_result_type not in", values, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeBetween(String value1, String value2) {
            addCriterion("check_result_type between", value1, value2, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckResultTypeNotBetween(String value1, String value2) {
            addCriterion("check_result_type not between", value1, value2, "checkResultType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeIsNull() {
            addCriterion("check_type is null");
            return (Criteria) this;
        }

        public Criteria andCheckTypeIsNotNull() {
            addCriterion("check_type is not null");
            return (Criteria) this;
        }

        public Criteria andCheckTypeEqualTo(String value) {
            addCriterion("check_type =", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeNotEqualTo(String value) {
            addCriterion("check_type <>", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeGreaterThan(String value) {
            addCriterion("check_type >", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeGreaterThanOrEqualTo(String value) {
            addCriterion("check_type >=", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeLessThan(String value) {
            addCriterion("check_type <", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeLessThanOrEqualTo(String value) {
            addCriterion("check_type <=", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeLike(String value) {
            addCriterion("check_type like", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeNotLike(String value) {
            addCriterion("check_type not like", value, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeIn(List<String> values) {
            addCriterion("check_type in", values, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeNotIn(List<String> values) {
            addCriterion("check_type not in", values, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeBetween(String value1, String value2) {
            addCriterion("check_type between", value1, value2, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckTypeNotBetween(String value1, String value2) {
            addCriterion("check_type not between", value1, value2, "checkType");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyIsNull() {
            addCriterion("check_json_key is null");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyIsNotNull() {
            addCriterion("check_json_key is not null");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyEqualTo(String value) {
            addCriterion("check_json_key =", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyNotEqualTo(String value) {
            addCriterion("check_json_key <>", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyGreaterThan(String value) {
            addCriterion("check_json_key >", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyGreaterThanOrEqualTo(String value) {
            addCriterion("check_json_key >=", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyLessThan(String value) {
            addCriterion("check_json_key <", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyLessThanOrEqualTo(String value) {
            addCriterion("check_json_key <=", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyLike(String value) {
            addCriterion("check_json_key like", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyNotLike(String value) {
            addCriterion("check_json_key not like", value, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyIn(List<String> values) {
            addCriterion("check_json_key in", values, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyNotIn(List<String> values) {
            addCriterion("check_json_key not in", values, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyBetween(String value1, String value2) {
            addCriterion("check_json_key between", value1, value2, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckJsonKeyNotBetween(String value1, String value2) {
            addCriterion("check_json_key not between", value1, value2, "checkJsonKey");
            return (Criteria) this;
        }

        public Criteria andCheckValueIsNull() {
            addCriterion("check_value is null");
            return (Criteria) this;
        }

        public Criteria andCheckValueIsNotNull() {
            addCriterion("check_value is not null");
            return (Criteria) this;
        }

        public Criteria andCheckValueEqualTo(String value) {
            addCriterion("check_value =", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueNotEqualTo(String value) {
            addCriterion("check_value <>", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueGreaterThan(String value) {
            addCriterion("check_value >", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueGreaterThanOrEqualTo(String value) {
            addCriterion("check_value >=", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueLessThan(String value) {
            addCriterion("check_value <", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueLessThanOrEqualTo(String value) {
            addCriterion("check_value <=", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueLike(String value) {
            addCriterion("check_value like", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueNotLike(String value) {
            addCriterion("check_value not like", value, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueIn(List<String> values) {
            addCriterion("check_value in", values, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueNotIn(List<String> values) {
            addCriterion("check_value not in", values, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueBetween(String value1, String value2) {
            addCriterion("check_value between", value1, value2, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckValueNotBetween(String value1, String value2) {
            addCriterion("check_value not between", value1, value2, "checkValue");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteIsNull() {
            addCriterion("check_cycle_minute is null");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteIsNotNull() {
            addCriterion("check_cycle_minute is not null");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteEqualTo(Integer value) {
            addCriterion("check_cycle_minute =", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteNotEqualTo(Integer value) {
            addCriterion("check_cycle_minute <>", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteGreaterThan(Integer value) {
            addCriterion("check_cycle_minute >", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteGreaterThanOrEqualTo(Integer value) {
            addCriterion("check_cycle_minute >=", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteLessThan(Integer value) {
            addCriterion("check_cycle_minute <", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteLessThanOrEqualTo(Integer value) {
            addCriterion("check_cycle_minute <=", value, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteIn(List<Integer> values) {
            addCriterion("check_cycle_minute in", values, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteNotIn(List<Integer> values) {
            addCriterion("check_cycle_minute not in", values, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteBetween(Integer value1, Integer value2) {
            addCriterion("check_cycle_minute between", value1, value2, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andCheckCycleMinuteNotBetween(Integer value1, Integer value2) {
            addCriterion("check_cycle_minute not between", value1, value2, "checkCycleMinute");
            return (Criteria) this;
        }

        public Criteria andServerWeightIsNull() {
            addCriterion("server_weight is null");
            return (Criteria) this;
        }

        public Criteria andServerWeightIsNotNull() {
            addCriterion("server_weight is not null");
            return (Criteria) this;
        }

        public Criteria andServerWeightEqualTo(Integer value) {
            addCriterion("server_weight =", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightNotEqualTo(Integer value) {
            addCriterion("server_weight <>", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightGreaterThan(Integer value) {
            addCriterion("server_weight >", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightGreaterThanOrEqualTo(Integer value) {
            addCriterion("server_weight >=", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightLessThan(Integer value) {
            addCriterion("server_weight <", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightLessThanOrEqualTo(Integer value) {
            addCriterion("server_weight <=", value, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightIn(List<Integer> values) {
            addCriterion("server_weight in", values, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightNotIn(List<Integer> values) {
            addCriterion("server_weight not in", values, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightBetween(Integer value1, Integer value2) {
            addCriterion("server_weight between", value1, value2, "serverWeight");
            return (Criteria) this;
        }

        public Criteria andServerWeightNotBetween(Integer value1, Integer value2) {
            addCriterion("server_weight not between", value1, value2, "serverWeight");
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