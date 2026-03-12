<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.entity.User" %>
<%@ page import="com.jobportal.entity.Job" %>
<%@ page import="com.jobportal.dao.JobDAO" %>
<%@ page import="com.jobportal.db.DBConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Job</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    
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
            <div class="col-md-8"> 
                <div class="card shadow-lg border-0">
                    <div class="card-body p-4">
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <a href="manage_jobs.jsp" class="btn btn-outline-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                            <div class="text-center text-primary">
                                <i class="fas fa-edit fa-2x mb-2"></i>
                                <h4 class="mb-0">Edit Job Post</h4>
                            </div>
                            <div style="width: 70px;"></div>
                        </div>

                        <%
                            // Fetch the job details based on the ID in the URL
                            int id = Integer.parseInt(request.getParameter("id"));
                            JobDAO dao = new JobDAO(DBConnect.getConn());
                            Job j = dao.getJobById(id);
                        %>

                        <%-- The Form points to the new UpdateJobServlet --%>
                        <form action="edit_job" method="post">
                            
                            <%-- Hidden field to pass the Job ID to the Servlet --%>
                            <input type="hidden" name="id" value="<%= j.getId() %>">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Job Title</label>
                                    <input type="text" name="title" value="<%= j.getTitle() %>" class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Location</label>
                                    <input type="text" name="location" value="<%= j.getLocation() %>" class="form-control" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Category</label>
                                    <select name="category" class="form-select">
                                        <option value="IT & Software" <%= "IT & Software".equals(j.getCategory()) ? "selected" : "" %>>IT & Software</option>
                                        <option value="Finance & Accounting" <%= "Finance & Accounting".equals(j.getCategory()) ? "selected" : "" %>>Finance & Accounting</option>
                                        <option value="Marketing & Sales" <%= "Marketing & Sales".equals(j.getCategory()) ? "selected" : "" %>>Marketing & Sales</option>
                                        <option value="HR & Admin" <%= "HR & Admin".equals(j.getCategory()) ? "selected" : "" %>>HR & Admin</option>
                                        <option value="Design & Creative" <%= "Design & Creative".equals(j.getCategory()) ? "selected" : "" %>>Design & Creative</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-bold">Status</label>
                                    <select name="status" class="form-select">
                                        <option value="Active" <%= "Active".equals(j.getStatus()) ? "selected" : "" %>>Active (Publish Now)</option>
                                        <option value="Inactive" <%= "Inactive".equals(j.getStatus()) ? "selected" : "" %>>Inactive (Save for Later)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">Job Description</label>
                                <textarea name="desc" class="form-control" rows="6" required><%= j.getDescription() %></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100 py-2 fs-5">
                                <i class="fas fa-save me-2"></i> Update Job
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