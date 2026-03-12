<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Job Portal - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h4>Create an Account</h4>
                    </div>
                    <div class="card-body">
                        <form action="register" method="post">
                            <%
                            String succMsg = (String)session.getAttribute("succMsg");
                            String errorMsg = (String)session.getAttribute("errorMsg");
                            if(succMsg != null) { %>
                                <div class="alert alert-success"><%= succMsg %></div>
                            <% session.removeAttribute("succMsg"); }
                            if(errorMsg != null) { %>
                                <div class="alert alert-danger"><%= errorMsg %></div>
                            <% session.removeAttribute("errorMsg"); }
                            %>
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Register As</label>
                                <select name="role" class="form-select">
                                    <option value="seeker">Job Seeker</option>
                                    <option value="employer">Employer</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Register</button>
                        </form>
                        <div class="text-center mt-3">
                            <small>Already have an account? <a href="login.jsp">Login here</a></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>