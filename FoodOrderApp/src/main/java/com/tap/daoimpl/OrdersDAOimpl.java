package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrdersDAO;
import com.tap.models.Orders;
import com.tap.models.User;
import com.tap.util.DBconnection;

public class OrdersDAOimpl implements OrdersDAO {
	

	private String INSERT_ORDERS = "INSERT into `ORDERS`(`userid`,`restaurantid`,`orderdate`,`totalamount`,`status`,`paymentmethod`,`address`) values (?,?,?,?,?,?,?)";
	private String GET_ORDERS = "SELECT * FROM `ORDERS` WHERE `orderid` = ?";
	private String UPDATE_ORDERS ="UPDATE `ORDERS` SET `status`=?,`paymentmethod`=? ,`address`=?WHERE `orderid` = ?";
	private String GET_ALL_ORDERS="SELECT * FROM `ORDERS`";
	private String DELETE_ORDERS="DELETE FROM `ORDERS` where `orderid` = ?";
	private String GET_LAST_ORDER_ID= "SELECT LAST_INSERT_ID()";;

	@Override
	public int addOrders(Orders orders) {
		
		int orderid=0;
		
		Connection con = DBconnection.getconnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(INSERT_ORDERS,Statement.RETURN_GENERATED_KEYS);
			
			pstmt.setInt(1, orders.getUserId());
			pstmt.setInt(2, orders.getRestaurantId());
			pstmt.setDate(3, orders.getOrderDate());
			pstmt.setDouble(4, orders.getTotalAmount());
			pstmt.setString(5, orders.getStatus());
			pstmt.setString(6, orders.getPaymentMode());
			pstmt.setString(7, orders.getAddress());
			
			int res = pstmt.executeUpdate();
			
			ResultSet ids=pstmt.getGeneratedKeys();
			
			while(ids.next()) {
				orderid=ids.getInt(1);
			}
			
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return orderid;
		
		
	}
	
	
	
	
	

	@Override
	public void updateOrders(Orders orders) {
		
	Connection con = DBconnection.getconnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_ORDERS);
			
			
			pstmt.setString(1, orders.getStatus());
			pstmt.setString(2, orders.getPaymentMode());
			pstmt.setString(3, orders.getAddress());
			pstmt.setInt(4, orders.getOrderId());
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	

	@Override
	public void deleteOrders(int id) {
		
	Connection con = DBconnection.getconnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_ORDERS);
			
			pstmt.setInt(1,id);
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	

	@Override
	public Orders getOrders(int id) {
		
	Connection con = DBconnection.getconnection();
	
	Orders orders = null;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_ORDERS);
			
			pstmt.setInt(1, id);
			
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				
				int orderid=res.getInt(1);
				int userid=res.getInt(2);
				int restid=res.getInt(3);
				Date orderdate=res.getDate(4);
				double totalamount=res.getDouble(5);
				String status=res.getString(6);
				String paymentmode=res.getString(7);
				String address=res.getString(8);
				
				orders=new Orders(orderid,userid,restid,orderdate,totalamount,status,paymentmode,address);
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
		return orders;
	}

	
	
	@Override
	public List<Orders> getAllOrders() {
		
		
		Connection con = DBconnection.getconnection();
		
		ArrayList<Orders> list = new ArrayList<Orders>();
		
		Orders orders;
			
			try {
				
				PreparedStatement pstmt = con.prepareStatement(GET_ALL_ORDERS);
				
				ResultSet res = pstmt.executeQuery();
				
				while(res.next()) {
					
					int orderid=res.getInt(1);
					int userid=res.getInt(2);
					int restid=res.getInt(3);
					Date orderdate=res.getDate(4);
					double totalamount=res.getDouble(5);
					String status=res.getString(6);
					String paymentmode=res.getString(7);
					String address=res.getString(8);
					
					orders=new Orders(orderid,userid,restid,orderdate,totalamount,status,paymentmode,address);
					list.add(orders);
					
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	
			return list;
			}
	
	
	@Override
		public int getLastInsertedOrderId() {
			Connection con = DBconnection.getconnection();
			int orderId = -1;
			
			try {
				PreparedStatement pstmt = con.prepareStatement(GET_LAST_ORDER_ID);
				ResultSet res = pstmt.executeQuery();
				
				if (res.next()) {
					orderId = res.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			return orderId;
		}
	 	
	 	
	 	

}
