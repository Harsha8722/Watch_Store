package com.watchstore.repository;

import com.watchstore.entity.Review;
import com.watchstore.entity.Watch;
import com.watchstore.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByWatch(Watch watch);
    Optional<Review> findByUserAndWatch(User user, Watch watch);
    boolean existsByUserAndWatch(User user, Watch watch);
}
