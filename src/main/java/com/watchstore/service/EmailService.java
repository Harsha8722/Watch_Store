package com.watchstore.service;

import com.watchstore.entity.Order;

public interface EmailService {
    void sendOrderConfirmation(String email, Order order);
}
