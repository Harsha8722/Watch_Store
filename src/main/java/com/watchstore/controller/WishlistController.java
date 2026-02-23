package com.watchstore.controller;

import com.watchstore.entity.User;
import com.watchstore.service.UserService;
import com.watchstore.service.WishlistService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

    private static final Logger log = LoggerFactory.getLogger(WishlistController.class);
    private final WishlistService wishlistService;
    private final UserService userService;

    public WishlistController(WishlistService wishlistService, UserService userService) {
        this.wishlistService = wishlistService;
        this.userService = userService;
    }

    @GetMapping
    public String viewWishlist(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User user = getUser(userDetails);
        model.addAttribute("wishlistItems", wishlistService.getWishlist(user));
        return "user/wishlist";
    }

    @PostMapping("/add/{watchId}")
    public String addToWishlist(@PathVariable Long watchId,
                                @AuthenticationPrincipal UserDetails userDetails,
                                RedirectAttributes redirectAttributes) {
        User user = getUser(userDetails);
        wishlistService.addToWishlist(user, watchId);
        redirectAttributes.addFlashAttribute("success", "Added to wishlist!");
        return "redirect:/watches/" + watchId;
    }

    @PostMapping("/remove/{watchId}")
    public String removeFromWishlist(@PathVariable Long watchId,
                                     @AuthenticationPrincipal UserDetails userDetails,
                                     RedirectAttributes redirectAttributes) {
        User user = getUser(userDetails);
        wishlistService.removeFromWishlist(user, watchId);
        redirectAttributes.addFlashAttribute("success", "Removed from wishlist.");
        return "redirect:/wishlist";
    }

    private User getUser(UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("User not found"));
    }
}
