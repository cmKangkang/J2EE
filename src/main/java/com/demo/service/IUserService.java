package com.demo.service;

import com.demo.pojo.Course;
import com.demo.pojo.User;

import java.util.List;

public interface IUserService{

    void test();

    List<Integer> findAll();

    User findUserById(Integer userID);

    boolean loginService(Integer userID,String userPWD);

    boolean loginService(User user);

    boolean changePWD(Integer id, String opwd, String npwd);

    void changeInfo(User user);

    Course getLiveSrc(Integer cID);

    void userRegister(Integer userID, String userPWD);
}
