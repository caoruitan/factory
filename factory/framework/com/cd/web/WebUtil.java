package com.cd.web;

import java.io.IOException;

import javax.servlet.ServletResponse;

public class WebUtil {
	
    public static void writeTOPage(ServletResponse response, Object psJsonData) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/JSON");
        try {
            response.getWriter().print(psJsonData);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
