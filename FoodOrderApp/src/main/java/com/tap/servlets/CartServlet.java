package com.tap.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.tap.models.Cart;
import com.tap.models.CartItem;
import com.tap.models.Menu;
import com.tap.daoimpl.MenuDAOimpl;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // If cart is empty -> go to empty cart page
        if (cart.getItems().isEmpty()) {
            request.getRequestDispatcher("emptyCart.jsp").forward(request, response);
            return;
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action") != null
                ? request.getParameter("action").toLowerCase()
                : "";

        int menuId = 0;
        int restaurantId = 0;
        int quantity = 0;

        // Parse only if we aren't clearing the cart
        if (!"clear".equals(action)) {
            try {
                String menuIdStr = request.getParameter("menuId");
                String restIdStr = request.getParameter("restaurantId");
                if (menuIdStr != null) menuId = Integer.parseInt(menuIdStr);
                if (restIdStr != null) restaurantId = Integer.parseInt(restIdStr);
            } catch (NumberFormatException ignored) {}

            try {
                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
                    quantity = Integer.parseInt(qtyParam);
                }
            } catch (NumberFormatException ignored) {}
        }

        // Restaurant switching check (only if we have a restaurant id)
        if (restaurantId != 0) {
            String sessionResId = (String) session.getAttribute("restaurantId");
            if (sessionResId != null && !sessionResId.equals(String.valueOf(restaurantId))) {
                cart.clearCart();
            }
            session.setAttribute("restaurantId", String.valueOf(restaurantId));
        }

        MenuDAOimpl menuDAO = new MenuDAOimpl();

        switch (action) {

            case "add":
                Menu menu = menuDAO.getMenuById(menuId);
                if (menu != null) {
                    CartItem existing = cart.getItems().get(menuId);
                    int newQuantity = (quantity > 0) ? quantity : 1;
                    if (existing != null) {
                        existing.setQuantity(newQuantity); // overwrite (or could add to existing)
                    } else {
                        CartItem newItem = new CartItem(
                                menu.getMenuId(),
                                restaurantId,
                                menu.getItemName(),
                                newQuantity,
                                menu.getPrice()
                        );
                        cart.addItem(newItem);
                    }
                }
                break;

            case "update":
                CartItem existingItem = cart.getItems().get(menuId);
                if (existingItem != null) {
                    if (quantity > 0) {
                        existingItem.setQuantity(quantity);
                    } else {
                        // quantity 0 -> remove
                        cart.removeItem(menuId);
                        if (cart.getItems().isEmpty()) {
                            response.sendRedirect("emptyCart.jsp");
                            return;
                        }
                    }
                }
                break;

            case "remove":
                cart.removeItem(menuId);
                if (cart.getItems().isEmpty()) {
                    response.sendRedirect("emptyCart.jsp");
                    return;
                }
                break;

            case "clear":
                cart.clearCart();
                session.removeAttribute("restaurantId");
                response.sendRedirect("emptyCart.jsp");
                return;
        }

        // Default: always go back to cart page
        response.sendRedirect("CartServlet");
    }
}
