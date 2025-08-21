package com.tap.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDAO;
import com.tap.models.Menu;
import com.tap.util.DBconnection;

public class MenuDAOimpl implements MenuDAO {

    private String INSERT_MENU = "INSERT INTO menu (restaurantid, itemname, description, price, ratings, isavailable, imagepath) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private String UPDATE_MENU = "UPDATE menu SET itemname=?, description=?, price=?, ratings=?, isavailable=?, imagepath=? WHERE menuid=?";
    private String DELETE_MENU = "DELETE FROM menu WHERE menuid=?";
    private String GET_MENU = "SELECT * FROM menu WHERE menuid=?";
    private String GET_ALL_BY_REST = "SELECT * FROM menu WHERE restaurantid=?";
    private String GET_ALL_MENU = "SELECT * FROM menu";
	private String GET_MENU_BY_ID="SELECT * FROM menu WHERE menuid = ?";


    @Override
    public void addMenu(Menu menu) {
        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement(INSERT_MENU)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRatings());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());

            int res = pstmt.executeUpdate();
            System.out.println(res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateMenu(Menu menu) {
        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement(UPDATE_MENU)) {

            pstmt.setString(1, menu.getItemName());
            pstmt.setString(2, menu.getDescription());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setDouble(4, menu.getRatings());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());
            pstmt.setInt(7, menu.getMenuId());

            int res = pstmt.executeUpdate();
            System.out.println(res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int id) {
        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_MENU)) {

            pstmt.setInt(1, id);
            int res = pstmt.executeUpdate();
            System.out.println(res);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int id) {
        Menu menu = null;
        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement(GET_MENU)) {

            pstmt.setInt(1, id);
            ResultSet res = pstmt.executeQuery();

            if (res.next()) {
                menu = mapResultSetToMenu(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }
    
    

    @Override
    public List<Menu> getAllmenubyRestaurant(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();
        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement("SELECT * FROM menu WHERE restaurantid = ?")) {

            pstmt.setInt(1, restaurantId);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                Menu menu = mapResultSetToMenu(res);
                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

   
    
    

    @Override
    public List<Menu> getAllMenu() {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBconnection.getconnection();
             PreparedStatement pstmt = con.prepareStatement(GET_ALL_MENU);
             ResultSet res = pstmt.executeQuery()) {

            while (res.next()) {
                menuList.add(mapResultSetToMenu(res));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    private Menu mapResultSetToMenu(ResultSet res) throws SQLException {
        return new Menu(
            res.getInt("menuid"),
            res.getInt("restaurantid"),
            res.getString("itemname"),
            res.getString("description"),
            res.getDouble("price"),
            res.getDouble("ratings"),
            res.getBoolean("isavailable"),
            res.getString("imagepath")
        );
    }

	@Override
	public Menu getMenuById(int menuId) {
	    Menu menu = null;
	      try (Connection con = DBconnection.getconnection();
	         PreparedStatement pstmt = con.prepareStatement(GET_MENU_BY_ID)) {
	        pstmt.setInt(1, menuId);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            menu = new Menu(
	                rs.getInt("menuid"),
	                rs.getInt("restaurantid"),
	                rs.getString("itemname"),
	                rs.getString("description"),
	                rs.getDouble("price"),
	                rs.getDouble("ratings"),
	                rs.getBoolean("isavailable"),
	                rs.getString("imagepath")
	            );
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return menu;
	}
}
