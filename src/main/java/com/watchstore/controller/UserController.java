package com.watchstore.controller;

import com.watchstore.dto.ProfileUpdateDTO;
import com.watchstore.entity.User;
import com.watchstore.service.OrderService;
import com.watchstore.service.UserService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/user")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;
    private final OrderService orderService;

    public UserController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/profile")
    public String profile(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User user = getUser(userDetails);
        model.addAttribute("user", user);
        model.addAttribute("orders", orderService.getUserOrders(user));
        model.addAttribute("profileUpdateDTO", new ProfileUpdateDTO());
        return "user/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@Valid @ModelAttribute ProfileUpdateDTO dto,
                                BindingResult result,
                                @AuthenticationPrincipal UserDetails userDetails,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        if (result.hasErrors()) {
            User user = getUser(userDetails);
            model.addAttribute("user", user);
            return "user/profile";
        }

        try {
            User user = getUser(userDetails);
            userService.updateProfile(user.getId(), dto);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
            return "redirect:/user/profile";
        } catch (Exception e) {
            log.error("Profile update error: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/user/profile";
        }
    }

    @PostMapping("/profile/image")
    public String uploadProfileImage(@RequestParam("profileImage") MultipartFile file,
                                     @AuthenticationPrincipal UserDetails userDetails,
                                     RedirectAttributes redirectAttributes) {
        try {
            User user = getUser(userDetails);
            userService.updateProfileImage(user.getId(), file);
            redirectAttributes.addFlashAttribute("success", "Profile image updated!");
        } catch (Exception e) {
            log.error("Profile image upload error: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Failed to upload image: " + e.getMessage());
        }
        return "redirect:/user/profile";
    }

    private User getUser(UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("User not found"));
    }
}
