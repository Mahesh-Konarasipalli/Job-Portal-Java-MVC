package com.jobportal.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.jobportal.dao.UserDAO;
import com.jobportal.db.DBConnect;
import com.jobportal.entity.User;

@WebServlet("/update_profile")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Grab the old user object from session to keep their specific role intact
            HttpSession session = request.getSession();
            User sessionUser = (User) session.getAttribute("userobj");

            // Create a new User object with updated details
            User updateUser = new User();
            updateUser.setId(id);
            updateUser.setName(name);
            updateUser.setEmail(email);
            updateUser.setPassword(password);
            updateUser.setRole(sessionUser.getRole()); // Keep their original role

            UserDAO dao = new UserDAO(DBConnect.getConn());
            boolean f = dao.updateUser(updateUser);

            if (f) {
                // IMPORTANT: Overwrite the old session with the fresh, updated user
                session.setAttribute("userobj", updateUser);
                session.setAttribute("succMsg", "Profile Updated Successfully!");
                response.sendRedirect("profile.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                response.sendRedirect("profile.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}