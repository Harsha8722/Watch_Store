package com.watchstore.config;

import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import com.watchstore.repository.UserRepository;
import com.watchstore.repository.WatchRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.math.BigDecimal;
import java.util.Arrays;

@Configuration
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final WatchRepository watchRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository, WatchRepository watchRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.watchRepository = watchRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) throws Exception {
        // Initialize Admin
        if (!userRepository.existsByEmail("admin@watchstore.com")) {
            User admin = new User();
            admin.setName("Admin User");
            admin.setEmail("admin@watchstore.com");
            admin.setPassword(passwordEncoder.encode("admin123"));
            admin.setRole(User.Role.ADMIN);
            userRepository.save(admin);
        }

        // Initialize Demo User
        if (!userRepository.existsByEmail("user@watchstore.com")) {
            User user = new User();
            user.setName("John Doe");
            user.setEmail("user@watchstore.com");
            user.setPassword(passwordEncoder.encode("user123"));
            user.setRole(User.Role.USER);
            userRepository.save(user);
        }

        // Initialize Watches
        if (watchRepository.count() == 0) {
            Watch w1 = new Watch();
            w1.setBrand("Rolex");
            w1.setModel("Submariner");
            w1.setCategory(Watch.Category.LUXURY);
            w1.setPrice(new BigDecimal("750000.00"));
            w1.setDiscount(new BigDecimal("5"));
            w1.setStock(10);
            w1.setDescription("The quintessential divers' watch, the Submariner is a reference among watches of its kind.");
            w1.setImageUrl("/uploads/watch1.jpg");

            Watch w2 = new Watch();
            w2.setBrand("Omega");
            w2.setModel("Speedmaster");
            w2.setCategory(Watch.Category.LUXURY);
            w2.setPrice(new BigDecimal("550000.00"));
            w2.setDiscount(new BigDecimal("10"));
            w2.setStock(15);
            w2.setDescription("The OMEGA Speedmaster is one of OMEGA’s most iconic timepieces, having been a part of all six lunar missions.");
            w2.setImageUrl("/uploads/watch2.jpg");

            Watch w3 = new Watch();
            w3.setBrand("Seiko");
            w3.setModel("Presage Blue");
            w3.setCategory(Watch.Category.CASUAL);
            w3.setPrice(new BigDecimal("45000.00"));
            w3.setDiscount(new BigDecimal("0"));
            w3.setStock(20);
            w3.setDescription("Fine mechanical filmmaking from Japan. Rugged yet elegant for everyday wear.");
            w3.setImageUrl("/uploads/watch3.jpg");

            Watch w4 = new Watch();
            w4.setBrand("Tag Heuer");
            w4.setModel("Carrera Chronograph");
            w4.setCategory(Watch.Category.SPORTS);
            w4.setPrice(new BigDecimal("350000.00"));
            w4.setDiscount(new BigDecimal("12"));
            w4.setStock(8);
            w4.setDescription("The ultimate racing chronograph. Born on the track, built for the wrist.");
            w4.setImageUrl("https://images.unsplash.com/photo-1522337360788-8b13df772ce1?auto=format&fit=crop&q=80&w=600");

            Watch w5 = new Watch();
            w5.setBrand("Apple");
            w5.setModel("Watch Series 9");
            w5.setCategory(Watch.Category.SMARTWATCH);
            w5.setPrice(new BigDecimal("45000.00"));
            w5.setDiscount(new BigDecimal("0"));
            w5.setStock(50);
            w5.setDescription("Smater. Brighter. Mightier. The most advanced Apple Watch yet.");
            w5.setImageUrl("https://images.unsplash.com/photo-1544117518-30dd0575cfa3?auto=format&fit=crop&q=80&w=600");

            watchRepository.saveAll(Arrays.asList(w1, w2, w3, w4, w5));
        }
    }
}
