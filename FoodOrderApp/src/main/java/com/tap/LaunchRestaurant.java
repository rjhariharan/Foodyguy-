package com.tap;

import java.awt.List;
import java.util.Scanner;

import com.tap.daoimpl.RestaurantDAOimpl;
import com.tap.daoimpl.UserDAOimpl;
import com.tap.models.Restaurant;
import com.tap.models.User;



public class LaunchRestaurant {
	
	public static void main(String[]args) {
		
		Scanner sc = new Scanner(System.in);
		
		RestaurantDAOimpl rimpl = new RestaurantDAOimpl();
		
		//ADD_RESTAURANT

		
//		 System.out.println("Enter the name:"); String name=sc.next();
//		 System.out.println("Enter the address:"); String address=sc.next();
//		 System.out.println("Enter the phone:"); String phone=sc.next();
//		 System.out.println("Enter the rating:"); double rating=sc.nextDouble();
//		 System.out.println("Enter the cuisineType:"); String cuisineType=sc.next();
//		 System.out.println("Enter the isActive:"); boolean isActive=sc.nextBoolean();
//		 System.out.println("Enter the eta:"); int eta=sc.nextInt();
//		 System.out.println("Enter the adminid:"); int adminid=sc.nextInt();
//		 System.out.println("Enter the imagePath:"); String imagePath=sc.next();
//		 
//		 Restaurant rest = new Restaurant(name,address,phone,rating,cuisineType,isActive,eta,adminid,imagePath);
//		 
//		 rimpl.addRestaurant(rest);
//		
//		System.out.println("Enter the ID:");
//		
//		int id=sc.nextInt();
//
//		Restaurant res=rimpl.getRestaurant(id);
//
//		System.out.println(res);

		
		
		//UPDATE_RESTAURANT
		
//		System.out.println("Enter the ID:");
//		  
//		int id1=sc.nextInt();
//		  
//		Restaurant res1=rimpl.getRestaurant(id1);
//	  
//	    res1.setAddress("mico");
//	    
//		rimpl.updateRestaurant(res1);
		
		
		
		//DELETE_RESTAURANT
		
//		System.out.println("Enter the ID:");
//		int id2=sc.nextInt();
//		
//		rimpl.deleteRestaurant(id2);

		
		
		
		//GET_ALL_RESTAURANT
		
//		java.util.List<Restaurant> res4 = rimpl.getAllRestaurant();
//		
//		System.out.println(res4);

		
		
		
		
	}
	
}
