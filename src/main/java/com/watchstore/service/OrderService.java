package com.watchstore.service;

import com.watchstore.dto.CheckoutDTO;
import com.watchstore.entity.Order;
import com.watchstore.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface OrderService {
    Order placeOrder(User user, CheckoutDTO dto);
    List<Order> getUserOrders(User user);
    Optional<Order> findById(Long id);
    Page<Order> getAllOrders(Pageable pageable);
    Order updateStatus(Long orderId, Order.OrderStatus status);
    BigDecimal getTotalRevenue();
    long getTotalOrders();
    Map<Integer, BigDecimal> getMonthlyRevenue(int year);
}
