package com.tap.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

import com.tap.models.Cart;
import com.tap.models.CartItem;
import com.tap.models.Orders;
import com.tap.models.OrderItem;
import com.tap.models.User;
import com.tap.daoimpl.OrdersDAOimpl;
import com.tap.daoimpl.OrderitemDAOimpl;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Store the current URL to redirect back after login
            session.setAttribute("redirectURL", "CheckoutServlet");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Check if cart exists and has items
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("emptyCart.jsp");
            return;
        }
        
        // ALWAYS redirect to checkout.jsp for payment method selection
        // regardless of whether user was already logged in or just logged in
        request.setAttribute("cart", cart);
        request.setAttribute("user", user);
        
        // Calculate order summary for display
        double subtotal = cart.getTotal();
        double deliveryFee = 30.0;
        double taxes = subtotal * 0.05;
        double totalAmount = subtotal + deliveryFee + taxes;
        
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("taxes", taxes);
        request.setAttribute("totalAmount", totalAmount);
        
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // If somehow user is not logged in during POST, redirect to login
            session.setAttribute("redirectURL", "CheckoutServlet");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Process the order here
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("emptyCart.jsp");
            return;
        }
        
        // Get payment method (this should always be provided from checkout.jsp form)
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            // If no payment method selected, redirect back to checkout page with error
            request.setAttribute("error", "Please select a payment method");
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            
            // Recalculate order summary
            double subtotal = cart.getTotal();
            double deliveryFee = 30.0;
            double taxes = subtotal * 0.05;
            double totalAmount = subtotal + deliveryFee + taxes;
            
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("deliveryFee", deliveryFee);
            request.setAttribute("taxes", taxes);
            request.setAttribute("totalAmount", totalAmount);
            
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Check if order was already processed to prevent duplicates
        if (session.getAttribute("orderProcessed") != null) {
            System.out.println("Order already processed, redirecting to success page");
            response.sendRedirect("orderSuccess.jsp");
            return;
        }
        
        // Check if order is currently being processed
        if (session.getAttribute("orderProcessing") != null) {
            System.out.println("Order is currently being processed, please wait");
            request.setAttribute("error", "Order is being processed, please wait...");
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            
            // Recalculate order summary
            double subtotal = cart.getTotal();
            double deliveryFee = 30.0;
            double taxes = subtotal * 0.05;
            double totalAmount = subtotal + deliveryFee + taxes;
            
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("deliveryFee", deliveryFee);
            request.setAttribute("taxes", taxes);
            request.setAttribute("totalAmount", totalAmount);
            
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
        
        // Mark order as being processed
        session.setAttribute("orderProcessing", true);
        
        // Normalize payment method to match database ENUM values exactly
        String normalizedPaymentMethod;
        switch (paymentMethod.toLowerCase()) {
            case "cash on delivery":
            case "cod":
                normalizedPaymentMethod = "cash";
                break;
            case "credit card":
            case "debit card":
            case "card":
                normalizedPaymentMethod = "card";
                break;
            case "upi":
                normalizedPaymentMethod = "upi";
                break;
            case "wallet":
                normalizedPaymentMethod = "wallet";
                break;
            default:
                normalizedPaymentMethod = "cash"; // Default to cash if unknown
        }
        
        System.out.println("=== DEBUG: Payment method normalized from '" + paymentMethod + "' to '" + normalizedPaymentMethod + "' ===");
        
        // Get restaurant ID from session
        String restaurantIdStr = (String) session.getAttribute("restaurantId");
        int restaurantId = (restaurantIdStr != null) ? Integer.parseInt(restaurantIdStr) : 0;
        
        // Calculate total with delivery and taxes
        double subtotal = cart.getTotal();
        double deliveryFee = 30.0;
        double taxes = subtotal * 0.05;
        double totalAmount = subtotal + deliveryFee + taxes;
        
        System.out.println("=== DEBUG: Order details ===");
        System.out.println("User ID: " + user.getUserId());
        System.out.println("Restaurant ID: " + restaurantId);
        System.out.println("Total Amount: " + totalAmount);
        System.out.println("Payment Method: " + normalizedPaymentMethod);
        System.out.println("Address: " + user.getAddress());
        
        try {
            // Create and save order to database
            Orders order = new Orders(
                user.getUserId(),
                restaurantId,
                new Date(System.currentTimeMillis()),
                totalAmount,
                "placed", // Must match ENUM exactly
                normalizedPaymentMethod, // Must match ENUM exactly
                user.getAddress()
            );
            
            OrdersDAOimpl orderDAO = new OrdersDAOimpl();
            System.out.println("=== DEBUG: Creating order in database ===");
            int orderId = orderDAO.addOrders(order);
            
            System.out.println("=== DEBUG: Order created with ID: " + orderId + " ===");
            
            if (orderId <= 0) {
                System.err.println("ERROR: Invalid order ID received: " + orderId);
                throw new Exception("Failed to create order - invalid order ID");
            }
            
            // Save order items to database
            OrderitemDAOimpl orderItemDAO = new OrderitemDAOimpl();
            System.out.println("=== DEBUG: Processing " + cart.getItems().size() + " cart items ===");
            
            for (CartItem item : cart.getItems().values()) {
                System.out.println("Processing cart item - MenuId: " + item.getMenuid() + 
                                 ", Quantity: " + item.getQuantity() + 
                                 ", Price: " + item.getPrice());
                
                // Create OrderItem with all required parameters
                OrderItem orderItem = new OrderItem(
                    0, // orderItemId will be auto-generated
                    orderId,
                    item.getMenuid(),
                    item.getQuantity(),
                    item.getPrice() * item.getQuantity()
                );
                
                System.out.println("Created OrderItem object, calling addOrderItem...");
                orderItemDAO.addOrderItem(orderItem);
                System.out.println("Finished processing cart item");
            }
            
            // Clear cart after successful order
            cart.clearCart();
            session.removeAttribute("restaurantId");
            session.removeAttribute("orderProcessing");
            session.setAttribute("orderProcessed", true);
            
            // Create success message based on payment method
            String message = "Order #" + orderId + " placed successfully! ";
            switch (normalizedPaymentMethod) {
                case "cash":
                    message += "You can pay ₹" + String.format("%.2f", totalAmount) + " in cash when your order arrives.";
                    break;
                case "card":
                    message += "Payment of ₹" + String.format("%.2f", totalAmount) + " has been processed via your card.";
                    break;
                case "upi":
                    message += "Payment of ₹" + String.format("%.2f", totalAmount) + " has been processed via UPI.";
                    break;
                case "wallet":
                    message += "Payment of ₹" + String.format("%.2f", totalAmount) + " has been deducted from your wallet.";
                    break;
                default:
                    message += "Payment method: " + normalizedPaymentMethod;
            }
            message += " Your delicious food will be delivered to you soon. Thank you for choosing FoodExpress!";
            
            request.setAttribute("message", message);
            request.setAttribute("orderId", orderId);
            request.setAttribute("paymentMethod", normalizedPaymentMethod);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("=== ERROR: Exception occurred while processing order ===");
            e.printStackTrace();
            // Remove processing flag on error
            session.removeAttribute("orderProcessing");
            request.setAttribute("error", "Failed to place order. Please try again. Error: " + e.getMessage());
            request.setAttribute("cart", cart);
            request.setAttribute("user", user);
            
            // Recalculate order summary for error case
            double subtotal2 = cart.getTotal();
            double deliveryFee2 = 30.0;
            double taxes2 = subtotal2 * 0.05;
            double totalAmount2 = subtotal2 + deliveryFee2 + taxes2;
            
            request.setAttribute("subtotal", subtotal2);
            request.setAttribute("deliveryFee", deliveryFee2);
            request.setAttribute("taxes", taxes2);
            request.setAttribute("totalAmount", totalAmount2);
            
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}