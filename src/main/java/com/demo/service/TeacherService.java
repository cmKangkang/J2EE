package com.demo.service;

import com.demo.dao.ITeacherDao;
import com.demo.pojo.Course;
import com.demo.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("teacherService")
public class TeacherService implements ITeacherService{
    @Autowired
    private ITeacherDao teacherDao=null;

    public List<Course> getCourseList(Integer ctID) {
        return teacherDao.getCourseList(ctID);
    }

    public List<User> getCourseStuList(Integer cID) {
        List<User> stus=teacherDao.getCourseStuList(cID);
        return stus;
    }


    public void addCourse(Course course) {
        teacherDao.addCourse(course);
    }

    public void deleteCourse(Integer cID) {
        teacherDao.deleteCourse(cID);
    }
}
