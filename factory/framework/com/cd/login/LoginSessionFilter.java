package com.cd.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginSessionFilter implements Filter {

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);
        LoginUser user = (LoginUser) session.getAttribute(LoginSessionKey.LOGIN_SESSION_KEY);
        String uri = req.getServletPath();
        if (uri.equals("/login/login.jsp") || uri.equals("//login/login.jsp") || uri.equals("/login/doLogin.action")) {
            chain.doFilter(req, res);
        } else if ((user != null)) {
            chain.doFilter(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/login/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {

    }

}
