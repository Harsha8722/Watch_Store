package com.watchstore.service;

import com.watchstore.dto.WatchDTO;
import com.watchstore.entity.Watch;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface WatchService {
    Watch addWatch(WatchDTO dto);
    Watch updateWatch(Long id, WatchDTO dto);
    void deleteWatch(Long id);
    Optional<Watch> findById(Long id);
    Page<Watch> getAllWatches(Pageable pageable);
    Page<Watch> searchAndFilter(String search, Watch.Category category, BigDecimal minPrice, BigDecimal maxPrice, Pageable pageable);
    List<Watch> getFeaturedWatches();
    List<Watch> getWatchesByCategory(Watch.Category category);
    long getTotalWatches();
}
