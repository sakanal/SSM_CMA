package com.sakanal.cma.service.impl;

import com.sakanal.cma.dao.StudentMapper;
import com.sakanal.cma.pojo.Student;
import com.sakanal.cma.pojo.StudentExample;
import com.sakanal.cma.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student login(String id,String password) {
        StudentExample studentExample = new StudentExample();
        if(id!=null && password!=null){
            studentExample.createCriteria().andStuIdEqualTo(Long.valueOf(id)).andStuPasswordEqualTo(password);
            List<Student> students = studentMapper.selectByExample(studentExample);
            if (students != null&&students.size()==1) {
                students.get(0).setStuPassword(null);
                return students.get(0);
            }
        }
        return null;
    }

    @Override
//    @Cacheable(value = "AllStudent",key = "AllStudent")
    public List<Student> getAllStudent() {
        return  studentMapper.selectByExample(null);
    }

    @Override
//    @Cacheable(value = "student",key = "#id")
    public Student getStudentById(String id) {
        Student student=new Student();
        if (id != null) {
            student = studentMapper.selectByPrimaryKey(Long.valueOf(id));
        }
        return student;
    }


    @Override
    public List<Student> getStudentByLike(Student student) {
        StudentExample studentExample = new StudentExample();
        StudentExample.Criteria criteria = studentExample.createCriteria();
        if (student.getStuId()!=null){
            criteria.andStuIdEqualTo(student.getStuId());
        }else{
            if (student.getStuName()!=null && !Objects.equals(student.getStuName(), "")){
                criteria.andStuNameLike("%"+student.getStuName()+"%");
            }
            if(student.getStuClass()!=null && !Objects.equals(student.getStuClass(), "")){
                criteria.andStuClassEqualTo(student.getStuClass());
            }
            if (student.getStuCollege()!=null && !Objects.equals(student.getStuCollege(), "")){
                criteria.andStuCollegeLike(student.getStuCollege());
            }
            if (student.getStuMajor()!=null && !Objects.equals(student.getStuMajor(), "")){
                criteria.andStuMajorLike(student.getStuMajor());
            }
        }

        return studentMapper.selectByExample(studentExample);
    }

    @Override
    public boolean checkStudentId(String id) {
        if (id!=null&& !id.equals("")){
            StudentExample studentExample = new StudentExample();
            studentExample.createCriteria().andStuIdEqualTo(Long.valueOf(id));
            int i = studentMapper.countByExample(studentExample);
            return i == 0;
        }
        return false;
    }

    @Override
    public boolean checkStudentPassword(String id, String password) {
        if (id!=null && !id.equals("")) {
            Student student = studentMapper.selectByPrimaryKey(Long.valueOf(id));
            if (student!=null && student.getStuPassword()!=null && !student.getStuPassword().equals("")){
                return student.getStuPassword().equals(password);
            }
        }
        return false;
    }

    @Override
    public int updateStudent(Student student) {
        if (student.getStuId()!=null){
            if (Objects.equals(student.getStuCollege(), ""))
                student.setStuCollege(null);
            if (Objects.equals(student.getStuMajor(), ""))
                student.setStuMajor(null);
            return studentMapper.updateByPrimaryKeySelective(student);
        }else {
            System.out.println("Student Primary Key (Id) is null");
            return 0;
        }
    }

    @Override
    public boolean updateStudentPassword(String id, String password) {
        if (id!=null && !id.equals("")){
            if (password!=null && !password.equals("")){
                Student student = new Student();
                student.setStuId(Long.valueOf(id));
                student.setStuPassword(password);
                int i = studentMapper.updateByPrimaryKeySelective(student);
                return i!=0;
            }
        }
        return false;
    }

    @Override
    public int insertStudent(Student student) {
        int i=0;
        if (student.getStuId()!=null) {
            if (student.getStuName()!=null && !Objects.equals(student.getStuName(), "")){
                if (student.getStuPassword()!=null && !Objects.equals(student.getStuPassword(), "")){
                    i = studentMapper.insertSelective(student);
                }
            }
        }
        return i;
    }

    @Override
    public int deleteStudentById(String id) {
        if (id!=null && !id.equals("")){
            return studentMapper.deleteByPrimaryKey(Long.valueOf(id));
        }
        return 0;
    }

    @Override
    public int deleteStudentByExample(Student student) {
        int flag=0;
        if (student!=null){
            StudentExample studentExample = new StudentExample();
            StudentExample.Criteria criteria = studentExample.createCriteria();
            if (student.getStuCollege()!=null){
                criteria.andStuCollegeEqualTo(student.getStuCollege());
                flag++;
            }
            if (student.getStuMajor()!=null){
                criteria.andStuMajorEqualTo(student.getStuMajor());
                flag++;
            }
            if (student.getStuClass()!=null){
                criteria.andStuClassEqualTo(student.getStuClass());
                flag++;
            }
            if(flag!=0){
                flag = studentMapper.deleteByExample(studentExample);
            }
            return flag;
        }else {
            return 0;
        }
    }

}
