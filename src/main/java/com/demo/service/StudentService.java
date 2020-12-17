package com.demo.service;

import com.demo.dao.IStudentDao;
import com.demo.pojo.Course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("studentService")
public class StudentService implements IStudentService {
    @Autowired
    private IStudentDao studentDao=null;

    /**
     * 获取学生所选全部课程
     * @param id
     * @return
     */
    @Override
    public List<Course> getAllCourse(Integer id) {
        List<Course> courses=studentDao.getAllCourse(id);
        for (Course c:courses
             ) {
            System.out.println(c);
        }
        return courses;
    }

    @Override
    public Course getCourseById(Integer cID) {
        return null;
    }

    @Override
    public Course getCourseByName(Integer cName) {
        return null;
    }

    @Override
    public List<Course> getCourseByTeaName(Integer ctName) {
        return null;
    }

    @Override
    public void addCourse(Integer uID,Integer cID) {
        studentDao.engageCourse(uID,cID);
    }

    @Override
    public void deleteCourse(Integer uID,Integer cID) {
//        System.out.println("service param got.");
        studentDao.quitCourse(uID,cID);
    }

    public List<Course> searchCourses(String keyword){
        return studentDao.getCourseByTeaName(keyword);
    }
}
