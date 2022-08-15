package com.sakanal.cma.controller;

import com.sakanal.cma.pojo.College;
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
@RequestMapping("/college")
public class CollegeController {
    @Autowired
    private CollegeService collegeService;
    @Autowired
    private MajorService majorService;

    /**
     * 获取所有学院信息
     * @return List<College> 学院信息列表
     */
    @GetMapping("/getColleges")
    @ResponseBody
    public List<College> getAllCollegesWithJson(){
        List<College> allColleges = collegeService.getAllColleges();
//        ArrayList<String> colleges = new ArrayList<>();
//        for (int i=0;i<allColleges.size();i++){
//            String collegeName = allColleges.get(i).getCollegeName();
//            colleges.add(collegeName);
//        }
        return allColleges;
    }

    @GetMapping("/getCollegeId")
    @ResponseBody
    public College getCollegeIdByMajorWithJson(@RequestParam("majorId")Integer majorId){
        if (majorId!=null) {
//             collegeId= collegeService.getCollegeIdByMajorId(majorId);]
            return collegeService.getCollegeByMajorId(majorId);
        }
        return null;
    }
}
