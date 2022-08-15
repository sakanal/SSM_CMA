package com.sakanal.cma.controller;

import com.sakanal.cma.pojo.Admin;
import com.sakanal.cma.pojo.Student;
import com.sakanal.cma.pojo.Teacher;
import com.sakanal.cma.service.AdminService;
import com.sakanal.cma.service.StudentService;
import com.sakanal.cma.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/system")
public class SystemController {
    @Autowired
    private StudentService studentService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private AdminService adminService;

    @RequestMapping("/goLogin")
    public String goLogin(){return "system/login";}
    @RequestMapping("/goRegister")
    public String goRegister(){return "system/register";}
    @RequestMapping("/main")
    public String goMain(){
        return "system/main";
    }

    @PostMapping("/login")
    public ModelAndView login(String id,String password,String identity,HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        if (identity!=null && !identity.equals("")) {
            if (identity.equals("1")) {
                //学生登录
                if (!"".equals(id)  && !"".equals(password)) {
                    Student student = studentService.login(id, password);
                    if (student!=null){
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("id",student.getStuId());
                        map.put("name",student.getStuName());
                        session.setAttribute("userInfo", map);
                        session.setAttribute("identity", "1");
                        modelAndView.setViewName("redirect:/system/main");
                    }else {
                        modelAndView.addObject("errorMessage","用户名或密码不正确");
                        modelAndView.setViewName("forward:/system/goLogin");
                    }
                }else{
                    modelAndView.addObject("errorMessage","用户登录信息参数错误");
                    modelAndView.setViewName("forward:/system/goLogin");
                }
            }else if(identity.equals("2")){
                //教师登录
                if (!"".equals(id)  && !"".equals(password)) {
                    Teacher teacher = teacherService.login(id, password);
                    if (teacher!=null){
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("id",teacher.getTchId());
                        map.put("name",teacher.getTchName());
                        session.setAttribute("userInfo", map);
                        session.setAttribute("identity", "2");
                        modelAndView.setViewName("redirect:/system/main");
                    }else {
                        modelAndView.addObject("errorMessage","用户名或密码不正确");
                        modelAndView.setViewName("forward:/system/goLogin");
                    }
                }else{
                    modelAndView.addObject("errorMessage","用户登录信息参数错误");
                    modelAndView.setViewName("forward:/system/goLogin");
                }
            }else if (identity.equals("3")){
                //管理员登录
                if (!"".equals(id)  && !"".equals(password)) {
                    Admin admin = adminService.login(id, password);
                    if (admin!=null){
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("id",admin.getAdminId());
                        map.put("name",admin.getAdminName());
                        session.setAttribute("userInfo", map);
                        session.setAttribute("identity", "3");
                        modelAndView.setViewName("redirect:/system/main");
                    }else {
                        modelAndView.addObject("errorMessage","用户名或密码不正确");
                        modelAndView.setViewName("forward:/system/goLogin");
                    }
                }else{
                    modelAndView.addObject("errorMessage","用户登录信息参数错误");
                    modelAndView.setViewName("forward:/system/goLogin");
                }
            }else {
                modelAndView.addObject("errorMessage","用户身份参数错误");
                modelAndView.setViewName("forward:/system/goLogin");
            }
        }else {
            modelAndView.addObject("errorMessage","用户身份未选择");
            modelAndView.setViewName("forward:/system/goLogin");
        }
        return modelAndView;
    }
    @PostMapping("/register")
    public ModelAndView register(String id,String password,String name,String identity,HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                if (name!=null && !name.equals("")){
                    switch (identity){
                        case "1":{
                            Student student = new Student();
                            student.setStuId(Long.valueOf(id));
                            student.setStuPassword(password);
                            student.setStuName(name);
                            int i = studentService.insertStudent(student);
                            if (i==1){
                                HashMap<String, Object> map = new HashMap<>();
                                map.put("id",id);
                                map.put("name",name);
                                session.setAttribute("userInfo",map);
                                session.setAttribute("identity",identity);
//                                modelAndView.addObject("message","注册成功");
                                modelAndView.setViewName("redirect:/system/main");
                            }else {
                                modelAndView.addObject("errorMessage","注册失败，请检查注册信息是否有误");
                                modelAndView.setViewName("forward:/system/goRegister");
                            }
                            break;
                        }
                        case "2":{
                            Teacher teacher = new Teacher();
                            teacher.setTchId(Integer.valueOf(id));
                            teacher.setTchPassword(password);
                            teacher.setTchName(name);
                            if (teacherService.insertTeacher(teacher)){
                                HashMap<String, Object> map = new HashMap<>();
                                map.put("id",id);
                                map.put("name",name);
                                session.setAttribute("userInfo",map);
                                session.setAttribute("identity",identity);
//                                modelAndView.addObject("message","注册成功");
                                modelAndView.setViewName("redirect:/system/main");
                            }else {
                                modelAndView.addObject("errorMessage","注册失败，请检查注册信息是否有误");
                                modelAndView.setViewName("forward:/system/goRegister");
                            }
                            break;
                        }
                        default:{
                            modelAndView.addObject("erroeMessage","注册身份为选择，请选择所要注册的身份");
                            modelAndView.setViewName("forward:/system/goRegister");
                        }
                    }
                }else {
                    modelAndView.addObject("errorMessage","用户名为空，请重新输入");
                    modelAndView.setViewName("forward:/system/goRegister");
                }
            }else {
                modelAndView.addObject("errorMessage","密码为空，请重新输入");
                modelAndView.setViewName("forward:/system/goRegister");
            }
        }else {
            modelAndView.addObject("errorMessage","用户ID为空，请重新输入");
            modelAndView.setViewName("forward:/system/goRegister");
        }
        return modelAndView;
    }
    @RequestMapping("/logout")
    public ModelAndView logout(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("/system/login");
        session.setAttribute("userInfo",null);
        session.setAttribute("identity",null);
        modelAndView.addObject("message","退出成功");
        return modelAndView;
    }

    @PostMapping("/checkId")
    @ResponseBody
    public boolean checkIdWithJson(@RequestParam("id")String id,@RequestParam("identity")String identity){
        if(identity!=null && !identity.equals("")){
            String regx="(^[0-9]{6,16}$)";
            if (id.matches(regx)){
                if (!id.equals("")){
                    switch (identity){
                        case "1":{
                            return studentService.checkStudentId(id);
                        }
                        case "2":{
                            return teacherService.checkTeacherId(id);
                        }
                    }
                }
            }
        }
        return false;
    }
    @PostMapping("/checkPassword")
    @ResponseBody
    public boolean checkPasswordWithJson(@RequestParam("id")String id,@RequestParam("identity")String identity,@RequestParam("password")String password){
        if (id!=null && !id.equals("")) {
            if (password!=null && !password.equals("")){
                switch (identity){
                    case "1":{
                        return studentService.checkStudentPassword(id,password);
                    }
                    case "2":{
                        return teacherService.checkTeacherPassword(id,password);
                    }
                    case "3":{
                        return adminService.checkAdminPassword(id,password);
                    }
                }
            }
        }
        return false;
    }
    @PutMapping("/updatePassword")
    @ResponseBody
    public boolean updatePasswordWithJson(@RequestParam("id")String id,@RequestParam("identity")String identity,@RequestParam("password")String password){
        if (id!=null && !id.equals("")) {
            if (password!=null && !password.equals("")){
                switch (identity){
                    case "1":{
                        System.out.println("1");
                        return studentService.updateStudentPassword(id,password);
                    }
                    case "2":{
                        System.out.println("2");
                        return teacherService.updateTeacherPassword(id,password);
                    }
                    case "3":{
                        System.out.println("3");
                        return adminService.updateAdminPassword(id,password);
                    }
                }
            }
        }
        return false;
    }
}
