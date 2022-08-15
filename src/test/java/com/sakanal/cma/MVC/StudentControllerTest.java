package com.sakanal.cma.MVC;

import com.github.pagehelper.PageInfo;
import com.sakanal.cma.pojo.Student;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC-servlet.xml"})
public class StudentControllerTest {
    MockMvc mockMvc;
    @Autowired
    WebApplicationContext webApplicationContext;
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testGetAllStudent() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/student/studentList").param("pageNo", "2")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码 = " + pageInfo.getPageNum());
        System.out.println("总页码 = " + pageInfo.getPages());
        System.out.println("总记录数 = " + pageInfo.getTotal());
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        System.out.println("在页面需要连续显示的页码");
        for (int page:navigatepageNums){
            System.out.println(page);
        }
        List<Student> list = pageInfo.getList();
        list.forEach(System.out::println);
    }
}
