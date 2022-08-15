package com.sakanal.cma.controller;

import com.sakanal.cma.pojo.Major;
import com.sakanal.cma.service.CollegeService;
import com.sakanal.cma.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/major")
public class MajorController {
    @Autowired
    private CollegeService collegeService;
    @Autowired
    private MajorService majorService;

    /**
     * 获取所有专业信息
     * @return List<Major>  专业信息列表
     */
    @GetMapping("/getMajors")
    @ResponseBody
    public List<Major> getAllMajors(){
        List<Major> allMajors = majorService.getAllMajors();
        return allMajors;
    }


    /**
     * 根据学院Id获取该学院下的所有专业信息
     * @param collegeId 学院Id
     * @return  List<Major> 专业信息列表
     */
    @GetMapping("/getMajorsByCollegeId")
    @ResponseBody
    public List<Major> getMajorsByCollegeIdWithJson(@RequestParam(value = "collegeId")String collegeId){
        if (collegeId!=null && collegeId!="") {
            return majorService.getMajorByCollegeId(collegeId);
        }
        return null;
    }


}
