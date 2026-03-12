package com.jobportal.dao;

import java.sql.*;
import com.jobportal.entity.User;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addUser(User u) {
        boolean f = false;
        try {
            String sql = "insert into user(name, email, password, role) values(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    public User login(String email, String password) {
        User u = null;
        try {
            String sql = "select * from user where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }
    // Method to update user profile
    public boolean updateUser(User u) {
        boolean f = false;
        try {
            String sql = "update user set name=?, email=?, password=? where id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setInt(4, u.getId());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
}
