package com.watchstore.service.impl;

import com.watchstore.dto.CheckoutDTO;
import com.watchstore.entity.*;
import com.watchstore.exception.ResourceNotFoundException;
import com.watchstore.repository.CartRepository;
import com.watchstore.repository.OrderRepository;
import com.watchstore.repository.WatchRepository;
import com.watchstore.service.EmailService;
import com.watchstore.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    private static final Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;
    private final WatchRepository watchRepository;
    private final EmailService emailService;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository, CartRepository cartRepository,
                            WatchRepository watchRepository, EmailService emailService) {
        this.orderRepository = orderRepository;
        this.cartRepository = cartRepository;
        this.watchRepository = watchRepository;
        this.emailService = emailService;
    }

    @Override
    public Order placeOrder(User user, CheckoutDTO dto) {
        log.info("Placing order for user: {}", user.getId());
        List<Cart> cartItems = cartRepository.findByUser(user);
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }

        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;

        for (Cart cartItem : cartItems) {
            Watch watch = cartItem.getWatch();
            if (watch.getStock() < cartItem.getQuantity()) {
                throw new IllegalStateException("Insufficient stock for: " + watch.getBrand() + " " + watch.getModel());
            }

            BigDecimal itemPrice = watch.getDiscountedPrice();
            OrderItem orderItem = new OrderItem();
            orderItem.setWatch(watch);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(itemPrice);
            orderItems.add(orderItem);
            totalAmount = totalAmount.add(itemPrice.multiply(new BigDecimal(cartItem.getQuantity())));

            // Decrement stock
            watch.setStock(watch.getStock() - cartItem.getQuantity());
            watchRepository.save(watch);
        }

        String shippingAddress = dto.getFullName() + ", " + dto.getAddress() + ", " +
                dto.getCity() + ", " + dto.getState() + " - " + dto.getPostalCode() + ". Ph: " + dto.getPhone();

        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(totalAmount);
        order.setStatus(Order.OrderStatus.PENDING);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(dto.getPaymentMethod());

        for (OrderItem item : orderItems) {
            item.setOrder(order);
        }
        order.setOrderItems(orderItems);

        Order saved = orderRepository.save(order);

        // Clear cart
        cartRepository.deleteByUser(user);

        // Send email notification
        try {
            emailService.sendOrderConfirmation(user.getEmail(), saved);
        } catch (Exception e) {
            log.warn("Failed to send order confirmation email: {}", e.getMessage());
        }

        log.info("Order placed successfully: {}", saved.getId());
        return saved;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Order> getUserOrders(User user) {
        return orderRepository.findByUserOrderByOrderDateDesc(user);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Order> getAllOrders(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }

    @Override
    public Order updateStatus(Long orderId, Order.OrderStatus status) {
        log.info("Updating order {} status to {}", orderId, status);
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found: " + orderId));
        order.setStatus(status);
        return orderRepository.save(order);
    }

    @Override
    @Transactional(readOnly = true)
    public BigDecimal getTotalRevenue() {
        return orderRepository.getTotalRevenue();
    }

    @Override
    @Transactional(readOnly = true)
    public long getTotalOrders() {
        return orderRepository.count();
    }

    @Override
    @Transactional(readOnly = true)
    public Map<Integer, BigDecimal> getMonthlyRevenue(int year) {
        List<Object[]> results = orderRepository.getMonthlyRevenue(year);
        Map<Integer, BigDecimal> monthlyRevenue = new LinkedHashMap<>();
        for (int i = 1; i <= 12; i++) {
            monthlyRevenue.put(i, BigDecimal.ZERO);
        }
        for (Object[] row : results) {
            Integer month = ((Number) row[0]).intValue();
            BigDecimal revenue = (BigDecimal) row[1];
            monthlyRevenue.put(month, revenue);
        }
        return monthlyRevenue;
    }
}
