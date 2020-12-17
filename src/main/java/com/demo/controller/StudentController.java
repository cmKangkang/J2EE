package com.demo.controller;

import com.demo.pojo.Course;
import com.demo.pojo.User;
import com.demo.service.IStudentService;
//import com.demo.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value="/student")
public class StudentController {
    @Autowired
    private IStudentService studentService=null;

    @RequestMapping(value="test",method = RequestMethod.GET)
    public @ResponseBody String testGetData(){
        User user=new User();
        user.setUserID(3000);
        user.setUserPWD("20089");
        System.out.println("test param got");
        return "ret";
    }

    /**
     * 学生获取课程列表,对
     * @param userID
     */
//    @ResponseBody
    @RequestMapping(value="/gcl")
    public ModelAndView getCourseList(@RequestParam(value="userID") Integer userID){
        System.out.println("param got.");
        ModelAndView mv=new ModelAndView();
        List<Course> courses=studentService.getAllCourse(userID);
        mv.addObject("data",courses);
        System.out.println("action success.");
        return mv;
    }

    /**
     * 学生获取课程列表,对
     * @param userID
     */
//    @ResponseBody
    @RequestMapping(value="/gcl2")
    public @ResponseBody List<Course> getCourseList2(@RequestParam(value="userID") Integer userID){
        System.out.println("param got.");
        List<Course> courses=studentService.getAllCourse(userID);
        System.out.println("action success.");
        return courses;
    }

    /**
     * 学生添加课程，对u_c表进行操作
     * @param uID
     * @param cID
     */
    @RequestMapping(value="/addc")
    public void addCourse(@RequestParam("uID") Integer uID,@RequestParam("cID") Integer cID){
        System.out.println("param got");
        studentService.addCourse(uID,cID);
    }

    /**
     * delete course
     * @param uID
     * @param cID
     */
    @RequestMapping(value="/delc")
    public void deleteCourse(@RequestParam("uID") Integer uID,@RequestParam("cID") Integer cID){
        System.out.println("param got.");
        System.out.println(cID);
        System.out.println(uID);
        studentService.deleteCourse(uID,cID);
        System.out.println("action done.");
    }

    @RequestMapping(value="search")
    public @ResponseBody List<Course> searchCourses(@RequestParam("keyword") String keyword){
        System.out.println("keyword got");
        return studentService.searchCourses(keyword);
    }
}
