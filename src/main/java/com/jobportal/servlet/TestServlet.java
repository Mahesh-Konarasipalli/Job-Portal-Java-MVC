package com.jobportal.servlet;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet; // Changed to jakarta
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/hello")
public class TestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().print("<h1>Job Portal is Running on Tomcat 10!</h1>");
    }
}
