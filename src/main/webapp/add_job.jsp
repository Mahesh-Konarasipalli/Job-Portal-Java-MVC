<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post a Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    
    <%-- Include Navbar --%>
    <%@include file="all_component/navbar.jsp" %>

    <%-- Security: Redirect if not an Employer --%>
    <%
    User u = (User)session.getAttribute("userobj");
    if(u == null || !"employer".equals(u.getRole())) {
        session.setAttribute("errorMsg", "Access Denied. Employers only!");
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8"> <div class="card shadow-lg border-0">
                    <div class="card-body p-4">
                        
                        <%-- Header Section with Back Button --%>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <a href="home.jsp" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                            <div class="text-center text-primary">
                                <i class="fas fa-briefcase fa-2x mb-2"></i>
                                <h4 class="mb-0">Post A New Job</h4>
                            </div>
                            <div style="width: 70px;"></div> </div>

                        <%-- Alerts --%>
                        <% String succ = (String)session.getAttribute("succMsg");
                           String err = (String)session.getAttribute("errorMsg");
                           if(succ != null) { %>
                           <div class="alert alert-success text-center"><%= succ %></div>
                        <% session.removeAttribute("succMsg"); } 
                           if(err != null) { %>
                           <div class="alert alert-danger text-center"><%= err %></div>
                        <% session.removeAttribute("errorMsg"); } %>

                        <%-- The Form --%>
                        <form action="add_job" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Job Title</label>
                                    <input type="text" name="title" class="form-control" placeholder="e.g., Senior Java Developer" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Location</label>
                                    <input type="text" name="location" class="form-control" placeholder="e.g., Bangalore, India" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Category</label>
                                    <select name="category" class="form-select">
                                        <option value="IT & Software">IT & Software</option>
                                        <option value="Finance & Accounting">Finance & Accounting</option>
                                        <option value="Marketing & Sales">Marketing & Sales</option>
                                        <option value="HR & Admin">HR & Admin</option>
                                        <option value="Design & Creative">Design & Creative</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Status</label>
                                    <select name="status" class="form-select">
                                        <option value="Active">Active (Publish Now)</option>
                                        <option value="Inactive">Inactive (Save for Later)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">Job Description</label>
                                <textarea name="desc" class="form-control" rows="6" placeholder="Describe the responsibilities, requirements, and benefits..." required></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-success w-100 py-2 fs-5">
                                <i class="fas fa-paper-plane me-2"></i> Publish Job
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>