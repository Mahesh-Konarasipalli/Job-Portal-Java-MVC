<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile | Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <%-- Include Navbar --%>
    <%@include file="all_component/navbar.jsp" %>

    <%-- Security Check --%>
    <%
    User u = (User)session.getAttribute("userobj");
    if(u == null) {
        session.setAttribute("errorMsg", "Please login to view your profile.");
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg border-0 rounded-3">
                    <div class="card-body p-5">
                        
                        <div class="text-center mb-4">
                            <%-- Show a different icon based on their role --%>
                            <% if("employer".equals(u.getRole())) { %>
                                <i class="fas fa-user-tie fa-5x text-primary mb-3"></i>
                            <% } else { %>
                                <i class="fas fa-user-graduate fa-5x text-success mb-3"></i>
                            <% } %>
                            
                            <h2 class="fw-bold text-dark"><%= u.getName() %></h2>
                            <span class="badge bg-secondary px-3 py-2 fs-6 text-capitalize">
                                <%= u.getRole() %> Account
                            </span>
                        </div>

                        <hr class="my-4">
                        <% String succ = (String)session.getAttribute("succMsg");
                           String err = (String)session.getAttribute("errorMsg");
                           if(succ != null) { %>
                           <div class="alert alert-success text-center fw-bold"><i class="fas fa-check-circle"></i> <%= succ %></div>
                        <% session.removeAttribute("succMsg"); } 
                           if(err != null) { %>
                           <div class="alert alert-danger text-center fw-bold"><i class="fas fa-exclamation-triangle"></i> <%= err %></div>
                        <% session.removeAttribute("errorMsg"); } %>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <p class="mb-0 fw-bold text-muted">Full Name</p>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-dark mb-0 fw-semibold"><%= u.getName() %></p>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <p class="mb-0 fw-bold text-muted">Email Address</p>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-dark mb-0 fw-semibold"><%= u.getEmail() %></p>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-sm-4">
                                <p class="mb-0 fw-bold text-muted">Account ID</p>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-dark mb-0 fw-semibold">#<%= u.getId() %></p>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <a href="home.jsp" class="btn btn-outline-secondary px-4 me-2">
                                <i class="fas fa-arrow-left"></i> Back to Dashboard
                            </a>
                            <a href="edit_profile.jsp" class="btn btn-primary px-4">
                                <i class="fas fa-user-edit"></i> Edit Profile
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>