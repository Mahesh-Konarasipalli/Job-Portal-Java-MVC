package com.jobportal.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private static Connection conn;

    public static Connection getConn() {
        try {
            if (conn == null) {
                // Change 'job_portal_db' to your actual database name
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/job_portal_db", "root", "password");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
