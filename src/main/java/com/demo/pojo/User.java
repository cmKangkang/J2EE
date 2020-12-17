package com.demo.pojo;
import java.io.Serializable;

public class User implements Serializable{
    private Integer userID;
    private String userPWD;
    private String userName;
    private String userInfo;

    public User(){};

    public User(int id, String pwd, String name, String info){
        this.userID=id;
        this.userName=name;
        this.userPWD=pwd;
        this.userInfo=info;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getUserPWD() {
        return userPWD;
    }

    public void setUserPWD(String userPWD) {
        this.userPWD = userPWD;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(String userInfo) {
        this.userInfo = userInfo;
    }

    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", userPWD='" + userPWD + '\'' +
                ", userName='" + userName + '\'' +
                ", userInfo='" + userInfo + '\'' +
                '}';
    }
}
