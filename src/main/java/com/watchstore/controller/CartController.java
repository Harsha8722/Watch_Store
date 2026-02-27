package com.watchstore.controller;

import com.watchstore.entity.Cart;
import com.watchstore.entity.User;
import com.watchstore.service.CartService;
import com.watchstore.service.UserService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    private static final Logger log = LoggerFactory.getLogger(CartController.class);
    private final CartService cartService;
    private final UserService userService;

    public CartController(CartService cartService, UserService userService) {
        this.cartService = cartService;
        this.userService = userService;
    }

    @GetMapping
    public String viewCart(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = getUser(userDetails);
        List<Cart> cartItems = cartService.getCartItems(user);
        BigDecimal total = cartItems.stream()
                .map(c -> c.getWatch().getDiscountedPrice().multiply(new BigDecimal(c.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", total);
        return "user/cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam Long watchId,
                            @RequestParam(defaultValue = "1") int quantity,
                            @AuthenticationPrincipal UserDetails userDetails,
                            RedirectAttributes redirectAttributes) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = getUser(userDetails);
        cartService.addToCart(user, watchId, quantity);
        redirectAttributes.addFlashAttribute("success", "Watch added to cart!");
        return "redirect:/cart";
    }

    @PostMapping("/update/{cartId}")
    public String updateQuantity(@PathVariable Long cartId,
                                 @RequestParam int quantity,
                                 @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = getUser(userDetails);
        cartService.updateQuantity(user, cartId, quantity);
        return "redirect:/cart";
    }

    @PostMapping("/remove/{cartId}")
    public String removeFromCart(@PathVariable Long cartId,
                                 @AuthenticationPrincipal UserDetails userDetails,
                                 RedirectAttributes redirectAttributes) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = getUser(userDetails);
        cartService.removeFromCart(user, cartId);
        redirectAttributes.addFlashAttribute("success", "Item removed from cart.");
        return "redirect:/cart";
    }

    private User getUser(UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("User not found"));
    }
}
