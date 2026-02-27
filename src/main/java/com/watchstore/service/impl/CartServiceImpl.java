package com.watchstore.service.impl;

import com.watchstore.entity.Cart;
import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import com.watchstore.exception.ResourceNotFoundException;
import com.watchstore.repository.CartRepository;
import com.watchstore.repository.WatchRepository;
import com.watchstore.service.CartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    private static final Logger log = LoggerFactory.getLogger(CartServiceImpl.class);

    private final CartRepository cartRepository;
    private final WatchRepository watchRepository;

    @Autowired
    public CartServiceImpl(CartRepository cartRepository, WatchRepository watchRepository) {
        this.cartRepository = cartRepository;
        this.watchRepository = watchRepository;
    }

    @Override
    public Cart addToCart(User user, Long watchId, int quantity) {
        log.info("Adding watch {} to cart for user {}", watchId, user.getId());
        Watch watch = watchRepository.findById(watchId)
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found: " + watchId));

        Optional<Cart> existingCart = cartRepository.findFirstByUserAndWatch(user, watch);
        if (existingCart.isPresent()) {
            Cart cart = existingCart.get();
            cart.setQuantity(cart.getQuantity() + quantity);
            return cartRepository.save(cart);
        }

        Cart cart = new Cart(user, watch, quantity);
        return cartRepository.save(cart);
    }

    @Override
    public Cart updateQuantity(User user, Long cartId, int quantity) {
        log.info("Updating cart item {} quantity to {}", cartId, quantity);
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));
        if (!cart.getUser().getId().equals(user.getId())) {
            throw new IllegalArgumentException("Unauthorized access to cart item");
        }
        if (quantity <= 0) {
            cartRepository.delete(cart);
            return null;
        }
        cart.setQuantity(quantity);
        return cartRepository.save(cart);
    }

    @Override
    public void removeFromCart(User user, Long cartId) {
        log.info("Removing cart item {} for user {}", cartId, user.getId());
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));
        if (!cart.getUser().getId().equals(user.getId())) {
            throw new IllegalArgumentException("Unauthorized access to cart item");
        }
        cartRepository.delete(cart);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Cart> getCartItems(User user) {
        return cartRepository.findByUser(user);
    }

    @Override
    public void clearCart(User user) {
        cartRepository.deleteByUser(user);
    }

    @Override
    @Transactional(readOnly = true)
    public long getCartCount(User user) {
        return cartRepository.countByUser(user);
    }
}
