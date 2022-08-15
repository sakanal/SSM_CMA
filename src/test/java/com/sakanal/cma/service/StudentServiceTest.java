package com.sakanal.cma.service;

import com.sakanal.cma.dao.StudentMapper;
import com.sakanal.cma.pojo.Student;
import com.sakanal.cma.pojo.StudentExample;
import com.sakanal.cma.service.impl.StudentServiceImpl;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class StudentServiceTest extends TestCase {

    @Autowired
    private StudentService studentService;

    @Test
    public void testLogin(){
        Student login = studentService.login("1001", "123456");
        System.out.println("loginStudent = " + login);
    }

    @Test
    public void testGetAllStudent(){
        List<Student> allStudent = studentService.getAllStudent();
        allStudent.forEach(System.out::println);
    }
    @Test
    public void testGetStudentById(){
        Student student = studentService.getStudentById("1001");
        System.out.println(student);
    }
    @Test
    public void testGetStudentByLike(){
        Student student = new Student();
//        student.setStuId(Long.valueOf("1"));
        student.setStuName("root1");
//        student.setStuClass("1921804");
        student.setStuCollege("0");
        student.setStuMajor("0");
        System.out.println("student.getStuCollege() = " + student.getStuCollege());
        List<Student> studentByLike = studentService.getStudentByLike(student);
        studentByLike.forEach(System.out::println);
    }
    @Test
    public void testCheckStudentId(){
        boolean result = studentService.checkStudentId("2020213106");
        System.out.println("result = " + result);
    }

    @Test
    public void testUpdateStudent(){
        Student student = new Student();
        student.setStuId(Long.valueOf("1003"));
        student.setStuGender("女");
        int i = studentService.updateStudent(student);
        System.out.println("i = " + i);
    }

    @Test
    public void testInsertStudent(){
        Student student = new Student();
        int i = studentService.insertStudent(student);
        System.out.println("i = " + i);
    }
    @Test
    public void testDeleteStudentById(){
        int i = studentService.deleteStudentById("1");
        System.out.println("i = " + i);
    }
    @Test
    public void testDeleteStudentByExample(){
        Student student = new Student();
        student.setStuId(Long.valueOf("1001"));
        student.setStuClass("1");
        student.setStuCollege("1");
        student.setStuMajor("1");
        int i = studentService.deleteStudentByExample(student);
        System.out.println("i = " + i);
    }
}