package com.sakanal.cma.service;

import com.sakanal.cma.pojo.College;
import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class CollegeServiceTest extends TestCase {
    @Autowired
    private CollegeService collegeService;

    @Test
    public void testGetAllColleges(){
        List<College> allColleges = collegeService.getAllColleges();
        allColleges.forEach(System.out::println);
    }
    @Test
    public void testGetCollegePrimaryKey(){
        College college = collegeService.getCollegePrimaryKey("1");
        System.out.println(college);
    }
    @Test
    public void testGetCollegeByName(){
        List<College> list = collegeService.getCollegeByName("软件学院");
        list.forEach(System.out::println);
    }
    @Test
    public void testGetCollegeByNameLike(){
        List<College> list = collegeService.getCollegeByNameLike("软件");
        list.forEach(System.out::println);
    }

}