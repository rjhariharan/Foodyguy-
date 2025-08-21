package com.tap;

import java.sql.Date;
import java.util.List;
import java.util.Scanner;

import com.tap.daoimpl.OrdersDAOimpl;
import com.tap.models.Orders;

public class LaunchOrders {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        OrdersDAOimpl oimpl = new OrdersDAOimpl();

        // ADD_ORDERS

//        System.out.println("Enter the user ID:");
//        int userid = sc.nextInt();
//        System.out.println("Enter the restaurant ID:");
//        int restid = sc.nextInt();
//        Date orderdate = new java.sql.Date(System.currentTimeMillis());
//        System.out.println("Enter the total amount:");
//        double totalamount = sc.nextDouble();
//        System.out.println("Enter the order status:");
//        String status = sc.next();
//        System.out.println("Enter the payment method:");
//        String paymentmode = sc.next();
//
//        Orders newOrder = new Orders(userid, restid, orderdate, totalamount, status, paymentmode);
//        oimpl.addOrders(newOrder);


        // GET_ORDERS

//        System.out.println("Enter the order ID to retrieve:");
//        int orderId = sc.nextInt();
//        Orders order = oimpl.getOrders(orderId);
//        System.out.println(order);


        // UPDATE_ORDERS

//        System.out.println("Enter the order ID to update:");
//        int updateId = sc.nextInt();
//        Orders orderToUpdate = oimpl.getOrders(updateId);
//        if (orderToUpdate != null) {
//            System.out.println("Enter new status:");
//            String newStatus = sc.next();
//            System.out.println("Enter new payment mode:");
//            String newPayment = sc.next();
//
//            orderToUpdate.setStatus(newStatus);
//            orderToUpdate.setPaymentMode(newPayment);
//
//            oimpl.updateOrders(orderToUpdate);
//        } else {
//            System.out.println("Order not found.");
//        }


        // DELETE_ORDERS

//        System.out.println("Enter the order ID to delete:");
//        int deleteId = sc.nextInt();
//        oimpl.deleteOrders(deleteId);


        // GET_ALL_ORDERS

//        List<Orders> ordersList = oimpl.getAllOrders();
//        for (Orders o : ordersList) {
//            System.out.println(o);
//        }

    }
}
