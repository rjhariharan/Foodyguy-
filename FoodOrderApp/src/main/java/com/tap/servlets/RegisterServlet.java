package com.tap.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tap.models.User;
import com.tap.daoimpl.UserDAOimpl;
import com.tap.util.DBconnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    private static final String CHECK_USERNAME_QUERY = "SELECT COUNT(*) FROM `user` WHERE `Username` = ?";
    private static final String CHECK_EMAIL_QUERY = "SELECT COUNT(*) FROM `user` WHERE `Email` = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        String validationError = validateInput(name, username, email, phone, address, password, confirmPassword);
        if (validationError != null) {
            request.setAttribute("error", validationError);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check if username already exists
            if (isUsernameExists(username.trim())) {
                request.setAttribute("error", "Username already exists. Please choose a different username.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Check if email already exists
            if (isEmailExists(email.trim())) {
                request.setAttribute("error", "Email already registered. Please use a different email or login.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Create new user
            User newUser = new User(
                name.trim(),
                username.trim(),
                password,
                email.trim(),
                phone.trim(),
                address.trim(),
                "customer" // Default role
            );
            
            // Save user to database
            UserDAOimpl userDAO = new UserDAOimpl();
            userDAO.addUser(newUser);
            
            // Registration successful
            request.setAttribute("success", "Registration successful! You can now login with your credentials.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed due to database error. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to register page
        response.sendRedirect("register.jsp");
    }
    
    private String validateInput(String name, String username, String email, String phone, 
                                String address, String password, String confirmPassword) {
        
        if (name == null || name.trim().isEmpty()) {
            return "Name is required";
        }
        
        if (username == null || username.trim().isEmpty()) {
            return "Username is required";
        }
        
        if (username.trim().length() < 3) {
            return "Username must be at least 3 characters long";
        }
        
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        
        if (!isValidEmail(email.trim())) {
            return "Please enter a valid email address";
        }
        
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number is required";
        }
        
        if (!isValidPhone(phone.trim())) {
            return "Please enter a valid 10-digit phone number";
        }
        
        if (address == null || address.trim().isEmpty()) {
            return "Address is required";
        }
        
        if (password == null || password.isEmpty()) {
            return "Password is required";
        }
        
        if (password.length() < 6) {
            return "Password must be at least 6 characters long";
        }
        
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            return "Passwords do not match";
        }
        
        return null; // No validation errors
    }
    
    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }
    
    private boolean isValidPhone(String phone) {
        return phone.matches("^[0-9]{10}$");
    }
    
    private boolean isUsernameExists(String username) throws SQLException {
        Connection con = DBconnection.getconnection();
        PreparedStatement pstmt = con.prepareStatement(CHECK_USERNAME_QUERY);
        pstmt.setString(1, username);
        
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        return rs.getInt(1) > 0;
    }
    
    private boolean isEmailExists(String email) throws SQLException {
        Connection con = DBconnection.getconnection();
        PreparedStatement pstmt = con.prepareStatement(CHECK_EMAIL_QUERY);
        pstmt.setString(1, email);
        
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        return rs.getInt(1) > 0;
    }
}