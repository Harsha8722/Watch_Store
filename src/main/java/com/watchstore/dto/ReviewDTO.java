package com.watchstore.dto;

import jakarta.validation.constraints.*;

public class ReviewDTO {

    @NotNull(message = "Watch ID is required")
    private Long watchId;

    @NotNull(message = "Rating is required")
    @Min(value = 1, message = "Rating must be at least 1")
    @Max(value = 5, message = "Rating must be at most 5")
    private Integer rating;

    @Size(max = 1000, message = "Comment cannot exceed 1000 characters")
    private String comment;

    public ReviewDTO() {}

    public Long getWatchId() { return watchId; }
    public void setWatchId(Long watchId) { this.watchId = watchId; }
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
}
