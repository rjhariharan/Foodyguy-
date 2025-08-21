package com.tap.dao;

import java.util.List;

import com.tap.models.Menu;


public interface MenuDAO {

	void addMenu(Menu menu);
	void updateMenu(Menu menu);
	void deleteMenu(int id);
	Menu getMenu(int id);
	List<Menu> getAllmenubyRestaurant(int restaurantid);
	List<Menu> getAllMenu();
	Menu getMenuById(int menuId);
}
