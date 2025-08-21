package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.models.User;
import com.tap.dao.UserDAO;
import com.tap.util.DBconnection;


public class UserDAOimpl implements UserDAO{


	private String INSERT_USER = "INSERT into `user`(`Name`,`Username`,`Password`,`Email`,`Phone`,`Address`,`Role`,`CreatedDate`,`LastLoginDate`) values (?,?,?,?,?,?,?,?,?)";
	private String GET_USER = "SELECT * FROM `user` WHERE `UserId` = ?";
	private String UPDATE_USER ="UPDATE `user` SET `Name`=?,`Username`=?,`Password`=?,`Email`=?,`Phone`=?,`Address`=? WHERE `UserId` = ?";
	private String GET_ALL_USERS="SELECT * FROM `user`";
	private String DELETE_USER="DELETE FROM `user` where `UserId` = ?";
	

	@Override
	public void addUser(User user) {
		try {
			
			Connection con = DBconnection.getconnection();
			
			PreparedStatement pstmt = con.prepareStatement(INSERT_USER);
			
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());
			pstmt.setString(7, user.getRole());
			pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
			
		} 
		catch(SQLException a) {
			a.printStackTrace();
		}
		
	}

	
	
	
	@Override
	public void updateUser(User user) {
try {
			
			Connection con = DBconnection.getconnection();
			
			PreparedStatement pstmt = con.prepareStatement(UPDATE_USER);
			
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPhone());
			pstmt.setString(6, user.getAddress());
			pstmt.setInt(7, user.getUserId());

			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
			
		} 
		catch(SQLException a) {
			a.printStackTrace();
		}
		
	}
	
	
	
	

	@Override
	public void deleteUser(int id) {
		
		Connection con = DBconnection.getconnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_USER);
			
			pstmt.setInt(1, id);
			
			int res = pstmt.executeUpdate();
			
			System.out.println(res);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	

	@Override
	public User getUser(int id) {
		Connection con = DBconnection.getconnection();
		User user= new User();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_USER);
			
			pstmt.setInt(1, id);
			
			ResultSet res = pstmt.executeQuery();
			
			
			while(res.next()) {
				
				int id1 =res.getInt(1);
				String name=res.getString(2);
				String username=res.getString(3);
				String password=res.getString(4);
				String email=res.getString(5);
				String phone=res.getString(6);
				String address=res.getString(7);
				String role=res.getString(8);
				Timestamp crdate=res.getTimestamp(9);
				Timestamp lastdate=res.getTimestamp(10);
				
				user= new User(id1,name,username,password,email,phone,address,role,crdate,lastdate);
				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return user;
	}

	
	
	
	
	
	
	@Override
	public List<User> getAllUsers() {


		Connection con = DBconnection.getconnection();
		
		ArrayList<User> list = new ArrayList<User>();
		
		User user ;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_ALL_USERS);
			
			ResultSet res = pstmt.executeQuery();
			
			while(res.next()) {
				
				int id1 =res.getInt(1);
				String name=res.getString(2);
				String username=res.getString(3);
				String password=res.getString(4);
				String email=res.getString(5);
				String phone=res.getString(6);
				String address=res.getString(7);
				String role=res.getString(8);
				Timestamp crdate=res.getTimestamp(9);
				Timestamp lastdate=res.getTimestamp(10);
				
				user= new User(id1,name,username,password,email,phone,address,role,crdate,lastdate);
				
				list.add(user);
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	
}
