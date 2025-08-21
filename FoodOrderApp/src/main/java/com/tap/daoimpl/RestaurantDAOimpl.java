package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.models.Restaurant;
import com.tap.util.DBconnection;

public class RestaurantDAOimpl implements RestaurantDAO {
	
	
	private String INSERT_REST = "INSERT into `restaurant`(`name`,`address`,`phone`,`rating`,`cuisinetype`,`isactive`,`eta`,`adminuserid`,`imagepath`) values (?,?,?,?,?,?,?,?,?)";
	private String GET_Restaurant = "SELECT * FROM `restaurant` WHERE `restaurantid` = ?";
	private String UPDATE ="UPDATE `restaurant` SET `name`=?,`address`=?,`phone`=?,`rating`=?,`cuisinetype`=?,`eta`=?,`imagepath`=? WHERE `restaurantid` = ?";
	private String GET_ALL_Restaurant="SELECT * FROM `restaurant`";
	private String DELETE_Restaurant="DELETE FROM `restaurant` where `restaurantid` = ?";

	

	@Override
	public void addRestaurant(Restaurant rest) {
		
try {
			
			Connection con = DBconnection.getconnection();
			
			PreparedStatement pstmt = con.prepareStatement(INSERT_REST);
			
			
			pstmt.setString(1, rest.getName());
			pstmt.setString(2, rest.getAddress());
			pstmt.setString(3, rest.getPhone());
			pstmt.setDouble(4, rest.getRating());
			pstmt.setString(5, rest.getCuisineType());
			pstmt.setBoolean(6, rest.isActive());
			pstmt.setInt(7, rest.getEta());
			pstmt.setInt(8, rest.getAdminUserId());
			pstmt.setString(9, rest.getImagePath());
			
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
			
		} 
		catch(SQLException a) {
			a.printStackTrace();
		}
		
		
	}

	@Override
	public void updateRestaurant(Restaurant rest) {
	    try {
	        Connection con = DBconnection.getconnection();
	        PreparedStatement pstmt = con.prepareStatement(UPDATE);

	        pstmt.setString(1, rest.getName());
	        pstmt.setString(2, rest.getAddress());
	        pstmt.setString(3, rest.getPhone());
	        pstmt.setDouble(4, rest.getRating());
	        pstmt.setString(5, rest.getCuisineType());
	        pstmt.setInt(6, rest.getEta());
	        pstmt.setString(7, rest.getImagePath());
	        pstmt.setInt(8, rest.getRestaurantId());

	        int res = pstmt.executeUpdate();
	        System.out.println(res);

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public void deleteRestaurant(int id) {
	    try {
	        Connection con = DBconnection.getconnection();
	        PreparedStatement pstmt = con.prepareStatement(DELETE_Restaurant);
	        pstmt.setInt(1, id);
	        int res = pstmt.executeUpdate();
	        System.out.println(res);
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public Restaurant getRestaurant(int id) {
	    Restaurant restaurant = null;
	    try {
	        Connection con = DBconnection.getconnection();
	        PreparedStatement pstmt = con.prepareStatement(GET_Restaurant);
	        pstmt.setInt(1, id);

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            restaurant = new Restaurant(
	                rs.getInt("restaurantid"),
	                rs.getString("name"),
	                rs.getString("address"),
	                rs.getString("phone"),
	                rs.getDouble("rating"),
	                rs.getString("cuisinetype"),
	                rs.getBoolean("isactive"),
	                rs.getInt("eta"),
	                rs.getInt("adminuserid"),
	                rs.getString("imagepath")
	            );
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return restaurant;
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
	    List<Restaurant> restaurantList = new java.util.ArrayList<>();

	    try {
	        Connection con = DBconnection.getconnection();
	        PreparedStatement pstmt = con.prepareStatement(GET_ALL_Restaurant);
	       ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Restaurant rest = new Restaurant(
	                rs.getInt("restaurantid"),
	                rs.getString("name"),
	                rs.getString("address"),
	                rs.getString("phone"),
	                rs.getDouble("rating"),
	                rs.getString("cuisinetype"),
	                rs.getBoolean("isactive"),
	                rs.getInt("eta"),
	                rs.getInt("adminuserid"),
	                rs.getString("imagepath")
	            );
	            restaurantList.add(rest);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return restaurantList;
	}
}