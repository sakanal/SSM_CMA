package com.sakanal.cma.service;

import com.sakanal.cma.pojo.Teacher;

import java.util.List;

public interface TeacherService {
    /**
     * 教师登录
     * @param id        教师id
     * @param password  教师密码
     * @return
     */
    public Teacher login(String id,String password);

    /**
     * 判断id是否和数据库中已存在的id重复
     * @param id 教师id
     * @return
     */
    public boolean checkTeacherId(String id);

    public boolean checkTeacherPassword(String id,String password);

    /**
     * 获取所有教师信息
     * @return
     */
    public List<Teacher> getAllTeachers();
    public List<Teacher> getTeacherByLike(Teacher teacher);


    public boolean insertTeacher(Teacher teacher);
    public boolean updateTeacherPassword(String id,String password);
}
