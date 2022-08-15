package com.sakanal.cma.service;

import com.sakanal.cma.pojo.Student;

import java.util.List;

public interface StudentService {
    /**
     * 学生登录判断，学生数据库表中的某一条数据应该和username，password完全一种
     * @param id  学生Id
     * @param password  学生密码
     * @return
     */
    public Student login(String id,String password);

    /**
     * 获取所有学生信息
     * @return
     */
    public List<Student> getAllStudent();

    /**
     * 根据学生ID获取学生信息
     * @param id
     * @return
     */
    public Student getStudentById(String id);

    /**
     * 根据学生姓名/班级/学院/专业模糊查询学生信息
     * @param student
     * @return
     */
    public List<Student> getStudentByLike(Student student);

    /**
     * 检查在数据库中是否存在和参数重复的学生Id
     * @param id
     * @return
     */
    public boolean checkStudentId(String id);

    public boolean checkStudentPassword(String id,String password);


    /**
     * 根据学生Id，选择性修改更新学生信息
     * @param student
     * @return
     */
    public int updateStudent(Student student);

    public boolean updateStudentPassword(String id,String password);

    /**
     * 添加学生信息
     * @param student
     * @return  添加成功返回true，添加失败返回false
     */
    public int insertStudent(Student student);
    public int deleteStudentById(String id);
    public int deleteStudentByExample(Student student);
}
