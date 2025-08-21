package com.tap.dao;


import java.util.List;

import com.tap.models.Restaurant;


public interface RestaurantDAO {

		void addRestaurant(Restaurant rest );
		void updateRestaurant(Restaurant rest);
		void deleteRestaurant(int id);
		Restaurant getRestaurant(int id);
		List<Restaurant>getAllRestaurant();
		

	}


