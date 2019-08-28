package com.ruoyi.common.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.ruoyi.common.base.mapper.XmlBlobMapper;
import com.ruoyi.common.base.service.XmlBlobService;
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
public abstract class XmlBlobServiceImpl<T extends BaseEntity,PK,Mapper extends XmlBlobMapper<T>, Example> implements XmlBlobService<T,PK,Example> {

	@Autowired
    protected Mapper mapper;

	@Override
	public int countByExample(Example example) {
		return mapper.countByExample(example);
	}

	@Override
	public int deleteByExample(Example example) {
		return mapper.deleteByExample(example);
	}

	@Override
	public int deleteByPrimaryKey(PK projectId) {
		return mapper.deleteByPrimaryKey(projectId);
	}

	@Override
	public int insert(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setCreateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setCreateTime(DateUtils.getNowDate());
		return mapper.insert(record);
	}

	@Override
	public int insertSelective(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setCreateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setCreateTime(DateUtils.getNowDate());
		return mapper.insertSelective(record);
	}

	@Override
	public List<T> selectByExampleWithBLOBs(Example example) {
		return mapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public List<T> selectByExample(Example example) {
		return mapper.selectByExample(example);
	}

	@Override
	public T selectByPrimaryKey(PK projectId) {
		return mapper.selectByPrimaryKey(projectId);
	}

	@Override
	public int updateByExampleSelective(T record, Example example) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByExampleSelective(record, example);
	}

	@Override
	public int updateByExampleWithBLOBs(T record, Example example) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByExampleWithBLOBs(record, example);
	}

	@Override
	public int updateByExample(T record, Example example) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByExample(record, example);
	}

	@Override
	public int updateByPrimaryKeySelective(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(T record) {
		if(ShiroUtils.getSysUser()!=null) {
    		record.setUpdateBy(ShiroUtils.getSysUser().getUserName());
    	}
		record.setUpdateTime(DateUtils.getNowDate());
		return mapper.updateByPrimaryKey(record);
	}
}
