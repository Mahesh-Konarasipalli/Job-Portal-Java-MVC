<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO, com.jobportal.db.DBConnect, com.jobportal.entity.Job, com.jobportal.entity.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Jobs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>
    
    <%-- 1. Security Check (Declares userObj for the whole page) --%>
    <%
    User userObj = (User)session.getAttribute("userobj");
    if(userObj == null || !"employer".equals(userObj.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-body">
                <h4 class="text-center text-primary">Manage Your Job Postings</h4>
                
                <%-- Success/Error Messages --%>
                <% String succ = (String)session.getAttribute("succMsg");
                   String err = (String)session.getAttribute("errorMsg");
                   if(succ != null) { %>
                   <div class="alert alert-success text-center"><%= succ %></div>
                <% session.removeAttribute("succMsg"); } 
                   if(err != null) { %>
                   <div class="alert alert-danger text-center"><%= err %></div>
                <% session.removeAttribute("errorMsg"); } %>

                <table class="table table-hover mt-4">
                    <thead class="table-primary">
                        <tr>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Location</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // 2. FIX: We DO NOT declare userObj again. We just use it!
                            JobDAO dao = new JobDAO(DBConnect.getConn());
                            List<Job> list = dao.getJobsByUserId(userObj.getId());
                            
                            // Check if the list is empty to show a nice message
                            if(list.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="5" class="text-center text-muted">You haven't posted any jobs yet.</td>
                            </tr>
                        <%
                            } else {
                                for(Job j : list) {
                        %>
                        <tr>
                            <td><%= j.getTitle() %></td>
                            <td><%= j.getCategory() %></td>
                            <td>
                                <%-- Small UI trick: color code the status --%>
                                <% if("Active".equals(j.getStatus())) { %>
                                    <span class="badge bg-success">Active</span>
                                <% } else { %>
                                    <span class="badge bg-warning text-dark">Inactive</span>
                                <% } %>
                            </td>
                            <td><%= j.getLocation() %></td>
                            <td>
                                <a href="edit_job.jsp?id=<%= j.getId() %>" class="btn btn-sm btn-primary">Edit</a>
                                <a href="delete?id=<%= j.getId() %>" class="btn btn-sm btn-danger">Delete</a>
                            </td>
                        </tr>
                        <% 
                                }
                            } 
                        %>
                    </tbody>
                </table>
                <div class="text-center mt-3">
                    <a href="home.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>