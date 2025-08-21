package com.tap.models;

public class CartItem {
	
	private int menuid;
	private int restaurantid;
	private String name;
	private int quantity;
	private double price;
	
	
	public CartItem(){
		
	}


	public CartItem(int menuid, int restaurantid, String name, int quantity, double price) {
		super();
		this.menuid = menuid;
		this.restaurantid = restaurantid;
		this.name = name;
		this.quantity = quantity;
		this.price = price;
	}


	public int getMenuid() {
		return menuid;
	}


	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}


	public int getRestaurantid() {
		return restaurantid;
	}


	public void setRestaurantid(int restaurantid) {
		this.restaurantid = restaurantid;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "CartItem [menuid=" + menuid + ", restaurantid=" + restaurantid + ", name=" + name + ", quantity="
				+ quantity + ", price=" + price + "]";
	}
	
	
	
	
}
