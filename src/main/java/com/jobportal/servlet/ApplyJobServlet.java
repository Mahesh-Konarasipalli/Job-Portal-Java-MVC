package com.jobportal.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.jobportal.dao.JobDAO;
import com.jobportal.db.DBConnect;
import com.jobportal.entity.User;

@WebServlet("/apply_job")
public class ApplyJobServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Get the Job ID from the URL (?id=5)
            int jobId = Integer.parseInt(request.getParameter("id"));
            
            // 2. Get the logged-in User ID from the session
            HttpSession session = request.getSession();
            User u = (User) session.getAttribute("userobj");
            
            // Security: If not logged in, send to login page
            if (u == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = u.getId();
            JobDAO dao = new JobDAO(DBConnect.getConn());

            // 3. Check if they already applied
            boolean alreadyApplied = dao.checkIfApplied(userId, jobId);

            if (alreadyApplied) {
                session.setAttribute("errorMsg", "You have already applied for this job!");
                response.sendRedirect("one_view.jsp?id=" + jobId);
            } else {
                // 4. Save the application
                boolean f = dao.applyForJob(userId, jobId);
                if (f) {
                    session.setAttribute("succMsg", "Application submitted successfully!");
                    response.sendRedirect("one_view.jsp?id=" + jobId);
                } else {
                    session.setAttribute("errorMsg", "Something went wrong. Please try again.");
                    response.sendRedirect("one_view.jsp?id=" + jobId);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}