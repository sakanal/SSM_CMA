package com.sakanal.cma.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sakanal.cma.pojo.Major;
import com.sakanal.cma.pojo.Student;
import com.sakanal.cma.service.MajorService;
import com.sakanal.cma.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentService studentService;
    @Autowired
    private MajorService majorService;

    /**
     * 前往学生列表页面
     * @return
     */
    @RequestMapping( "/studentList/{identity}")
    public ModelAndView toStudentList(@PathVariable("identity")String identity, HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        String sessionIdentity = (String) session.getAttribute("identity");
        if (!identity.equals(sessionIdentity)){
            modelAndView.addObject("errorMessage","请正常使用本系统");
            session.invalidate();
            modelAndView.setViewName("forward:/system/goLogin");
        }
        if (identity.equals("2") || identity.equals("3")){
            modelAndView.setViewName("/student/studentList");
            return modelAndView;
        }else{
            modelAndView.addObject("errorMessage","用户权限不足，请重新登录");
            session.invalidate();
            modelAndView.setViewName("forward:/system/goLogin");
            return modelAndView;
        }
    }

    /**
     * 获取所有学生信息，并实现分页
     * @param pageNo        请求页号
     * @return  PageInfo   将所有学生信息封装成PageInfo对象，该对象包含分页信息
     */
    @RequestMapping("/getStudents")
    @ResponseBody
    public PageInfo getAllStudentWithJson(@RequestParam(value="pageNo",defaultValue = "1")Integer pageNo){
        PageHelper.startPage(pageNo,8);
        List<Student> allStudent = studentService.getAllStudent();
        return new PageInfo(allStudent,7);
    }


    @GetMapping("/student/{id}")
    public ModelAndView toViewStudent(@PathVariable("id")String id,
                                  HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        String identity = (String) session.getAttribute("identity");
        if (id!=null && !"".equals(id)){
            Student student = studentService.getStudentById(id);
            if (student!=null){
                student.setStuPassword(null);
                modelAndView.addObject("studentInfo",student);
                modelAndView.setViewName("/student/studentInfo");
                return modelAndView;
            }
            modelAndView.addObject("errorMessage","无法查询该学生信息！");
            modelAndView.setViewName("forward:/student/studentList/"+identity);
            return modelAndView;
        }
        modelAndView.addObject("errorMessage","无法提交学生ID，请再试一次！");
        modelAndView.setViewName("forward:/student/studentList/"+identity);
        return modelAndView;
    }

    /**
     * 根据条件搜索学生信息
     * @param pageNo        分页页码
     * @param stuId         学生id
     * @param stuName       学生姓名
     * @param stuClass      学生班级
     * @param stuCollege    学生所在学院
     * @param stuMajor      学生专业
     * @return  PageInfo    将搜索到的学生信息封装成PageInfo对象，该对象包含分页信息
     */
    @RequestMapping("/searchStudents")
    @ResponseBody
    public PageInfo searchStudentsWithJson(@RequestParam(value="pageNo",defaultValue = "1")Integer pageNo,
                                           @RequestParam(value = "stuId")String stuId,
                                           @RequestParam(value = "stuName")String stuName,
                                           @RequestParam(value = "stuClass")String stuClass,
                                           @RequestParam(value = "stuCollege")String stuCollege,
                                           @RequestParam(value = "stuMajor")String stuMajor){
        Student student = new Student();
        if (stuId!=null && !stuId.equals("") && !stuId.equals("0")){
            student.setStuId(Long.valueOf(stuId));
        }
        student.setStuName(stuName);
        student.setStuClass(stuClass);
        student.setStuCollege(stuCollege);
        student.setStuMajor(stuMajor);
        PageHelper.startPage(pageNo,8);
        List<Student> students = studentService.getStudentByLike(student);
        PageInfo pageInfo=new PageInfo(students,7);
        return pageInfo;
    }


    /**
     * 根据前端传递的学生Id，判断该Id是否和数据库中的数据重复
     * @param stuId 学生Id
     * @return  数据不重复返回true，数据重复返回false
     *
     * 实际内容迁移到SystemController中的checkId()方法
     */
//    @GetMapping("/checkStudentId")
//    @ResponseBody
//    public boolean checkStudentIdWithJson(@RequestParam("stuId") String stuId){
//        String regx="(^[0-9]{6,16}$)";
//        if (!stuId.matches(regx)){
//            return false;
//        }
//        return studentService.checkStudentId(stuId);
//    }


    /**
     * 添加学生信息
     * @param student
     * @return  添加成功返回true，添加失败返回false
     */
    @PostMapping("/insertStudent")
    @ResponseBody
    public boolean insertStudentWithJson(@Valid Student student, BindingResult bindingResult){
        if (bindingResult.hasErrors()){
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
            }
            return false;
        }else {
            if (Objects.equals(student.getStuClass(), ""))
                student.setStuClass(null);
            if (Objects.equals(student.getStuCollege(), ""))
                student.setStuCollege(null);
            if (Objects.equals(student.getStuMajor(), ""))
                student.setStuMajor(null);
            boolean result=false;
            int i = studentService.insertStudent(student);
            if (i!=0)
                result=true;
            return result;
        }
    }

    /**
     * 根据学生id获取学生信息
     * @param id    学生id
     * @return Student 学生信息
     */
    @GetMapping("/getStudent/{id}")
    @ResponseBody
    public Student getStudentByIdWithnJson(@PathVariable("id") String id){
        Student student=new Student();
        if (id!=null && !id.equals("")){
            student = studentService.getStudentById(id);
        }
        if (student.getStuMajor()!=null && !Objects.equals(student.getStuMajor(), "")){
            List<Major> majorByName = majorService.getMajorByName(student.getStuMajor());
            student.setStuMajor(String.valueOf(majorByName.get(0).getId()));
            student.setStuCollege(String.valueOf(majorByName.get(0).getCollegeId()));
        }
        return student;
    }
    /**
     * 根据学生id，选择性修改学生信息
     * @param id
     * @param student
     * @return
     */
    @PutMapping("/updateStudent/{id}")
    @ResponseBody
    public boolean updateStudentWithJson(@PathVariable("id")String id, Student student){
        if (id!=null && !id.equals("")){
            student.setStuId(Long.valueOf(id));
            int i = studentService.updateStudent(student);
            return i != 0;
        }
        return false;
    }

    @DeleteMapping("/deleteStudent/{id}")
    @ResponseBody
    public int deleteStudentWithJson(@PathVariable("id")String id){
        if (id!=null && !id.equals("")){
            return studentService.deleteStudentById(id);
        }
        return 0;
    }

}
