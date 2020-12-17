package com.demo.dao;

import com.demo.pojo.Course;
import com.demo.pojo.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户持久层接口
 * @author RKK
 * @Company cmkk
 */
@Repository
public interface IUserDao {
    /**
     * 查询所有操作
     * @return  所有用户列表
     * */
    @Select("select userID from user")
    List<Integer> findAll();

    /**
     *
     * @param
     */
    @Insert("insert into user(userID,userPWD,userName,userInfo) " +
            "values(#{userID},#{userPWD},#{userName},#{userInfo})")
    void addUser(@Param("userID") Integer userID,@Param("userPWD")String userPWD,
                 @Param("userName")String userName,@Param("userInfo")String userInfo);

    /**
     *
     * @param user
     */
    @Update("update user set userName=#{user.userName}, userInfo=#{user.userInfo} " +
            "where userID=#{user.userID}")
    void updateUserInfo(@Param("user") User user);

    /**
     * 修改密码
     * @param user
     */
    @Update("update user set userPWD=#{user.userPWD} where userID=#{user.userID}")
    void updateUserPwd(@Param("user") User user);

    /**
     * 删除用户
     * @param userID
     */
    @Delete("delete from user where user.userID=#{userID}")
    void deleteUser(@Param("userID") Integer userID);

    /**
     * 根据id查询
     * @return 返回account对象
     */
    @Select("select * from user where userID = #{userID}")
    User findById(@Param("userID")Integer userID);

    @Select("select * from course where cID = #{cID}")
    Course findCourse(@Param("cID") Integer cID);
}
