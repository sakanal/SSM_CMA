package com.sakanal.cma.service.impl;

import com.sakanal.cma.dao.TeacherMapper;
import com.sakanal.cma.pojo.Teacher;
import com.sakanal.cma.pojo.TeacherExample;
import com.sakanal.cma.service.TeacherService;
import javafx.scene.transform.TransformChangedEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public Teacher login(String id, String password) {
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                TeacherExample teacherExample = new TeacherExample();
                teacherExample.createCriteria().andTchIdEqualTo(Integer.valueOf(id)).andTchPasswordEqualTo(password);
                List<Teacher> teachers = teacherMapper.selectByExample(teacherExample);
                if (teachers!=null && teachers.size()==1){
                    return teachers.get(0);
                }
            }
        }
        return null;
    }

    @Override
    public boolean checkTeacherId(String id) {
        if(id!=null && !id.equals("")){
            TeacherExample teacherExample = new TeacherExample();
            teacherExample.createCriteria().andTchIdEqualTo(Integer.valueOf(id));
            int i = teacherMapper.countByExample(teacherExample);
            return i == 0;
        }
        return false;
    }

    @Override
    public boolean checkTeacherPassword(String id, String password) {
        if (id!=null && !id.equals("")){
            Teacher teacher = teacherMapper.selectByPrimaryKey(Integer.valueOf(id));
            System.out.println("teacher.getTchPassword() = " + teacher.getTchPassword());
            System.out.println("password = " + password);
            if (teacher!=null && teacher.getTchPassword()!=null && !teacher.getTchPassword().equals("")){
                return teacher.getTchPassword().equals(password);
            }
        }
        return false;
    }

    @Override
    public List<Teacher> getAllTeachers() {
        return teacherMapper.selectByExample(null);
    }

    @Override
    public List<Teacher> getTeacherByLike(Teacher teacher) {
        TeacherExample teacherExample = new TeacherExample();
        TeacherExample.Criteria criteria = teacherExample.createCriteria();
        if (teacher.getTchId()!=null){
            criteria.andTchIdEqualTo(teacher.getTchId());
        }else {
            if (teacher.getTchName()!=null && !"".equals(teacher.getTchName())){
                criteria.andTchNameLike("%"+teacher.getTchName()+"%");
            }
            if (teacher.getTchCollege()!=null && !"".equals(teacher.getTchCollege())){
                criteria.andTchCollegeLike(teacher.getTchCollege());
            }
        }
        return teacherMapper.selectByExample(teacherExample);
    }

    @Override
    public boolean insertTeacher(Teacher teacher) {
        if (teacher!=null){
            if (teacher.getTchId()!=null){
                if (teacher.getTchName()!=null &&  !"".equals(teacher.getTchName())){
                    if (teacher.getTchPassword()!=null && !teacher.getTchPassword().equals("")){
                        int i = teacherMapper.insertSelective(teacher);
                        return i != 0;
                    }
                }
            }
        }
        return false;
    }

    @Override
    public boolean updateTeacherPassword(String id, String password) {
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                Teacher teacher = new Teacher();
                teacher.setTchId(Integer.valueOf(id));
                teacher.setTchPassword(password);
                int i = teacherMapper.updateByPrimaryKeySelective(teacher);
                return i!=0;
            }
        }
        return false;
    }
}
