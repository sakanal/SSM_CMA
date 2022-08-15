package com.sakanal.cma.service.impl;

import com.sakanal.cma.dao.MajorMapper;
import com.sakanal.cma.pojo.Major;
import com.sakanal.cma.pojo.MajorExample;
import com.sakanal.cma.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MajorServiceImpl implements MajorService {
    @Autowired
    private MajorMapper majorMapper;

    @Override
    public List<Major> getAllMajors() {
        return majorMapper.selectByExample(null);
    }

    @Override
    public Major getMajorByPrimaryKey(String id) {
        return majorMapper.selectByPrimaryKey(Integer.valueOf(id));
    }

    @Override
    public List<Major> getMajorByName(String name) {
        if (name != null && name!="") {
            MajorExample majorExample = new MajorExample();
            majorExample.createCriteria().andMajorNameEqualTo(name);
            return majorMapper.selectByExample(majorExample);
        }else {
            return null;
        }
    }
    @Override
    public List<Major> getMajorByNameLike(String name) {
        if (name!=null&&name!=""){
            name="%"+name+"%";
            MajorExample majorExample = new MajorExample();
            majorExample.createCriteria().andMajorNameLike(name);
            List<Major> majors = majorMapper.selectByExample(majorExample);
            return majors;
        }
        return null;
    }

    @Override
    public List<Major> getMajorByCollegeId(String id) {
//        if (id!=null&&id!=""){
//            MajorExample majorExample = new MajorExample();
//            majorExample.createCriteria().andCollegeIdEqualTo(Integer.valueOf(id));
//            return majorMapper.selectByExample(majorExample);
//        }
//        return null;
        if (id!=null&&id!="")
            return majorMapper.selectMajorByCollegeId(Integer.valueOf(id));
        return null;
    }
}
