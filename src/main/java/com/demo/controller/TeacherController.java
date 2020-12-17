package com.demo.controller;

import com.demo.pojo.Course;
import com.demo.pojo.User;
import com.demo.service.ITeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController {
    @Autowired
    private ITeacherService teacherService=null;

    /**
     * 老师获取已开设课程，对course表进行操作
     * @param ctID 为教师id
     */
    @RequestMapping(value="/gcl")
    public @ResponseBody List<Course> getCourseList(@RequestParam("ctID") Integer ctID){
        System.out.println("param got.");
        List<Course> courses=teacherService.getCourseList(ctID);
        System.out.println("action done");
        return courses;
    }

    /**
     * 老师开设新课程，对course表进行操作
     * @param course 课程信息
     */
    @RequestMapping(value="/addc")
    public void addCourse(Course course){
        System.out.println(course);
        teacherService.addCourse(course);
    }

    /**
     * 获取课程学生列表，对u_c、user表进行操作
     * @param cID
     */
    @RequestMapping(value = "/gcsl")
    public List<User> getCourseStudentList(@RequestParam(value="cID") Integer cID){
        return teacherService.getCourseStuList(cID);
    }

    @RequestMapping(value="/delc")
    public void delCourse(@RequestParam(value="cID") Integer cID){
        System.out.println("param got.");
        teacherService.deleteCourse(cID);
        System.out.println("action done.");
    }
}
