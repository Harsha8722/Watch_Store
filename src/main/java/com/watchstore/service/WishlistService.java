package com.watchstore.service;

import com.watchstore.entity.User;
import com.watchstore.entity.Wishlist;

import java.util.List;

public interface WishlistService {
    void addToWishlist(User user, Long watchId);
    void removeFromWishlist(User user, Long watchId);
    List<Wishlist> getWishlist(User user);
    boolean isInWishlist(User user, Long watchId);
}
