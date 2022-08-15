package com.sakanal.cma.service;

import com.sakanal.cma.pojo.College;
import com.sakanal.cma.pojo.Major;

import java.util.List;

public interface CollegeService {
    /**
     * 获取所有学院信息
     * @return
     */
    public List<College> getAllColleges();

    /**
     * 根据学院主键ID查询对应的学院信息（学院ID，学院名称，该学院下的所有专业）
     * @param id
     * @return
     */
    public College getCollegePrimaryKey(String id);

    /**
     * 根据学院名称准确查询对应的学院信息（学院ID，学院名称，该学院下的所有专业）
     * @param name
     * @return
     */
    public List<College> getCollegeByName(String name);

    /**
     * 根据学院名称准确查询对应的学院信息（学院ID，学院名称，该学院下的所有专业）
     * @param name
     * @return
     */
    public List<College> getCollegeByNameLike(String name);

    /**
     * 根据专业id获取对应的学院信息
     * @param MajorId
     * @return
     */
    public College getCollegeByMajorId(Integer MajorId);
}
