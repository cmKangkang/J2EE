package com.demo.test;

import com.demo.dao.ITeacherDao;
import com.demo.dao.IStudentDao;
import com.demo.dao.IUserDao;
import com.demo.pojo.Course;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.InputStream;
import java.util.List;

public class MybatisTest {

//    @Test
//    public void test1() throws Exception{
//        InputStream in= Resources.getResourceAsStream("SqlMapConfig.xml");
//        SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(in);
//        SqlSession session =factory.openSession();
//        IUserDao dao=session.getMapper(IUserDao.class);
//        User user=dao.findById(2018);
//        System.out.println(user);
//        session.close();
//        in.close();
//    }

    InputStream inputStream = null;
    SqlSession sqlSession = null;
    private  IUserDao userDao;
    private ITeacherDao courseDao;
    private IStudentDao ucDao;
    SqlSessionFactory sqlSessionFactory;

    @Before
    public void init() throws Exception{
        //1.读取配置文件，生成字节输入流
        inputStream = Resources.getResourceAsStream("SqlConfig.xml");
        //2.获取SqlSessionFactory
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //3.SqlSession对象
        sqlSession = sqlSessionFactory.openSession();

        //4.获取dao的代理对象
        userDao = (IUserDao) sqlSession.getMapper(IUserDao.class);
        courseDao=(ITeacherDao) sqlSession.getMapper(ITeacherDao.class);
        ucDao=(IStudentDao) sqlSession.getMapper(IStudentDao.class);
    }

    @After
    public void destroy() throws Exception{
        //6. 提交事务
        sqlSession.commit();

        //7.释放资源
        sqlSession.close();
        inputStream.close();
    }

    @Test
    public void testFindById(){
//        User user=userDao.findById(2018);
//        System.out.println(user);


    }

    @Test
    public void testFindAll(){
        List<Course> courses=courseDao.findAll();
        for (Course c:courses) {
            System.out.println(c);
        }
    }

    @Test
    public void testFindByName(){
//        Course c=courseDao.findByName("demo");
//        System.out.println(c);
    }

//    @Test
//    public void testGetCourses(){
//        User user=new User();
//        user.setUserID(2018);
//        List<Course> courses=userDao.getCoursesAsTeacher(user);
//        for (Course c:courses
//             ) {
//            System.out.println(c);
//        }
//
//    }


    @Test
    public void testGetStudents(){
        Course c=new Course();
        c.setcID(111);
//        List<User> users=courseDao.getStudents(c);
//        for (User u:users
//             ) {
//            System.out.println(u);
//        }
    }

    @Test
    public void testInsert(){
        Course course=new Course();
        course.setcID(114);
//        course.setcDate("null");
        course.setCtID(2048);
        courseDao.addCourse(course);
    }

    @Test
    public void testUpdate(){
        Course course=new Course();
        course.setcID(114);
        course.setCtID(2048);
        course.setcName("testUpdate");
        course.setCtName("test");
        courseDao.updateCourse(course);
    }

    @Test
    public void testDelete(){
        courseDao.deleteCourse(114);
    }


}
