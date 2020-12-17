package com.demo.dao;

import com.demo.pojo.Course;
import com.demo.pojo.User;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ITeacherDao {
    /**
     * 查询全部课程
     * @return
     */
    @Select("select * from course")
    List<Course> findAll();

    /**
     * 添加课程
     * @param course
     */
    @Insert("insert into course(cID,cName,cInfo,ctID,ctName,liveSrc) " +
            "values (#{course.cID},#{course.cName},#{course.cInfo},#{course.ctID},#{course.ctName}),#{course.liveSrc}")
    void addCourse(@Param("course") Course course);

    /**
     * 删除课程
     * @param id
     */
    @Delete("delete from course where course.cID=#{id}")
    void deleteCourse(@Param("id") Integer id);

    /**
     * 更新课程
     * @param course
     */
    @Update("update course set cName=#{course.cName} " +
            "where cID=#{course.cID}")
    void updateCourse(@Param("course") Course course);


    /**
     * 选择课程中的学生
     * @param cID
     * @return
     */
    @Select("select * from user where user.userID in (select uID from u_c where u_c.cID = #{cID})")
    List<User> getCourseStuList(@Param("cID") Integer cID);


    /**
     * 查询所有课程
     * param ctID 老师ID
     */
    @Select("select * from course where course.ctID=#{ctID}")
    List<Course> getCourseList(@Param("ctID") Integer ctID);


}
