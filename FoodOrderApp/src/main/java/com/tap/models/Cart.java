package com.tap.models;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items = new HashMap<>();

    public void addItem(CartItem item) {
        if (items.containsKey(item.getMenuid())) {
            CartItem existing = items.get(item.getMenuid());
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        } else {
            items.put(item.getMenuid(), item);
        }
    }

    public void updateItem(CartItem item) {
        if (items.containsKey(item.getMenuid())) {
            CartItem existing = items.get(item.getMenuid());
            existing.setQuantity(item.getQuantity());
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void clearCart() {
        items.clear();
    }

    public double getTotal() {
        return items.values().stream()
                .mapToDouble(i -> i.getPrice() * i.getQuantity())
                .sum();
    }
}
