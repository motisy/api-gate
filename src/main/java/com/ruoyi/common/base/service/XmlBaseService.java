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
public interface XmlBaseService<T extends BaseEntity, PK, Example> {

	/**
	 * 按条件查询数量
	 * <p>Title: countByExample</p>  
	 * <p>Description: </p>  
	 * @param example
	 * @return
	 */
	long countByExample(Example example);

	/**
	 * 按条件删除
	 * <p>Title: deleteByExample</p>  
	 * <p>Description: </p>  
	 * @param example
	 * @return
	 */
    int deleteByExample(Example example);

    /**
     * 通过主键删除
     * <p>Title: deleteByPrimaryKey</p>  
     * <p>Description: </p>  
     * @param id
     * @return
     */
    int deleteByPrimaryKey(PK id);

    /**
     * 全属性添加，包括null
     * <p>Title: insert</p>  
     * <p>Description: </p>  
     * @param record
     * @return
     */
    int insert(T record);

    /**
     * 添加，null属性不会被插入，会按默认值插入
     * <p>Title: insertSelective</p>  
     * <p>Description: </p>  
     * @param record
     * @return
     */
    int insertSelective(T record);

    /**
     * 按条件查询列表
     * <p>Title: selectByExample</p>  
     * <p>Description: </p>  
     * @param example
     * @return
     */
    List<T> selectByExample(Example example);

    /**
     * 按主键获取
     * <p>Title: selectByPrimaryKey</p>  
     * <p>Description: </p>  
     * @param id
     * @return
     */
    T selectByPrimaryKey(PK id);

    /**
     * 按条件修改，null属性不会被修改，只修改有值的属性
     * <p>Title: updateByExampleSelective</p>  
     * <p>Description: </p>  
     * @param record
     * @param example
     * @return
     */
    int updateByExampleSelective(@Param("record") T record, @Param("example") Example example);

    /**
     * 按条件全属性修改，null属性也会被更新到数据库
     * <p>Title: updateByExample</p>  
     * <p>Description: </p>  
     * @param record
     * @param example
     * @return
     */
    int updateByExample(@Param("record") T record, @Param("example") Example example);

    /**
     * 通过主键修改，null属性不会被修改
     * <p>Title: updateByPrimaryKeySelective</p>  
     * <p>Description: </p>  
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(T record);

    /**
     * 通过主键修改，null属性也会被更新到数据库
     * <p>Title: updateByPrimaryKey</p>  
     * <p>Description: </p>  
     * @param record
     * @return
     */
    int updateByPrimaryKey(T record);
}
