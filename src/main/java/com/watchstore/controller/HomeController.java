package com.watchstore.controller;

import com.watchstore.entity.Watch;
import com.watchstore.service.WatchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private static final Logger log = LoggerFactory.getLogger(HomeController.class);

    private final WatchService watchService;

    @Autowired
    public HomeController(WatchService watchService) {
        this.watchService = watchService;
    }

    @GetMapping("/")
    public String home(Model model) {
        log.debug("Loading home page");
        model.addAttribute("featuredWatches", watchService.getFeaturedWatches());
        model.addAttribute("luxuryWatches", watchService.getWatchesByCategory(Watch.Category.LUXURY));
        model.addAttribute("sportsWatches", watchService.getWatchesByCategory(Watch.Category.SPORTS));
        model.addAttribute("categories", Watch.Category.values());
        return "home";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "error/access-denied";
    }
}
