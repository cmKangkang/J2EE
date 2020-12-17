package com.demo.dao;

import com.demo.pojo.Course;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 处理选课、课表相关
 */
@Repository
public interface IStudentDao {
    /**
     * 根据名称选择课程
     * @param name
     * @return
     */
    @Select("select * from course where cName=#{cName}")
    Course getCourseByName(@Param("cName") String name);

    /**
     * 根据id选择课程
     *
     */
    @Select("select * from course where course.cID=#{cID}")
    Course getCourseById(@Param("cID") Integer cID);


    /**
     * 根据教师选择课程
     *
     */
    @Select("select * from course where course.ctName=#{ctName}")
    List<Course> getCourseByTeaName(@Param("ctName")String ctName);

    /**
     * 选择学生所选课程
     * @param uID
     * @return
     */
    @Select("select course.cID,course.cName,course.ctID,course.ctName,course.cInfo \n" +
            "from course,u_c where u_c.uID=#{uID} and u_c.cID=course.cID")
    List<Course> getAllCourse(@Param("uID") Integer uID);

    /**
     * 加入课程
     * @param cID
     * @param uID
     */
    @Insert("insert into u_c(cID,uID) values (#{cID},#{uID})")
    void engageCourse(@Param("uID") Integer uID,@Param("cID") Integer cID);

    /**
     * 退出课程
     */
    @Delete("delete from u_c where cID=#{cID} and uID=#{uID}")
    void quitCourse(@Param("uID") Integer uID,@Param("cID") Integer cID);

}
