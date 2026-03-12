package com.jobportal.dao;

import java.sql.*;
import com.jobportal.entity.Job;
import com.jobportal.entity.User;

import java.util.ArrayList;
import java.util.List;

public class JobDAO {
    private Connection conn;

    public JobDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addJob(Job j) {
        boolean f = false;
        try {
            String sql = "insert into jobs(title, description, category, status, location, user_id) values(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());
            ps.setInt(6, j.getUserId());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    // NEW: Fetch all jobs for the Job Seeker's Job Board
    public List<Job> getAllJobs() {
        List<Job> list = new ArrayList<>();
        try {
            String sql = "select * from jobs order by id desc";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setDescription(rs.getString("description"));
                j.setCategory(rs.getString("category"));
                j.setStatus(rs.getString("status"));
                j.setLocation(rs.getString("location"));
                // Fallback in case pdate is null in DB
                String pdate = rs.getString("pdate");
                j.setPdate(pdate != null ? pdate : "Recent"); 
                list.add(j);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Job> getJobsByUserId(int userId) {
        List<Job> list = new ArrayList<>();
        try {
            String sql = "select * from jobs where user_id=? order by id desc";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setCategory(rs.getString("category"));
                j.setStatus(rs.getString("status"));
                j.setLocation(rs.getString("location"));
                list.add(j);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // NEW: Fetch a single job by its ID for one_view.jsp
    public Job getJobById(int id) {
        Job j = null;
        try {
            String sql = "select * from jobs where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setDescription(rs.getString("description"));
                j.setCategory(rs.getString("category"));
                j.setStatus(rs.getString("status"));
                j.setLocation(rs.getString("location"));
                String pdate = rs.getString("pdate");
                j.setPdate(pdate != null ? pdate : "Recent");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return j;
    }

    public boolean updateJob(Job j) {
        boolean f = false;
        try {
            String sql = "update jobs set title=?, description=?, category=?, status=?, location=? where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getCategory());
            ps.setString(4, j.getStatus());
            ps.setString(5, j.getLocation());
            ps.setInt(6, j.getId());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    public boolean deleteJob(int id) {
        boolean f = false;
        try {
            String sql = "delete from jobs where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
    // 1. Check if the user already applied for this specific job
    public boolean checkIfApplied(int userId, int jobId) {
        boolean f = false;
        try {
            String sql = "select * from applications where user_id=? and job_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true; // Record found, meaning they already applied!
            }
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    // 2. Save the new application
    public boolean applyForJob(int userId, int jobId) {
        boolean f = false;
        try {
            String sql = "insert into applications(user_id, job_id) values(?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
    // Fetch all jobs a specific user has applied for
    public List<Job> getAppliedJobs(int userId) {
        List<Job> list = new ArrayList<>();
        try {
            // This SQL uses an INNER JOIN to combine the jobs and applications tables
            String sql = "SELECT j.* FROM jobs j INNER JOIN applications a ON j.id = a.job_id WHERE a.user_id = ? ORDER BY a.apply_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setCategory(rs.getString("category"));
                j.setStatus(rs.getString("status"));
                j.setLocation(rs.getString("location"));
                list.add(j);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }
    // Fetch all users who applied to jobs posted by a specific employer
    public List<User> getApplicantsForEmployer(int employerId) {
        List<User> list = new ArrayList<>();
        try {
            // The 3-Table INNER JOIN
            String sql = "SELECT u.name, u.email, j.title as job_title FROM user u " +
                         "INNER JOIN applications a ON u.id = a.user_id " +
                         "INNER JOIN jobs j ON a.job_id = j.id " +
                         "WHERE j.user_id = ? ORDER BY a.apply_date DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, employerId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                User u = new User();
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setJobTitle(rs.getString("job_title")); // Using the new field we just added!
                list.add(u);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }
   // NEW & IMPROVED: Fetch jobs based on Search criteria
    public List<Job> getJobsBySearch(String location, String category) {
        List<Job> list = new ArrayList<>();
        try {
            // 1. Safety check to prevent NullPointer errors
            if (location == null) location = "";
            if (category == null) category = "All";

            // 2. The Smarter SQL Query
            // It uses AND. If category is 'All', it ignores the category filter entirely!
            String sql = "SELECT * FROM jobs WHERE location LIKE ? AND (category = ? OR ? = 'All') ORDER BY id DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            // 3. Set the parameters
            ps.setString(1, "%" + location.trim() + "%"); // %% means "contains" this text
            ps.setString(2, category);
            ps.setString(3, category);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Job j = new Job();
                j.setId(rs.getInt("id"));
                j.setTitle(rs.getString("title"));
                j.setDescription(rs.getString("description"));
                j.setCategory(rs.getString("category"));
                j.setStatus(rs.getString("status"));
                j.setLocation(rs.getString("location"));
                String pdate = rs.getString("pdate");
                j.setPdate(pdate != null ? pdate : "Recent");
                list.add(j);
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }
}