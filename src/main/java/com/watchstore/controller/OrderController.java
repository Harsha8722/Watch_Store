package com.watchstore.controller;

import com.watchstore.dto.CheckoutDTO;
import com.watchstore.entity.*;
import com.watchstore.service.CartService;
import com.watchstore.service.OrderService;
import com.watchstore.service.UserService;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);
    private final OrderService orderService;
    private final CartService cartService;
    private final UserService userService;

    public OrderController(OrderService orderService, CartService cartService, UserService userService) {
        this.orderService = orderService;
        this.cartService = cartService;
        this.userService = userService;
    }

    @GetMapping("/checkout")
    public String checkoutPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User user = getUser(userDetails);
        List<Cart> cartItems = cartService.getCartItems(user);
        if (cartItems.isEmpty()) return "redirect:/cart";

        BigDecimal total = cartItems.stream()
                .map(c -> c.getWatch().getDiscountedPrice().multiply(new BigDecimal(c.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", total);
        model.addAttribute("checkoutDTO", new CheckoutDTO());
        return "user/checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@Valid @ModelAttribute CheckoutDTO dto,
                             BindingResult result,
                             @AuthenticationPrincipal UserDetails userDetails,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            User user = getUser(userDetails);
            List<Cart> cartItems = cartService.getCartItems(user);
            BigDecimal total = cartItems.stream()
                    .map(c -> c.getWatch().getDiscountedPrice().multiply(new BigDecimal(c.getQuantity())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("cartTotal", total);
            return "user/checkout";
        }

        try {
            User user = getUser(userDetails);
            Order order = orderService.placeOrder(user, dto);
            return "redirect:/orders/success/" + order.getId();
        } catch (Exception e) {
            log.error("Order placement error: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/checkout";
        }
    }

    @GetMapping("/orders/success/{orderId}")
    public String orderSuccess(@PathVariable Long orderId, Model model) {
        Order order = orderService.findById(orderId)
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("Order not found"));
        model.addAttribute("order", order);
        return "user/order-success";
    }

    @GetMapping("/orders")
    public String orderHistory(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User user = getUser(userDetails);
        model.addAttribute("orders", orderService.getUserOrders(user));
        return "user/order-history";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable Long id,
                              @AuthenticationPrincipal UserDetails userDetails,
                              Model model) {
        Order order = orderService.findById(id)
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("Order not found"));
        User user = getUser(userDetails);
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/orders";
        }
        model.addAttribute("order", order);
        return "user/order-detail";
    }

    private User getUser(UserDetails userDetails) {
        return userService.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new com.watchstore.exception.ResourceNotFoundException("User not found"));
    }
}
