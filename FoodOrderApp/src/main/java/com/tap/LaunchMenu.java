package com.tap;

import java.util.List;
import java.util.Scanner;

import com.tap.daoimpl.MenuDAOimpl;
import com.tap.models.Menu;

public class LaunchMenu {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        MenuDAOimpl menuImpl = new MenuDAOimpl();

        // ADD MENU
//        System.out.println("Enter restaurantId:");
//        int restaurantId = sc.nextInt();
//        sc.nextLine();
//        System.out.println("Enter item name:");
//        String itemName = sc.nextLine();
//        System.out.println("Enter description:");
//        String description = sc.nextLine();
//        System.out.println("Enter price:");
//        double price = sc.nextDouble();
//        System.out.println("Enter ratings:");
//        double ratings = sc.nextDouble();
//        System.out.println("Is available (true/false):");
//        boolean isAvailable = sc.nextBoolean();
//        sc.nextLine();
//        System.out.println("Enter image path:");
//        String imagePath = sc.nextLine();
//
//        Menu menu = new Menu(0, restaurantId, itemName, description, price, ratings, isAvailable, imagePath);
//        menuImpl.addMenu(menu);

        // UPDATE MENU
//        System.out.println("Enter Menu ID to update:");
//        int menuId = sc.nextInt();
//        sc.nextLine();
//        System.out.println("Enter item name:");
//        String itemName = sc.nextLine();
//        System.out.println("Enter description:");
//        String description = sc.nextLine();
//        System.out.println("Enter price:");
//        double price = sc.nextDouble();
//        System.out.println("Enter ratings:");
//        double ratings = sc.nextDouble();
//        System.out.println("Is available (true/false):");
//        boolean isAvailable = sc.nextBoolean();
//        sc.nextLine();
//        System.out.println("Enter image path:");
//        String imagePath = sc.nextLine();
//
//        Menu menu = new Menu(menuId, 0, itemName, description, price, ratings, isAvailable, imagePath);
//        menuImpl.updateMenu(menu);

        // DELETE MENU
//        System.out.println("Enter Menu ID to delete:");
//        int id = sc.nextInt();
//        menuImpl.deleteMenu(id);

        // GET MENU BY ID
//        System.out.println("Enter Menu ID to view:");
//        int id = sc.nextInt();
//        Menu result = menuImpl.getUser(id);
//        if (result != null) {
//            System.out.println(result);
//        } else {
//            System.out.println("No menu found.");
//        }

        // GET ALL MENU BY RESTAURANT
//        System.out.println("Enter Restaurant ID to fetch menu items:");
//        int restId = sc.nextInt();
//        List<Menu> menuList = menuImpl.getAllmenubyRestaurant(restId);
//        for (Menu m : menuList) {
//            System.out.println(m);
//        }

        // GET ALL MENUS
//        List<Menu> allMenus = menuImpl.getAllMenu();
//        for (Menu m : allMenus) {
//            System.out.println(m);
//        }

        
    }
}
