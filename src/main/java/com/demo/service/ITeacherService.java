package com.demo.service;
import com.demo.pojo.Course;
import com.demo.pojo.User;

import java.util.List;

public interface ITeacherService {
    List<Course> getCourseList(Integer ctID);

    List<User> getCourseStuList(Integer cID);

    void addCourse(Course course);

    void deleteCourse(Integer cID);

}
