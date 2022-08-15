package com.sakanal.cma.service;

import com.sakanal.cma.dao.TeacherMapper;
import com.sakanal.cma.pojo.Teacher;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TeacherServiceTest {
    @Autowired
    private TeacherMapper teacherMapper;

    @Test
    public void getAllTeachers() {
        List<Teacher> teachers = teacherMapper.selectByExample(null);
        teachers.forEach(System.out::println);
    }
}