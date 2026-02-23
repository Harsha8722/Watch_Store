package com.watchstore.service;

import com.watchstore.entity.Cart;
import com.watchstore.entity.User;

import java.util.List;

public interface CartService {
    Cart addToCart(User user, Long watchId, int quantity);
    Cart updateQuantity(User user, Long cartId, int quantity);
    void removeFromCart(User user, Long cartId);
    List<Cart> getCartItems(User user);
    void clearCart(User user);
    long getCartCount(User user);
}
