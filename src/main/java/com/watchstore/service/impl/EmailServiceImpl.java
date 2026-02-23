package com.watchstore.service.impl;

import com.watchstore.entity.Order;
import com.watchstore.service.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailServiceImpl.class);

    private final JavaMailSender mailSender;

    @Autowired
    public EmailServiceImpl(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @Override
    public void sendOrderConfirmation(String email, Order order) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Order Confirmation - WatchStore #" + order.getId());
            message.setText("Dear Customer,\n\n" +
                    "Your order #" + order.getId() + " has been placed successfully!\n\n" +
                    "Total Amount: ₹" + order.getTotalAmount() + "\n" +
                    "Status: " + order.getStatus() + "\n" +
                    "Shipping Address: " + order.getShippingAddress() + "\n\n" +
                    "Thank you for shopping with WatchStore!\n\n" +
                    "Best Regards,\nWatchStore Team");
            mailSender.send(message);
            log.info("Order confirmation email sent to: {}", email);
        } catch (Exception e) {
            log.error("Failed to send email to {}: {}", email, e.getMessage());
        }
    }
}
