package com.demo.controller;

import com.demo.pojo.Course;
import com.demo.pojo.User;
import com.demo.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private IUserService userService=null;

    @RequestMapping("/test")
    public String test(HttpServletResponse res, Model m) throws Exception{
        userService.test();
        m.addAttribute("userID",2018);
        m.addAttribute("userPWD",10086);
        System.out.println("usc测试成功.");
        return "home";
    }

    @RequestMapping(value="/json",produces = {"application/json"},consumes = "application/json")
    @ResponseBody
    public User testJson(@RequestBody User user){
        System.out.println("param got");
        System.out.println(user);
//        response.setContentType("application/json");
        return user;
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String loginControl(@RequestBody User user, HttpServletRequest request,HttpServletResponse response) throws Exception{
        System.out.println("Controller: got param.");
        if(userService.loginService(user))//登陆成功
        {
            System.out.println("login successfully.");
            return "home";
        }
        else//登录失败
        {
            System.out.println("login failed.");
            response.sendRedirect(request.getContextPath() + "/pages/login2.html");
            return null;
        }
    }

    @RequestMapping(value = "/login2",method = RequestMethod.POST)
    public void loginControl2(@RequestParam(value="userID",required = true) Integer userID, @RequestParam(value="userPWD",required = true) String userPWD,HttpServletRequest request, HttpServletResponse response) throws Exception{
        System.out.println("Controller: got param.");
        if(userService.loginService(userID,userPWD))//登陆成功
        {
            System.out.println("login successfully.");
            request.setAttribute("userID",userID);
            request.setAttribute("userPWD",userPWD);

//            return "home";
        }
        else//登录失败
        {
            System.out.println("login failed.");
            response.sendRedirect(request.getContextPath() + "/pages/login2.html");
//            return null;
        }
    }


    @RequestMapping(value = "/login3",method = RequestMethod.POST)
    public ModelAndView loginControl3(@RequestParam(value="userID",required = true) Integer userID, @RequestParam(value="userPWD",required = true) String userPWD, HttpSession session) throws Exception{
        System.out.println("Controller: got param.");
        ModelAndView mv=new ModelAndView();
        if(userService.loginService(userID,userPWD))//登陆成功
        {
            System.out.println("login successfully.");
            session.setAttribute("LOGIN",true);
            session.setAttribute("userID",userID);
            //modelandview传递的值不能被前台用el表达式取到，session可以
            mv.setViewName("redirect:/pages/home.jsp");
        }
        else//登录失败
        {
            System.out.println("login failed.");

            mv.setViewName("redirect:/pages/login.jsp");
        }
        return mv;
    }

    @RequestMapping("/register")
    public ModelAndView userRegister(@RequestParam(value="userID",required = true) Integer userID, @RequestParam(value="userPWD",required = true) String userPWD,HttpSession session){
        ModelAndView mv=new ModelAndView();
        List<Integer> list=userService.findAll();
        if(list.indexOf(userID)>=0) {//已被注册
            //跳转到注册页面，登陆页面得重写
            mv.setViewName("redirect:/pages/register.jsp");
        }
        else{//未被注册
            userService.userRegister(userID, userPWD);
            mv.setViewName("redirect:/pages/login.jsp");
        }
        return mv;
    }

    /**
     * 修改密码
     * @param id
     * @param opwd
     * @param npwd
     * @return
     */
    @RequestMapping("/chpwd")
    public @ResponseBody String changePWD(@RequestParam(value="id") Integer id, @RequestParam(value="opwd") String opwd,@RequestParam(value="npwd") String npwd){
        boolean ret=userService.changePWD(id,opwd,npwd);
        if(ret){
            System.out.println("pwd change success");
            return "success";

        }
        else return "false";
    }

    @RequestMapping("/chinfo")
    public void changeInfo(@RequestBody User user){
        System.out.println("param got.");
        userService.changeInfo(user);
        System.out.println("action down");
    }

    @RequestMapping("/guinfo")
    public @ResponseBody User getUserInfo(@RequestParam("userID")Integer userID){
        System.out.println(userID);
        return userService.findUserById(userID);
    }

    @RequestMapping("/getsrc")
    public @ResponseBody Course getLiveSrc(@RequestParam("cID")Integer cID){
        return userService.getLiveSrc(cID);
    }

    @RequestMapping("/enterc")
    public ModelAndView enterCourse(@RequestParam("uid")Integer uID,
                                    @RequestParam("uname") String uName,
                                    @RequestParam("cid") Integer cID,
                                    @RequestParam("cname") String cName,
                                    @RequestParam("ctid") Integer ctID,
                                    @RequestParam("ctname") String ctName,
                                    HttpSession session){
        ModelAndView mv=new ModelAndView();
        session.setAttribute("uid",uID);
        session.setAttribute("uname",uName);
        session.setAttribute("cid",cID);
        session.setAttribute("cname",cName);
        session.setAttribute("ctid",ctID);
        session.setAttribute("ctname",ctName);
        //modelandview传递的值不能被前台用el表达式取到，session可以
        mv.setViewName("redirect:/pages/live.jsp");
        System.out.println("进入课程，跳转中");
        return mv;
    }
}
