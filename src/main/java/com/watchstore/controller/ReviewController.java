package com.watchstore.controller;

import com.watchstore.dto.ReviewDTO;
import com.watchstore.entity.User;
import com.watchstore.service.ReviewService;
import com.watchstore.service.UserService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    private static final Logger log = LoggerFactory.getLogger(ReviewController.class);
    private final ReviewService reviewService;
    private final UserService userService;

    public ReviewController(ReviewService reviewService, UserService userService) {
        this.reviewService = reviewService;
        this.userService = userService;
    }

    @PostMapping("/add")
    public String addReview(@Valid @ModelAttribute ReviewDTO dto,
                            BindingResult result,
                            @AuthenticationPrincipal UserDetails userDetails,
                            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Invalid review data.");
            return "redirect:/watches/" + dto.getWatchId();
        }
        try {
            User user = getUser(userDetails);
            reviewService.addReview(user, dto);
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully!");
        } catch (Exception e) {
            log.error("Error adding review: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/watches/" + dto.getWatchId();
    }

    private User getUser(UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("User not found"));
    }
}
