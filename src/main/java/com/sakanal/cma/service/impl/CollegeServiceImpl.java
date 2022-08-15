package com.sakanal.cma.service.impl;

import com.sakanal.cma.dao.CollegeMapper;
import com.sakanal.cma.dao.MajorMapper;
import com.sakanal.cma.pojo.College;
import com.sakanal.cma.pojo.CollegeExample;
import com.sakanal.cma.pojo.Major;
import com.sakanal.cma.pojo.MajorExample;
import com.sakanal.cma.service.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CollegeServiceImpl implements CollegeService {
    @Autowired
    private CollegeMapper collegeMapper;
    @Autowired
    private MajorMapper majorMapper;

    @Override
    public List<College> getAllColleges() {
        return collegeMapper.selectByExample(null);
    }

    @Override
    public College getCollegePrimaryKey(String id) {
        if (id!=null&&id!=""){
            return collegeMapper.selectCollegeByPrimaryKey(Integer.valueOf(id));
        }
        return null;
    }

    @Override
    public List<College> getCollegeByName(String name) {
        if (name != null&&name!="") {
            CollegeExample collegeExample = new CollegeExample();
            collegeExample.createCriteria().andCollegeNameLike(name);
            return collegeMapper.selectByExample(collegeExample);
        }
        return null;
    }

    @Override
    public List<College> getCollegeByNameLike(String name) {
        if (name != null&&name!="") {
            name="%"+name+"%";
            CollegeExample collegeExample = new CollegeExample();
            collegeExample.createCriteria().andCollegeNameLike(name);
            return collegeMapper.selectByExample(collegeExample);
        }
        return null;
    }

    @Override
    public College getCollegeByMajorId(Integer MajorId) {
        if (MajorId!=null){
            Major major = majorMapper.selectByPrimaryKey(MajorId);
            if (major!=null){
                return collegeMapper.selectCollegeByPrimaryKey(major.getCollegeId());
            }
        }
        return null;
    }
}
