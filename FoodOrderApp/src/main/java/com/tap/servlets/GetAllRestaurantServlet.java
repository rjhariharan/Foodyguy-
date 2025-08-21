package com.tap.servlets;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.tap.daoimpl.RestaurantDAOimpl;
import com.tap.models.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet("/GetAllRestaurantServlet")
public class GetAllRestaurantServlet extends HttpServlet{
	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	     
		RestaurantDAOimpl res = new RestaurantDAOimpl();
		
		List<Restaurant> restaurants = res.getAllRestaurant();
		
		request.setAttribute("restaurants", restaurants);
		
		RequestDispatcher rd = request.getRequestDispatcher("restaurant.jsp");
		
		rd.forward(request, response);
		 
	 }


}