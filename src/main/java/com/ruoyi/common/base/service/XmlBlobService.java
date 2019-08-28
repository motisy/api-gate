package com.ruoyi.common.base.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ruoyi.framework.web.domain.BaseEntity;

/**
 * generator生成的xml方式service
* <p>Title: XmlBaseService</p>  
* <p>Description: </p>  
* @author chenyang
* @date 2018年11月29日
 */
public interface XmlBlobService<T extends BaseEntity, PK, Example> {

	int countByExample(Example example);

    int deleteByExample(Example example);

    int deleteByPrimaryKey(PK projectId);

    int insert(T record);

    int insertSelective(T record);

    List<T> selectByExampleWithBLOBs(Example example);

    List<T> selectByExample(Example example);

    T selectByPrimaryKey(PK projectId);

    int updateByExampleSelective(@Param("record") T record, @Param("example") Example example);

    int updateByExampleWithBLOBs(@Param("record") T record, @Param("example") Example example);

    int updateByExample(@Param("record") T record, @Param("example") Example example);

    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKeyWithBLOBs(T record);

    int updateByPrimaryKey(T record);
}
