<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile | Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <%@include file="all_component/navbar.jsp" %>

    <%
    User u = (User)session.getAttribute("userobj");
    if(u == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0"><i class="fas fa-user-edit"></i> Edit Your Details</h4>
                    </div>
                    <div class="card-body p-4">
                        
                        <form action="update_profile" method="post">
                            <%-- Hidden ID so the database knows who to update --%>
                            <input type="hidden" name="id" value="<%= u.getId() %>">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Full Name</label>
                                <input type="text" name="name" class="form-control" value="<%= u.getName() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Email Address</label>
                                <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">Password</label>
                                <input type="text" name="password" class="form-control" value="<%= u.getPassword() %>" required>
                                <small class="text-muted">Type a new password or leave it as is.</small>
                            </div>
                            
                            <button type="submit" class="btn btn-success w-100 fs-5">
                                <i class="fas fa-save me-2"></i> Save Changes
                            </button>
                            <div class="text-center mt-3">
                                <a href="profile.jsp" class="text-decoration-none">Cancel</a>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>