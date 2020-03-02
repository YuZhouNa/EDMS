package com.dyz.filter;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("拦截器已响应。。。");
        // 如果是登陆页面则放行
        System.out.println("uri: " + request.getRequestURI());
        if (request.getRequestURI().contains("Login")) {
            return true;
        }
        if (request.getRequestURI().contains("register")) {
            return true;
        }

        // 如果用户已登陆也放行
        HttpSession session = request.getSession();
        if(session.getAttribute("USER_SESSION") != null) {
            return true;
        }

        response.setHeader("Content-Type", "text/html;charset=UTF-8");
        response.getWriter().write( " <script> alert(\"请登录后重试..!\") </script> ");
        response.getWriter().write( " <script> window.parent.location.href= \"/welcomeLogin.jsp \"; </script> ");

        return false;

    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
