package com.tap.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.tap.models.User;
import com.tap.util.DBconnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    private static final String LOGIN_QUERY = "SELECT * FROM `user` WHERE `Username` = ? AND `Password` = ?";
    private static final String UPDATE_LAST_LOGIN = "UPDATE `user` SET `LastLoginDate` = ? WHERE `UserId` = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Basic validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both username and password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try {
            Connection con = DBconnection.getconnection();
            PreparedStatement pstmt = con.prepareStatement(LOGIN_QUERY);
            
            pstmt.setString(1, username.trim());
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login successful - create user object
                User user = new User(
                    rs.getInt("UserId"),
                    rs.getString("Name"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Email"),
                    rs.getString("Phone"),
                    rs.getString("Address"),
                    rs.getString("Role"),
                    rs.getTimestamp("CreatedDate"),
                    rs.getTimestamp("LastLoginDate")
                );
                
                // Update last login date
                updateLastLoginDate(user.getUserId());
                
                // Store user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userRole", user.getRole());
                
                // Check if user was trying to access a specific page before login
                String redirectURL = (String) session.getAttribute("redirectURL");
                if (redirectURL != null) {
                    session.removeAttribute("redirectURL");
                    response.sendRedirect(redirectURL);
                } else {
                    // Default redirect to restaurants page
                    response.sendRedirect("GetAllRestaurantServlet");
                }
                
            } else {
                // Login failed
                request.setAttribute("error", "Invalid username or password");
                request.setAttribute("username", username); // Preserve username
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect("login.jsp");
    }
    
    private void updateLastLoginDate(int userId) {
        try {
            Connection con = DBconnection.getconnection();
            PreparedStatement pstmt = con.prepareStatement(UPDATE_LAST_LOGIN);
            
            pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(2, userId);
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            // Don't throw exception for login date update failure
        }
    }
}