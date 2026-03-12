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
import com.jobportal.entity.Job;
import com.jobportal.entity.User;

@WebServlet("/edit_job")
public class UpdateJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Get data from the edit form
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String location = request.getParameter("location");
            String category = request.getParameter("category");
            String status = request.getParameter("status");
            String desc = request.getParameter("desc");

            // 2. Create Job object and set the updated values
            Job j = new Job();
            j.setId(id);
            j.setTitle(title);
            j.setDescription(desc);
            j.setCategory(category);
            j.setStatus(status);
            j.setLocation(location);

            // 3. Update the database
            JobDAO dao = new JobDAO(DBConnect.getConn());
            boolean f = dao.updateJob(j);

            HttpSession session = request.getSession();
            
            // 4. Redirect back to manage jobs page
            if (f) {
                session.setAttribute("succMsg", "Job Updated Successfully!");
                response.sendRedirect("manage_jobs.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                response.sendRedirect("manage_jobs.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
