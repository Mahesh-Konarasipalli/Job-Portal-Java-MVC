package com.jobportal.servlet;

import java.io.IOException;

import com.jobportal.dao.JobDAO;
import com.jobportal.db.DBConnect;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete")
public class DeleteJobServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        JobDAO dao = new JobDAO(DBConnect.getConn());
        boolean f = dao.deleteJob(id);
        
        HttpSession session = request.getSession();
        if(f) {
            session.setAttribute("succMsg", "Job Deleted Successfully");
        } else {
            session.setAttribute("errorMsg", "Something went wrong");
        }
        response.sendRedirect("manage_jobs.jsp");
    }
}
