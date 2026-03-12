package com.jobportal.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.jobportal.db.DBConnect;
import com.jobportal.dao.JobDAO;
import com.jobportal.entity.Job;
import com.jobportal.entity.User;

@WebServlet("/add_job")
public class PostJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("userobj"); 
        
        // Security check
        if(u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String location = request.getParameter("location");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String desc = request.getParameter("desc");

        Job j = new Job(title, desc, category, status, location);
        j.setUserId(u.getId()); 

        JobDAO dao = new JobDAO(DBConnect.getConn());
        boolean f = dao.addJob(j); // Call database ONLY ONCE

        if (f) {
            session.setAttribute("succMsg", "Job Posted Successfully!");
            response.sendRedirect("add_job.jsp");
        } else {
            session.setAttribute("errorMsg", "Something went wrong on server");
            response.sendRedirect("add_job.jsp");
        }
    }
}