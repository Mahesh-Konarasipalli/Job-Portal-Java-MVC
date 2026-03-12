<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO" %>
<%@ page import="com.jobportal.db.DBConnect" %>
<%@ page import="com.jobportal.entity.Job" %>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Job Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-9">
                
                <%
                    // FIX: Renamed variable to 'u' to avoid clashing with the navbar's 'user' variable
                    User u = (User) session.getAttribute("userobj");
                    int id = Integer.parseInt(request.getParameter("id"));
                    JobDAO dao = new JobDAO(DBConnect.getConn());
                    Job j = dao.getJobById(id);
                    
                    if(j != null) {
                %>

                <div class="card shadow border-0">
                    <div class="card-body p-5">
                        <% String succ = (String)session.getAttribute("succMsg");
                           String err = (String)session.getAttribute("errorMsg");
                           if(succ != null) { %>
                           <div class="alert alert-success text-center fw-bold"><i class="fas fa-check-circle"></i> <%= succ %></div>
                        <% session.removeAttribute("succMsg"); } 
                           if(err != null) { %>
                           <div class="alert alert-warning text-center fw-bold"><i class="fas fa-exclamation-triangle"></i> <%= err %></div>
                        <% session.removeAttribute("errorMsg"); } %>
                        <div class="d-flex justify-content-between">
                            <h2 class="text-primary fw-bold"><%= j.getTitle() %></h2>
                            <a href="view_jobs.jsp" class="btn btn-outline-secondary btn-sm align-self-start">
                                <i class="fas fa-arrow-left"></i> Back to Jobs
                            </a>
                        </div>
                        
                        <div class="mt-3">
                            <span class="badge bg-info text-dark p-2 me-2">
                                <i class="fas fa-tag"></i> <%= j.getCategory() %>
                            </span>
                            <span class="badge bg-success p-2">
                                <i class="fas fa-map-marker-alt"></i> <%= j.getLocation() %>
                            </span>
                        </div>

                        <hr class="my-4">

                        <h5 class="fw-bold">Job Description:</h5>
                        <p style="white-space: pre-wrap; line-height: 1.8;"><%= j.getDescription() %></p>

                        <div class="bg-light p-3 rounded mt-4">
                            <p class="mb-0 text-muted">
                                <strong>Posted on:</strong> <%= j.getPdate().length() > 10 ? j.getPdate().substring(0, 10) : j.getPdate() %> <br>
                                <strong>Status:</strong> <%= j.getStatus() %>
                            </p>
                        </div>

                        <div class="text-center mt-5">
                            <%-- FIX: Updated the if-statements to use 'u' instead of 'user' --%>
                            <% if(u != null && "seeker".equals(u.getRole())) { %>
                                <a href="apply_job?id=<%= j.getId() %>" class="btn btn-primary btn-lg px-5">
                                    <i class="fas fa-paper-plane"></i> Apply for this Job
                                </a>
                            <% } else if (u == null) { %>
                                <div class="alert alert-warning">
                                    Please <a href="login.jsp">Login</a> to apply for this job.
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
                
                <% } else { %>
                    <div class="alert alert-danger text-center">Job not found!</div>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>