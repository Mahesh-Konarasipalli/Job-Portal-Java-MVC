<%@ page import="com.jobportal.entity.User" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
  <div class="container">
      <a class="navbar-brand fw-bold" href="home.jsp">JobPortal</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-row">
              <a class="nav-link active" href="home.jsp">Home</a>        
        </li>
      </ul>

      <div class="d-flex align-items-center">
        <% 
          // Get user object from session
          User user = (User) session.getAttribute("userobj");
          
          if (user == null) { 
        %>
          <a href="login.jsp" class="btn btn-outline-light me-2 btn-sm">
            <i class="fas fa-sign-in-alt"></i> Login
          </a>
          <a href="register.jsp" class="btn btn-light text-primary btn-sm">
            <i class="fas fa-user-plus"></i> Register
          </a>
        <% 
          } else { 
        %>
          <span class="text-white me-3">
             Hi, <strong><%= user.getName() %></strong>
          </span>
          
          <% if("employer".equals(user.getRole())) { %>
             <a href="add_job.jsp" class="btn btn-warning btn-sm me-2">Post Job</a>
          <% } %>

          <div class="dropdown">
            <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">
              Account
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="profile.jsp">View Profile</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item text-danger" href="logout">Logout</a></li>
            </ul>
          </div>
        <% 
          } 
        %>
      </div>
    </div>
  </div>
</nav>