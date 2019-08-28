package com.ruoyi.common.base.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import com.ruoyi.common.base.mapper.XmlMapper;
import com.ruoyi.common.base.service.XmlBaseService;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.security.ShiroUtils;
import com.ruoyi.framework.web.domain.BaseEntity;

/**
 * xml方式
* <p>Title: XmlBaseServiceImpl</p>  
* <p>Description: </p>  
* @author chenyang  
* @date 2018年11月29日
 */
public abstract class XmlBaseServiceImpl<T extends BaseEntity,PK,Mapper extends XmlMapper<T>, Example> implements XmlBaseService<T,PK,Example> {
	
	@Autowired
    protected Mapper mapper;
	
	public long countByExample(Example example) {
		return mapper.countByExample(example);
	}

	public int deleteByExample(Example example) {
		return mapper.deleteByExample(example);
	}

	public int deleteByPrimaryKey(PK id) {
		return mapper.deleteByPrimaryKey(id);
	}

	public int insert(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setCreateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setCreateTime(DateUtils.getNowDate());
		return mapper.insert(record);
	}

	public int insertSelective(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setCreateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setCreateTime(DateUtils.getNowDate());
		return mapper.insertSelective(record);
	}

	public List<T> selectByExample(Example example){
		return mapper.selectByExample(example);
	}

	public T selectByPrimaryKey(PK id) {
		return mapper.selectByPrimaryKey(id);
	}

	public int updateByExampleSelective(@Param("record") T record, @Param("example") Example example) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByExampleSelective(record, example);
	}

	public int updateByExample(@Param("record") T record, @Param("example") Example example){
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByExample(record, example);
	}

	public int updateByPrimaryKeySelective(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByPrimaryKey(record);
	}
}
