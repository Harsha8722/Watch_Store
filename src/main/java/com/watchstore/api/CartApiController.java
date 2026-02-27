package com.watchstore.api;

import com.watchstore.entity.User;
import com.watchstore.service.CartService;
import com.watchstore.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
public class CartApiController {

    private final CartService cartService;
    private final UserService userService;

    public CartApiController(CartService cartService, UserService userService) {
        this.cartService = cartService;
        this.userService = userService;
    }

    @GetMapping("/count")
    public ResponseEntity<Integer> getCartCount(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return ResponseEntity.ok(0);
        }
        return userService.findByEmail(userDetails.getUsername())
                .map(user -> ResponseEntity.ok(cartService.getCartItems(user).size()))
                .orElse(ResponseEntity.ok(0));
    }
}
