package com.demo.service;
import com.demo.pojo.Course;

import java.util.List;

public interface IStudentService {
    List<Course> getAllCourse(Integer id);

    Course getCourseById(Integer cID);

    Course getCourseByName(Integer cName);

    List<Course> getCourseByTeaName(Integer ctName);

    void addCourse(Integer uID,Integer cID);

    void deleteCourse(Integer uID,Integer cID);

    List<Course> searchCourses(String keyword);
}
