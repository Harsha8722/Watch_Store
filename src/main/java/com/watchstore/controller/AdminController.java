package com.watchstore.controller;

import com.watchstore.dto.WatchDTO;
import com.watchstore.entity.Order;
import com.watchstore.entity.Watch;
import com.watchstore.service.OrderService;
import com.watchstore.service.UserService;
import com.watchstore.service.WatchService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final WatchService watchService;
    private final OrderService orderService;
    private final UserService userService;

    public AdminController(WatchService watchService, OrderService orderService, UserService userService) {
        this.watchService = watchService;
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalProducts", watchService.getTotalWatches());
        model.addAttribute("totalOrders", orderService.getTotalOrders());
        model.addAttribute("totalUsers", userService.getTotalUsers());
        model.addAttribute("totalRevenue", orderService.getTotalRevenue());
        return "admin/dashboard";
    }

    @GetMapping("/products")
    public String products(@RequestParam(defaultValue = "") String search,
                          @RequestParam(required = false) String category,
                          @RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "10") int size,
                          Model model) {
        
        Watch.Category watchCategory = null;
        if (category != null && !category.isEmpty()) {
            try {
                watchCategory = Watch.Category.valueOf(category.toUpperCase());
            } catch (IllegalArgumentException ignored) {}
        }

        Page<Watch> products = watchService.searchAndFilter(search, watchCategory, null, null, PageRequest.of(page, size, Sort.by("id").descending()));
        
        model.addAttribute("products", products);
        model.addAttribute("currentSearch", search);
        model.addAttribute("currentCategory", category);
        model.addAttribute("categories", Watch.Category.values());
        model.addAttribute("watchDTO", new WatchDTO());
        return "admin/products";
    }

    @PostMapping("/products/save")
    public String saveProduct(@Valid @ModelAttribute("watchDTO") WatchDTO watchDTO,
                             BindingResult result,
                             RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Please check your input.");
            return "redirect:/admin/products?action=add";
        }

        try {
            if (watchDTO.getId() != null) {
                watchService.updateWatch(watchDTO.getId(), watchDTO);
                redirectAttributes.addFlashAttribute("success", "Product updated successfully!");
            } else {
                watchService.addWatch(watchDTO);
                redirectAttributes.addFlashAttribute("success", "Product added successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error saving product: " + e.getMessage());
        }

        return "redirect:/admin/products";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            watchService.deleteWatch(id);
            redirectAttributes.addFlashAttribute("success", "Product deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting product: " + e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/orders")
    public String orders(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size,
                        Model model) {
        Page<Order> orders = orderService.getAllOrders(PageRequest.of(page, size, Sort.by("id").descending()));
        model.addAttribute("orders", orders);
        return "admin/orders";
    }

    @PostMapping("/orders/{id}/status")
    public String updateOrderStatus(@PathVariable Long id, @RequestParam Order.OrderStatus status, RedirectAttributes redirectAttributes) {
        try {
            orderService.updateStatus(id, status);
            redirectAttributes.addFlashAttribute("success", "Order status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating status: " + e.getMessage());
        }
        return "redirect:/admin/orders";
    }

    @GetMapping("/users")
    public String users(@RequestParam(defaultValue = "") String search,
                       @RequestParam(defaultValue = "0") int page,
                       @RequestParam(defaultValue = "10") int size,
                       Model model) {
        model.addAttribute("users", userService.getAllUsers(search, PageRequest.of(page, size)));
        model.addAttribute("currentSearch", search);
        return "admin/users";
    }

    @PostMapping("/users/{id}/toggle")
    public String toggleUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.toggleUserEnabled(id);
            redirectAttributes.addFlashAttribute("success", "User status toggled!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error toggling user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
