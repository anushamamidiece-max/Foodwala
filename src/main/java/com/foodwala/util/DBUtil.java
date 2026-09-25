package com.foodwala.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Central JDBC helper for the whole application.
 * Uses plain JDBC - no frameworks, only MySQL Connector/J 9.2.
 *
 * >>> EDIT DB_USER / DB_PASSWORD BELOW TO MATCH YOUR MYSQL SETUP <<<
 */
public class DBUtil {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static final String URL =
            "jdbc:mysql://localhost:3306/foodwala?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String DB_USER =
            System.getenv().getOrDefault("FOODWALA_DB_USER", "root");

    private static final String DB_PASSWORD =
            System.getenv().getOrDefault("FOODWALA_DB_PASSWORD", "");
    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Connector/J not found on classpath!");
            System.err.println("Copy mysql-connector-j-9.2.0.jar into src/main/webapp/WEB-INF/lib");
            e.printStackTrace();
        }
    }

    /** Opens a new connection to the foodwala database. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
    }

    /** Null-safe close of Connection / Statement / ResultSet. */
    public static void close(Connection con, Statement st, ResultSet rs) {
        if (rs != null) { try { rs.close(); } catch (SQLException ignored) { } }
        if (st != null) { try { st.close(); } catch (SQLException ignored) { } }
        if (con != null) { try { con.close(); } catch (SQLException ignored) { } }
    }
}
