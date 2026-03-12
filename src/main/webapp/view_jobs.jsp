<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO" %>
<%@ page import="com.jobportal.db.DBConnect" %>
<%@ page import="com.jobportal.entity.Job" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Explore Jobs | Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <%@include file="all_component/navbar.jsp" %>

    <div class="container mt-4 mb-5">
        
        <%-- Header Section --%>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <a href="home.jsp" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
            <h3 class="text-primary fw-bold mb-0">Explore Jobs</h3>
            <div style="width: 120px;"></div>
        </div>

        <%-- NEW: The Search Bar Form --%>
        <div class="row mb-4">
            <div class="col-md-10 offset-md-1">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-3">
                        <form action="view_jobs.jsp" method="get" class="row g-2 align-items-center">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="fas fa-map-marker-alt text-danger"></i></span>
                                    <input type="text" name="location" class="form-control border-start-0" placeholder="Enter Location (e.g., Bangalore)">
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="fas fa-briefcase text-primary"></i></span>
                                    <select name="category" class="form-select border-start-0">
                                        <option value="All">All Categories</option>
                                        <option value="IT & Software">IT & Software</option>
                                        <option value="Finance & Accounting">Finance & Accounting</option>
                                        <option value="Marketing & Sales">Marketing & Sales</option>
                                        <option value="HR & Admin">HR & Admin</option>
                                        <option value="Design & Creative">Design & Creative</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100 fw-bold">
                                    <i class="fas fa-search"></i> Search
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <%
                // SMART LOGIC: Check if the user submitted a search
                String location = request.getParameter("location");
                String category = request.getParameter("category");
                
                JobDAO dao = new JobDAO(DBConnect.getConn());
                List<Job> list = null;

                // If location OR category was searched, use the search method
                if((location != null && !location.trim().isEmpty()) || (category != null && !category.equals("All"))) {
                    list = dao.getJobsBySearch(location, category);
                } else {
                    // Otherwise, just show all active jobs
                    list = dao.getAllJobs();
                }

                if(list.isEmpty()) {
            %>
                <div class="col-md-12 text-center mt-5">
                    <i class="fas fa-search-minus fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">No jobs found matching your criteria.</h4>
                    <a href="view_jobs.jsp" class="btn btn-outline-primary mt-2">Clear Search</a>
                </div>
            <%
                } else {
                    for (Job j : list) {
            %>
            <div class="col-md-10 offset-md-1 mb-3">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="text-primary fw-bold mb-1">
                                <i class="fas fa-briefcase me-2"></i><%= j.getTitle() %>
                            </h5>
                            <span class="badge rounded-pill bg-light text-primary border border-primary">
                                <%= j.getCategory() %>
                            </span>
                        </div>
                        
                        <p class="mt-2 text-muted small">
                            <%= (j.getDescription().length() > 160) ? j.getDescription().substring(0, 160) + "..." : j.getDescription() %>
                        </p>
                        
                        <div class="row align-items-center">
                            <div class="col-md-4">
                                <small class="text-muted"><i class="fas fa-map-marker-alt text-danger me-1"></i> <%= j.getLocation() %></small>
                            </div>
                            <div class="col-md-4">
                                <small class="text-muted"><i class="fas fa-clock text-success me-1"></i> Posted: <%= j.getPdate().substring(0, 10) %></small>
                            </div>
                            <div class="col-md-4 text-end">
                                <a href="one_view.jsp?id=<%= j.getId() %>" class="btn btn-sm btn-primary px-3">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                    } 
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>