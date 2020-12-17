package com.demo.controller.interceptor;

import com.demo.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserInterceptor implements HandlerInterceptor {
    /**
     * 请求到达controller前执行的方法
     * 拦截登录
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("--preInterceptor--");
        String uri = request.getRequestURI();
        if (uri.indexOf("/user/login")>=0||uri.indexOf("/user/register")>=0) {
            return true;
        }
        else {
            HttpSession session =request.getSession();
            System.out.println(session);
            Integer id=(Integer) session.getAttribute("userID");
            System.out.println(id);
            if (id != null) {
                return true;
            }else {//拦截
                response.sendRedirect("/pages/login.jsp");
                return false;
            }
        }
    }

    /**
     * controller执行后，跳转页面或其他操作前执行的操作
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    /**
     * 跳转页面执行之后执行的方法
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}
