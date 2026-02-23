package com.watchstore.repository;

import com.watchstore.entity.Wishlist;
import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    List<Wishlist> findByUser(User user);
    Optional<Wishlist> findByUserAndWatch(User user, Watch watch);
    boolean existsByUserAndWatch(User user, Watch watch);
    void deleteByUserAndWatch(User user, Watch watch);
}
