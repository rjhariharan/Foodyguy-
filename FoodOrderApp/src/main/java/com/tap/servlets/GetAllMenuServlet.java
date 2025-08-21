package com.tap.servlets;

import java.io.IOException;
import java.util.List;

import com.tap.daoimpl.MenuDAOimpl;
import com.tap.daoimpl.RestaurantDAOimpl;
import com.tap.models.Menu;
import com.tap.models.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class GetAllMenuServlet extends HttpServlet {

    public GetAllMenuServlet() { super(); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = request.getParameter("restaurantId");
        int restaurantId = -1;
        if (rid != null) {
            try {
                restaurantId = Integer.parseInt(rid);
            } catch (NumberFormatException e) {
                // invalid id -> forward with empty list or error message
                request.setAttribute("menus", java.util.Collections.emptyList());
                request.setAttribute("error", "Invalid restaurant id.");
                RequestDispatcher rd = request.getRequestDispatcher("menu.jsp");
                rd.forward(request, response);
                return;
            }
        } else {
            // no id provided -> forward with empty list
            request.setAttribute("menus", java.util.Collections.emptyList());
            request.setAttribute("error", "No restaurant selected.");
            RequestDispatcher rd = request.getRequestDispatcher("menu.jsp");
            rd.forward(request, response);
            return;
        }

        // call DAO
        MenuDAOimpl dao = new MenuDAOimpl();
        List<Menu> menus = dao.getAllmenubyRestaurant(restaurantId); 
        
      // ensure this returns List<Menu>
        
       RestaurantDAOimpl restaurant = new RestaurantDAOimpl();
       Restaurant res = restaurant.getRestaurant(restaurantId);

        request.setAttribute("menus", menus);
        request.setAttribute("restaurantId", restaurantId);
        request.setAttribute("restaurantName", res.getName());
        request.setAttribute("restaurantPhone", res.getPhone());
   
        RequestDispatcher rd = request.getRequestDispatcher("menu.jsp");
        
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
