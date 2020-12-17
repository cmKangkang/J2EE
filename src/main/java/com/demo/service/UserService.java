package com.demo.service;

import com.demo.dao.IUserDao;
import com.demo.pojo.Course;
import com.demo.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserService implements IUserService{
    @Autowired
    private IUserDao userDao=null;
    /**
     * 测试用
     */
    public void test() {
        System.out.println("us测试成功.");
    }

    /**
     * 查找全部
     * @return
     */
    public List<Integer> findAll() {
        return userDao.findAll();
    }


    public User findUserById(Integer userID){
        User user=userDao.findById(userID);
        if(user!=null) user.setUserPWD("");
        return user;
    }


    /**
     * 用户登录
     * @param userc
     * @return
     */
    public boolean loginService(User userc) {
        System.out.println("Service: param got.");
        User user=userDao.findById(userc.getUserID());
        System.out.println("service: "+user);

        if(user.getUserPWD().equals(userc.getUserPWD()))
            return true;
        else return false;
    }

    /**
     * 用户登录
     * @param  id
     * @param pwd
     * @return
     */
    public boolean loginService(Integer id,String pwd) {
        System.out.println("Service: param got.");
        User user=userDao.findById(id);
        System.out.println("service: "+user);
        if(pwd.equals(user.getUserPWD()))
            return true;
        else return false;
    }

    /**
     * 修改密码
     * @param id
     * @param opwd
     * @param npwd
     * @return
     */
    public boolean changePWD(Integer id, String opwd, String npwd){
        User user=userDao.findById(id);
        if(user.getUserPWD().equals(opwd)){
            user.setUserPWD(npwd);
            userDao.updateUserPwd(user);
            return true;
        }
        else
            return false;
    }

    public void changeInfo(User user){
        userDao.updateUserInfo(user);
    }

    public Course getLiveSrc(Integer cID){
        Course course =new Course();
        Course c=userDao.findCourse(cID);
        course.setcID(c.getcID());
        course.setLiveSrc(c.getLiveSrc());
        return course;
    }

    @Override
    public void userRegister(Integer userID, String userPWD) {
        userDao.addUser(userID,userPWD,"anonymity","这个人很懒，啥都没写-_-");
    }
}
