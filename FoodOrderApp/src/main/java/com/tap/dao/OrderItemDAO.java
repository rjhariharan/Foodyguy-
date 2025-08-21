package com.tap.dao;

import java.util.List;

import com.tap.models.OrderItem;

public interface OrderItemDAO {

	void addOrderItem(OrderItem orders);
	void updateOrderItem(OrderItem orders);
	void deleteOrderItem(int id);
	OrderItem getOrderItem(int id);
	List<OrderItem> getAllOrderItem();
}
