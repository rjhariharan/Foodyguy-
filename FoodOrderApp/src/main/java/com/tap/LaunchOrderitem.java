package com.tap;


import java.awt.List;
import java.util.Scanner;

import com.tap.daoimpl.OrderitemDAOimpl;
import com.tap.models.OrderItem;



public class LaunchOrderitem {
	
public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		OrderitemDAOimpl oimpl=new OrderitemDAOimpl();
		
//	ADD_USER	
		
		
		  System.out.println("Enter the orderitemid:"); int orderitemid=sc.nextInt();
		  System.out.println("Enter the orderid:"); int orderid=sc.nextInt();
		  System.out.println("Enter the menuid:"); int menuid=sc.nextInt();
		  System.out.println("Enter the quantity:"); int quantity=sc.nextInt();
		  System.out.println("Enter the totalprice:"); double totalprice=sc.nextDouble();
		  
		  OrderItem o=new OrderItem(orderitemid,orderid,menuid,quantity,totalprice);
		  
		  oimpl.addOrderItem(o);
		
		
		  // GET_ORDER_ITEM
//        System.out.println("Enter the OrderItem ID:");
//        int id = sc.nextInt();
//        OrderItem item = impl.getOrderItem(id);
//        System.out.println(item);

        // UPDATE_ORDER_ITEM
//        System.out.println("Enter the OrderItem ID to update:");
//        int updateId = sc.nextInt();
//        OrderItem item = impl.getOrderItem(updateId);
//        System.out.println("Enter new quantity:");
//        int newQty = sc.nextInt();
//        item.setQuantity(newQty);
//        impl.updateOrderItem(item);

        // DELETE_ORDER_ITEM
//        System.out.println("Enter the OrderItem ID to delete:");
//        int deleteId = sc.nextInt();
//        impl.deleteOrderItem(deleteId);

        // GET_ALL_ORDER_ITEMS
//        List<OrderItem> list = impl.getAllOrderItem();
//        for (OrderItem item : list) {
//            System.out.println(item);
//        }
		
		
		
}

}
