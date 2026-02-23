package com.watchstore.controller;

import com.watchstore.entity.Watch;
import com.watchstore.service.ReviewService;
import com.watchstore.service.UserService;
import com.watchstore.service.WatchService;
import com.watchstore.service.WishlistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@Controller
@RequestMapping("/watches")
public class WatchController {

    private static final Logger log = LoggerFactory.getLogger(WatchController.class);

    private final WatchService watchService;
    private final UserService userService;
    private final ReviewService reviewService;
    private final WishlistService wishlistService;

    @Autowired
    public WatchController(WatchService watchService, UserService userService,
                           ReviewService reviewService, WishlistService wishlistService) {
        this.watchService = watchService;
        this.userService = userService;
        this.reviewService = reviewService;
        this.wishlistService = wishlistService;
    }

    @GetMapping
    public String listWatches(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(defaultValue = "id") String sortBy,
            @RequestParam(defaultValue = "ASC") String sortDir,
            Model model) {

        Sort sort = sortDir.equalsIgnoreCase("DESC")
                ? Sort.by(sortBy).descending()
                : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);

        Watch.Category watchCategory = null;
        if (category != null && !category.isBlank()) {
            try { watchCategory = Watch.Category.valueOf(category.toUpperCase()); }
            catch (Exception e) { log.warn("Invalid category: {}", category); }
        }

        Page<Watch> watches = watchService.searchAndFilter(search, watchCategory, minPrice, maxPrice, pageable);

        model.addAttribute("watches", watches);
        model.addAttribute("categories", Watch.Category.values());
        model.addAttribute("currentSearch", search);
        model.addAttribute("currentCategory", category);
        model.addAttribute("currentMinPrice", minPrice);
        model.addAttribute("currentMaxPrice", maxPrice);
        model.addAttribute("currentSortBy", sortBy);
        model.addAttribute("currentSortDir", sortDir);
        model.addAttribute("currentPage", page);

        return "user/watch-list";
    }

    @GetMapping("/{id}")
    public String watchDetail(@PathVariable Long id,
                              @AuthenticationPrincipal UserDetails userDetails,
                              Model model) {
        Watch watch = watchService.findById(id)
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("Watch not found: " + id));

        model.addAttribute("watch", watch);
        model.addAttribute("reviews", reviewService.getReviewsByWatch(id));

        if (userDetails != null) {
            userService.findByEmail(userDetails.getUsername()).ifPresent(user -> {
                model.addAttribute("isInWishlist", wishlistService.isInWishlist(user, id));
                model.addAttribute("hasReviewed", reviewService.hasUserReviewed(user, id));
            });
        }

        return "user/watch-detail";
    }
}
