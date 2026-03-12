<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<%
    User u = (User)session.getAttribute("userobj");
    if(u != null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to JobPortal | Find Your Dream Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 70vh;
            color: white;
            display: flex;
            align-items: center;
            text-align: center;
        }
    </style>
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>

    <%-- Hero Section --%>
    <div class="hero-section">
        <div class="container">
            <h1 class="display-3 fw-bold mb-3">Your Next Career Move Starts Here</h1>
            <p class="lead mb-4">Connecting the best talent with the world's most innovative companies.</p>
            <div>
                <% if (user == null) { %>
                    <%-- Show this only to GUESTS --%>
                    <a href="register.jsp" class="btn btn-primary btn-lg px-4 me-2">Get Started</a>
                    <a href="login.jsp" class="btn btn-outline-light btn-lg px-4">Post a Job</a>
                <% } else { %>
                    <%-- Show this only to LOGGED-IN users --%>
                    <h3 class="mb-4">Welcome back, <%= user.getName() %>!</h3>
                    <a href="home.jsp" class="btn btn-primary btn-lg px-4">Go to My Dashboard</a>
                <% } %>
            </div>
        </div>
    </div>

    <%-- Features Section --%>
    <div class="container mt-5 mb-5">
        <div class="row text-center">
            <div class="col-md-4">
                <div class="p-4">
                    <i class="fas fa-search-location fa-3x text-primary mb-3"></i>
                    <h4>Easy Search</h4>
                    <p class="text-muted">Filter through thousands of jobs by location and industry instantly.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="p-4">
                    <i class="fas fa-user-check fa-3x text-success mb-3"></i>
                    <h4>Verified Employers</h4>
                    <p class="text-muted">Apply with confidence knowing our companies are thoroughly vetted.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="p-4">
                    <i class="fas fa-bolt fa-3x text-warning mb-3"></i>
                    <h4>Quick Apply</h4>
                    <p class="text-muted">Submit your application in just one click and track your status.</p>
                </div>
            </div>
        </div>
    </div>

    <%@include file="all_component/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>