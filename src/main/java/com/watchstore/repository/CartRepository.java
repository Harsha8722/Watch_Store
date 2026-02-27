package com.watchstore.repository;

import com.watchstore.entity.Cart;
import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    List<Cart> findByUser(User user);
    Optional<Cart> findFirstByUserAndWatch(User user, Watch watch);
    void deleteByUser(User user);
    long countByUser(User user);
}
