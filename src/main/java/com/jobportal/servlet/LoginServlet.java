package com.jobportal.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.jobportal.db.DBConnect;
import com.jobportal.dao.UserDAO;
import com.jobportal.entity.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO(DBConnect.getConn());
        User user = dao.login(email, password);

        HttpSession session = request.getSession();

        if (user != null) {
            // Save user object in session
            session.setAttribute("userobj", user);
            
            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_home.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            session.setAttribute("errorMsg", "Invalid Email or Password");
            response.sendRedirect("login.jsp");
        }
    }
}
