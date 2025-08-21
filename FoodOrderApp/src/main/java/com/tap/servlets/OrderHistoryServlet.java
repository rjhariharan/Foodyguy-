package com.tap.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import com.tap.models.Orders;
import com.tap.models.User;
import com.tap.daoimpl.OrdersDAOimpl;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Store the current URL to redirect back after login
            session.setAttribute("redirectURL", "OrderHistoryServlet");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get all orders for the logged-in user
            OrdersDAOimpl orderDAO = new OrdersDAOimpl();
            List<Orders> allOrders = orderDAO.getAllOrders();
            
            // Filter orders for the current user
            List<Orders> userOrders = new ArrayList<>();
            for (Orders order : allOrders) {
                if (order.getUserId() == user.getUserId()) {
                    userOrders.add(order);
                }
            }
            
            // Sort orders by date (newest first)
            userOrders.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));
            
            request.setAttribute("ordersList", userOrders);
            request.getRequestDispatcher("orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load order history. Please try again.");
            request.getRequestDispatcher("orders.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}