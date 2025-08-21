package com.tap.dao;

import java.util.List;

import com.tap.models.User;

public interface UserDAO {
	
	void addUser(User user);
	void updateUser(User user);
	void deleteUser(int id);
	User getUser(int id);
	List<User> getAllUsers();
	

}
