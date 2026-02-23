package com.watchstore.service.impl;

import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import com.watchstore.entity.Wishlist;
import com.watchstore.exception.ResourceNotFoundException;
import com.watchstore.repository.WishlistRepository;
import com.watchstore.repository.WatchRepository;
import com.watchstore.service.WishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class WishlistServiceImpl implements WishlistService {

    private final WishlistRepository wishlistRepository;
    private final WatchRepository watchRepository;

    @Autowired
    public WishlistServiceImpl(WishlistRepository wishlistRepository, WatchRepository watchRepository) {
        this.wishlistRepository = wishlistRepository;
        this.watchRepository = watchRepository;
    }

    @Override
    public void addToWishlist(User user, Long watchId) {
        Watch watch = watchRepository.findById(watchId)
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found: " + watchId));
        if (!wishlistRepository.existsByUserAndWatch(user, watch)) {
            Wishlist wishlist = new Wishlist(user, watch);
            wishlistRepository.save(wishlist);
        }
    }

    @Override
    public void removeFromWishlist(User user, Long watchId) {
        Watch watch = watchRepository.findById(watchId)
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found: " + watchId));
        wishlistRepository.deleteByUserAndWatch(user, watch);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Wishlist> getWishlist(User user) {
        return wishlistRepository.findByUser(user);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isInWishlist(User user, Long watchId) {
        return watchRepository.findById(watchId)
                .map(watch -> wishlistRepository.existsByUserAndWatch(user, watch))
                .orElse(false);
    }
}
