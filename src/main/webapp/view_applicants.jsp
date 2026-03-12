<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO, com.jobportal.db.DBConnect, com.jobportal.entity.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Applicants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>
    
    <%-- Security Check for Employer --%>
    <%
    User employerObj = (User)session.getAttribute("userobj");
    if(employerObj == null || !"employer".equals(employerObj.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5 mb-5">
        <div class="card shadow border-0">
            <div class="card-body p-4">
                <div class="text-center text-primary mb-4">
                    <i class="fas fa-users fa-3x mb-2"></i>
                    <h4 class="fw-bold">Candidates Who Applied</h4>
                </div>

                <table class="table table-hover mt-4">
                    <thead class="table-primary">
                        <tr>
                            <th>Applicant Name</th>
                            <th>Email Address</th>
                            <th>Applied For (Job Title)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            JobDAO dao = new JobDAO(DBConnect.getConn());
                            List<User> list = dao.getApplicantsForEmployer(employerObj.getId());
                            
                            if(list.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="4" class="text-center text-muted p-4">
                                    No applications yet. Hang tight!
                                </td>
                            </tr>
                        <%
                            } else {
                                for(User u : list) {
                        %>
                        <tr>
                            <td class="fw-bold"><i class="fas fa-user-circle text-secondary me-2"></i> <%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><span class="badge bg-info text-dark"><%= u.getJobTitle() %></span></td>
                            <td>
                                <%-- Pro Tip: The mailto: link automatically opens their default email client! --%>
                                <a href="mailto:<%= u.getEmail() %>?subject=Regarding your application for <%= u.getJobTitle() %>" class="btn btn-sm btn-success">
                                    <i class="fas fa-envelope"></i> Contact
                                </a>
                            </td>
                        </tr>
                        <% 
                                }
                            } 
                        %>
                    </tbody>
                </table>
                <div class="text-center mt-4">
                    <a href="home.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>