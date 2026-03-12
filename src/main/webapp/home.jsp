<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Job Portal - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <%-- 1. THIS IS THE MISSING PIECE: Define the 'u' variable --%>
    <%
    User u = (User)session.getAttribute("userobj");
    if(u == null) {
        response.sendRedirect("login.jsp");
        return; // Stop execution if nobody is logged in
    }
    %>

    <%-- 2. Include Navbar --%>
    <%@include file="all_component/navbar.jsp" %>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12 text-center">
                <%-- Now Java knows what 'u' is! --%>
                <h2>Hello, <%= u.getName() %>!</h2>
                <p class="lead">Welcome to your Job Portal Dashboard.</p>
                <hr>
            </div>
        </div>

        <div class="row mt-4">
            <% if ("seeker".equals(u.getRole())) { %>
                <div class="col-md-4 offset-md-2 mb-4">
                    <div class="card text-center shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <i class="fas fa-search fa-3x text-primary mb-3"></i>
                            <h5 class="card-title fw-bold">Search Jobs</h5>
                            <p class="text-muted">Find your dream job today.</p>
                            <a href="view_jobs.jsp" class="btn btn-primary w-100 mt-2">Find Jobs</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card text-center shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <i class="fas fa-clipboard-check fa-3x text-success mb-3"></i>
                            <h5 class="card-title fw-bold">My Applications</h5>
                            <p class="text-muted">Track the jobs you have applied for.</p>
                            <a href="applied_jobs.jsp" class="btn btn-success w-100 mt-2">View History</a>
                        </div>
                    </div>
                </div>
            <% } else if ("employer".equals(u.getRole())) { %>
                <div class="col-md-4 mb-4">
                    <div class="card text-center shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <i class="fas fa-file-signature fa-3x text-success mb-3"></i>
                            <h5 class="card-title fw-bold">Post a Job</h5>
                            <p class="text-muted">Hire the best talent for your team.</p>
                            <a href="add_job.jsp" class="btn btn-success w-100 mt-2">Add New Job</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card text-center shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <i class="fas fa-tasks fa-3x text-primary mb-3"></i>
                            <h5 class="card-title fw-bold">Manage Jobs</h5>
                            <p class="text-muted">Edit or delete your active job listings.</p>
                            <a href="manage_jobs.jsp" class="btn btn-primary w-100 mt-2">View My Jobs</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card text-center shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <i class="fas fa-users fa-3x text-warning mb-3"></i>
                            <h5 class="card-title fw-bold">View Applicants</h5>
                            <p class="text-muted">See who applied to your open positions.</p>
                            <a href="view_applicants.jsp" class="btn btn-warning w-100 mt-2 text-dark fw-bold">Review Candidates</a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <%@include file="all_component/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>