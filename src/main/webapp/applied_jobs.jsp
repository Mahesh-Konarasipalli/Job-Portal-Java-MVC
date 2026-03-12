<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO, com.jobportal.db.DBConnect, com.jobportal.entity.Job, com.jobportal.entity.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>
    
    <%-- Security Check for Job Seeker --%>
    <%
    User userObj = (User)session.getAttribute("userobj");
    if(userObj == null || !"seeker".equals(userObj.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5">
        <div class="card shadow border-0">
            <div class="card-body p-4">
                <div class="text-center text-primary mb-4">
                    <i class="fas fa-clipboard-list fa-3x mb-2"></i>
                    <h4 class="fw-bold">My Job Applications</h4>
                </div>

                <table class="table table-hover mt-4">
                    <thead class="table-primary">
                        <tr>
                            <th>Job Title</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            JobDAO dao = new JobDAO(DBConnect.getConn());
                            List<Job> list = dao.getAppliedJobs(userObj.getId());
                            
                            if(list.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="5" class="text-center text-muted p-4">
                                    You haven't applied to any jobs yet. Time to start searching!
                                </td>
                            </tr>
                        <%
                            } else {
                                for(Job j : list) {
                        %>
                        <tr>
                            <td class="fw-bold"><%= j.getTitle() %></td>
                            <td><%= j.getCategory() %></td>
                            <td><i class="fas fa-map-marker-alt text-danger"></i> <%= j.getLocation() %></td>
                            <td>
                                <% if("Active".equals(j.getStatus())) { %>
                                    <span class="badge bg-success">Hiring</span>
                                <% } else { %>
                                    <span class="badge bg-secondary">Closed</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="one_view.jsp?id=<%= j.getId() %>" class="btn btn-sm btn-outline-primary">View Post</a>
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