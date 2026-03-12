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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get data from JSP form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // 2. Wrap data in User object
        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        u.setRole(role);

        // 3. Save to database using DAO
        UserDAO dao = new UserDAO(DBConnect.getConn());
        boolean f = dao.addUser(u);

        HttpSession session = request.getSession();

        if(f) {
            session.setAttribute("succMsg", "Registration Successful!");
            response.sendRedirect("register.jsp");
        } else {
            session.setAttribute("errorMsg", "Something went wrong on the server.");
            response.sendRedirect("register.jsp");
        }
    }
}
