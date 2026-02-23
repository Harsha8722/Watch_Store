package com.watchstore.controller.admin;

import com.watchstore.dto.WatchDTO;
import com.watchstore.entity.*;
import com.watchstore.service.*;
import jakarta.validation.Valid;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private static final Logger log = LoggerFactory.getLogger(AdminController.class);
    private final UserService userService;
    private final WatchService watchService;
    private final OrderService orderService;

    public AdminController(UserService userService, WatchService watchService, OrderService orderService) {
        this.userService = userService;
        this.watchService = watchService;
        this.orderService = orderService;
    }

    // =========================
    // Dashboard
    // =========================
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalUsers", userService.getTotalUsers());
        model.addAttribute("totalProducts", watchService.getTotalWatches());
        model.addAttribute("totalOrders", orderService.getTotalOrders());
        model.addAttribute("totalRevenue", orderService.getTotalRevenue());
        model.addAttribute("monthlyRevenue", orderService.getMonthlyRevenue(LocalDate.now().getYear()));
        model.addAttribute("recentOrders", orderService.getAllOrders(PageRequest.of(0, 5)).getContent());
        return "admin/dashboard";
    }

    // =========================
    // Products Management
    // =========================
    @GetMapping("/products")
    public String products(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id") String sortBy,
            @RequestParam(defaultValue = "DESC") String sortDir,
            Model model) {
        Sort sort = sortDir.equalsIgnoreCase("ASC") ? Sort.by(sortBy).ascending() : Sort.by(sortBy).descending();
        Page<Watch> watches = watchService.getAllWatches(PageRequest.of(page, size, sort));
        model.addAttribute("watches", watches);
        model.addAttribute("watchDTO", new WatchDTO());
        model.addAttribute("categories", Watch.Category.values());
        model.addAttribute("currentPage", page);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);
        return "admin/products";
    }

    @PostMapping("/products/add")
    public String addProduct(@Valid @ModelAttribute WatchDTO dto,
                             BindingResult result,
                             RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Validation error: " + result.getAllErrors().get(0).getDefaultMessage());
            return "redirect:/admin/products";
        }
        try {
            watchService.addWatch(dto);
            redirectAttributes.addFlashAttribute("success", "Watch added successfully!");
        } catch (Exception e) {
            log.error("Error adding product: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @GetMapping("/products/edit/{id}")
    public String editProductForm(@PathVariable Long id, Model model) {
        Watch watch = watchService.findById(id)
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("Watch not found"));
        WatchDTO dto = new WatchDTO();
        dto.setId(watch.getId());
        dto.setBrand(watch.getBrand());
        dto.setModel(watch.getModel());
        dto.setPrice(watch.getPrice());
        dto.setDiscount(watch.getDiscount());
        dto.setCategory(watch.getCategory());
        dto.setStock(watch.getStock());
        dto.setDescription(watch.getDescription());
        dto.setImageUrl(watch.getImageUrl());
        model.addAttribute("watchDTO", dto);
        model.addAttribute("categories", Watch.Category.values());
        return "admin/edit-product";
    }

    @PostMapping("/products/edit/{id}")
    public String updateProduct(@PathVariable Long id,
                                @Valid @ModelAttribute WatchDTO dto,
                                BindingResult result,
                                RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Validation error");
            return "redirect:/admin/products/edit/" + id;
        }
        try {
            watchService.updateWatch(id, dto);
            redirectAttributes.addFlashAttribute("success", "Watch updated successfully!");
        } catch (Exception e) {
            log.error("Error updating product: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/products";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            watchService.deleteWatch(id);
            redirectAttributes.addFlashAttribute("success", "Watch deleted successfully!");
        } catch (Exception e) {
            log.error("Error deleting product: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/products";
    }

    // =========================
    // Users Management
    // =========================
    @GetMapping("/users")
    public String users(@RequestParam(defaultValue = "0") int page,
                        @RequestParam(defaultValue = "10") int size,
                        @RequestParam(defaultValue = "") String search,
                        Model model) {
        Page<User> users = userService.getAllUsers(search, PageRequest.of(page, size));
        model.addAttribute("users", users);
        model.addAttribute("search", search);
        model.addAttribute("currentPage", page);
        return "admin/users";
    }

    @PostMapping("/users/toggle/{id}")
    public String toggleUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        userService.toggleUserEnabled(id);
        redirectAttributes.addFlashAttribute("success", "User status updated.");
        return "redirect:/admin/users";
    }

    // =========================
    // Orders Management
    // =========================
    @GetMapping("/orders")
    public String orders(@RequestParam(defaultValue = "0") int page,
                         @RequestParam(defaultValue = "10") int size,
                         Model model) {
        Page<Order> orders = orderService.getAllOrders(PageRequest.of(page, size, Sort.by("orderDate").descending()));
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("orderStatuses", Order.OrderStatus.values());
        return "admin/orders";
    }

    @PostMapping("/orders/status/{id}")
    public String updateOrderStatus(@PathVariable Long id,
                                    @RequestParam Order.OrderStatus status,
                                    RedirectAttributes redirectAttributes) {
        orderService.updateStatus(id, status);
        redirectAttributes.addFlashAttribute("success", "Order status updated to " + status);
        return "redirect:/admin/orders";
    }
}
