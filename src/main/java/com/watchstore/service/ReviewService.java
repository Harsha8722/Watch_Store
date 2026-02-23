package com.watchstore.service;

import com.watchstore.dto.ReviewDTO;
import com.watchstore.entity.Review;
import com.watchstore.entity.User;

import java.util.List;

public interface ReviewService {
    Review addReview(User user, ReviewDTO dto);
    List<Review> getReviewsByWatch(Long watchId);
    boolean hasUserReviewed(User user, Long watchId);
}
