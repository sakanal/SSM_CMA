package com.sakanal.cma.service;

import com.sakanal.cma.pojo.Major;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MajorServiceTest extends TestCase {
    @Autowired
    private MajorService majorService;

    @Test
    public void testGetAllMajors(){
        List<Major> allMajors = majorService.getAllMajors();
        allMajors.forEach(System.out::println);
    }
    @Test
    public void testGetMajorByPrimaryKey(){
        Major major = majorService.getMajorByPrimaryKey("20");
        System.out.println(major);
    }
    @Test
    public void testGetMajorByName(){
        List<Major> list = majorService.getMajorByName("软件工程");
        list.forEach(System.out::println);
    }
    @Test
    public void testGetMajorByNameLike(){
        List<Major> list = majorService.getMajorByNameLike("学");
        list.forEach(System.out::println);
    }
    @Test
    public void testGetMajorByCollegeId(){
        List<Major> list = majorService.getMajorByCollegeId("20");
        list.forEach(System.out::println);
    }

}