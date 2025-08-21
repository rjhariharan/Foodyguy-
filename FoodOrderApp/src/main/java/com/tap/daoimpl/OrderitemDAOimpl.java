package com.tap.daoimpl;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.util.ArrayList;
	import java.util.List;
	import com.tap.dao.OrderItemDAO;
	import com.tap.models.OrderItem;
	import com.tap.util.DBconnection;

	public class OrderitemDAOimpl implements OrderItemDAO {

	    private final String INSERT_ORDERITEM = "INSERT INTO `orderitem`(`OrderId`,`MenuId`,`Quantity`,`TotalPrice`) VALUES (?,?,?,?)";
	    private final String UPDATE_ORDERITEM = "UPDATE `orderitem` SET `OrderId`=?, `MenuId`=?, `Quantity`=?, `TotalPrice`=? WHERE `OrderItemId` = ?";
	    private final String DELETE_ORDERITEM = "DELETE FROM `orderitem` WHERE `OrderItemId` = ?";
	    private final String GET_ORDERITEM = "SELECT * FROM `orderitem` WHERE `OrderItemId` = ?";
	    private final String GET_ALL_ORDERITEM = "SELECT * FROM `orderitem`";

	    @Override
	    public void addOrderItem(OrderItem orders) {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        try {
	          
	            con = DBconnection.getconnection();
	            pstmt = con.prepareStatement(INSERT_ORDERITEM);

	            pstmt.setInt(1, orders.getOrderId());
	            pstmt.setInt(2, orders.getMenuId());
	            pstmt.setInt(3, orders.getQuantity());
	            pstmt.setDouble(4, orders.getTotalPrice());

	            int res = pstmt.executeUpdate();

	            System.out.println("OrderItem inserted successfully. Rows affected: " + res);
	            
	            if (res == 0) {
	                System.err.println("Failed to insert OrderItem - no rows affected");
	            }
	        } catch (SQLException e) {
	            System.err.println("Error inserting OrderItem: " + e.getMessage());
	            e.printStackTrace();
	        } finally {
	            try {
	                if (pstmt != null) pstmt.close();
	                if (con != null) con.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    
	    
	    @Override
	    public void updateOrderItem(OrderItem orderItem) {
	        try {
	            Connection con = DBconnection.getconnection();
	            PreparedStatement pstmt = con.prepareStatement(UPDATE_ORDERITEM);

	            pstmt.setInt(1, orderItem.getOrderId());
	            pstmt.setInt(2, orderItem.getMenuId());
	            pstmt.setInt(3, orderItem.getQuantity());
	            pstmt.setDouble(4, orderItem.getTotalPrice());
	            pstmt.setInt(5, orderItem.getOrderItemId());

	            int res = pstmt.executeUpdate();
	            System.out.println(res);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    
	    
	    

	    @Override
	    public void deleteOrderItem(int id) {
	        try {
	            Connection con = DBconnection.getconnection();
	            PreparedStatement pstmt = con.prepareStatement(DELETE_ORDERITEM);

	            pstmt.setInt(1, id);

	            int res = pstmt.executeUpdate();
	            System.out.println(res);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    
	    

	    @Override
	    public OrderItem getOrderItem(int id) {
	        OrderItem orderItem = null;
	        try {
	            Connection con = DBconnection.getconnection();
	            PreparedStatement pstmt = con.prepareStatement(GET_ORDERITEM);
	            pstmt.setInt(1, id);

	            ResultSet res = pstmt.executeQuery();

	            if (res.next()) {
	                int orderItemId = res.getInt("OrderItemId");
	                int orderId = res.getInt("OrderId");
	                int menuId = res.getInt("MenuId");
	                int quantity = res.getInt("Quantity");
	                double totalPrice = res.getDouble("TotalPrice");

	                orderItem = new OrderItem(orderItemId, orderId, menuId, quantity, totalPrice);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return orderItem;
	    }

	    
	    
	    
	    @Override
	    public List<OrderItem> getAllOrderItem() {
	        List<OrderItem> list = new ArrayList<>();

	        try {
	            Connection con = DBconnection.getconnection();
	            PreparedStatement pstmt = con.prepareStatement(GET_ALL_ORDERITEM);
	            ResultSet res = pstmt.executeQuery();

	            while (res.next()) {
	                int orderItemId = res.getInt("OrderItemId");
	                int orderId = res.getInt("OrderId");
	                int menuId = res.getInt("MenuId");
	                int quantity = res.getInt("Quantity");
	                double totalPrice = res.getDouble("TotalPrice");

	                OrderItem orderItem = new OrderItem(orderItemId, orderId, menuId, quantity, totalPrice);
	                list.add(orderItem);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return list;
	    }



	


	


}
