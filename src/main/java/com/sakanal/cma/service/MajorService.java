package com.sakanal.cma.service;

import com.sakanal.cma.pojo.Major;

import java.util.List;

public interface MajorService {
    /**
     * 获取所有专业信息
     * @return
     */
    public List<Major> getAllMajors();

    /**
     * 根据专业数据表的主键ID查询对应的专业信息（专业ID，专业名，学院ID，学院名）
     * @param id
     * @return
     */
    public Major getMajorByPrimaryKey(String id);

    /**
     * 根据专业名称准确查询对应的专业信息（专业ID，专业名，学院ID，学院名）
     * @param name
     * @return
     */
    public List<Major> getMajorByName(String name);

    /**
     * 根据专业名称模糊查询对应的专业信息（专业ID，专业名，学院ID，学院名）
     * @param name
     * @return
     */
    public List<Major> getMajorByNameLike(String name);

    /**
     * 根据学院ID查询该学院下的所有专业信息 （专业ID，专业名，学院ID，学院名）
     * @param id
     * @return
     */
    public List<Major> getMajorByCollegeId(String id);
}
