package com.sakanal.cma.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sakanal.cma.dao.TeacherMapper;
import com.sakanal.cma.pojo.Teacher;
import com.sakanal.cma.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    @RequestMapping("/teacherList/{identity}")
    public ModelAndView goTeacherList(@PathVariable("identity")String identity, HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        if (identity.equals("3")){
            modelAndView.setViewName("/teacher/teacherList");
            return modelAndView;
        }else {
            modelAndView.addObject("errorMessage","用户权限不足，请重新登录");
            session.setAttribute("userInfo",null);
            session.setAttribute("identity",null);
            modelAndView.setViewName("forward:/system/goLogin");
            return modelAndView;
        }
    }

    @RequestMapping("/getTeachers")
    @ResponseBody
    public PageInfo getTeachers(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo){
        PageHelper.startPage(pageNo,8);
        List<Teacher> teachers = teacherService.getAllTeachers();
        return new PageInfo(teachers, 7);
    }

    @GetMapping("/searchTeachers")
    @ResponseBody
    public PageInfo searchTeachers(@RequestParam(value="pageNo",defaultValue = "1")Integer pageNo,
                                   @RequestParam(value = "tchId",required = false) String tchId,
                                   @RequestParam(value = "tchName",required = false) String tchName,
                                   @RequestParam(value = "tchCollege",required = false) String tchCollege){
        Teacher teacher = new Teacher();
        if (tchId!=null && !"".equals(tchId)){
            teacher.setTchId(Integer.valueOf(tchId));
        }
        teacher.setTchName(tchName);
        teacher.setTchCollege(tchCollege);
        PageHelper.startPage(pageNo,8);
        List<Teacher> teacherByLike = teacherService.getTeacherByLike(teacher);
        return new PageInfo(teacherByLike, 7);
    }

    @PostMapping("/insertTeacher")
    @ResponseBody
    public boolean insertTeacher(Teacher teacher){
        System.out.println(teacher);
        if (Objects.equals(teacher.getTchCollege(), "")){
            teacher.setTchCollege(null);
        }
        return teacherService.insertTeacher(teacher);
    }
}
