package com.watchstore.service.impl;

import com.watchstore.dto.ReviewDTO;
import com.watchstore.entity.Review;
import com.watchstore.entity.User;
import com.watchstore.entity.Watch;
import com.watchstore.exception.ResourceNotFoundException;
import com.watchstore.repository.ReviewRepository;
import com.watchstore.repository.WatchRepository;
import com.watchstore.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;
    private final WatchRepository watchRepository;

    @Autowired
    public ReviewServiceImpl(ReviewRepository reviewRepository, WatchRepository watchRepository) {
        this.reviewRepository = reviewRepository;
        this.watchRepository = watchRepository;
    }

    @Override
    public Review addReview(User user, ReviewDTO dto) {
        Watch watch = watchRepository.findById(dto.getWatchId())
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found"));

        // Update existing review
        if (reviewRepository.existsByUserAndWatch(user, watch)) {
            Review existing = reviewRepository.findByUserAndWatch(user, watch).get();
            existing.setRating(dto.getRating());
            existing.setComment(dto.getComment());
            return reviewRepository.save(existing);
        }

        Review review = new Review();
        review.setUser(user);
        review.setWatch(watch);
        review.setRating(dto.getRating());
        review.setComment(dto.getComment());
        return reviewRepository.save(review);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Review> getReviewsByWatch(Long watchId) {
        Watch watch = watchRepository.findById(watchId)
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found"));
        return reviewRepository.findByWatch(watch);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean hasUserReviewed(User user, Long watchId) {
        return watchRepository.findById(watchId)
                .map(watch -> reviewRepository.existsByUserAndWatch(user, watch))
                .orElse(false);
    }
}
