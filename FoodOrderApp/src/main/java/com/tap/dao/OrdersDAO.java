package com.tap.dao;

import java.util.List;

import com.tap.models.Orders;

public interface OrdersDAO {
	public int addOrders(Orders orders);
	public void updateOrders(Orders orders);
	public void deleteOrders(int id) ;
	public Orders getOrders(int id) ;
	public List<Orders> getAllOrders();
	public int getLastInsertedOrderId();
	

}
