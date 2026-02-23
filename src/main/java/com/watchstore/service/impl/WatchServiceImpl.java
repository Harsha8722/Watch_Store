package com.watchstore.service.impl;

import com.watchstore.dto.WatchDTO;
import com.watchstore.entity.Watch;
import com.watchstore.exception.ResourceNotFoundException;
import com.watchstore.repository.WatchRepository;
import com.watchstore.service.WatchService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class WatchServiceImpl implements WatchService {

    private static final Logger log = LoggerFactory.getLogger(WatchServiceImpl.class);
    private static final String UPLOAD_DIR = "d:/Watches/uploads/";

    private final WatchRepository watchRepository;

    @Autowired
    public WatchServiceImpl(WatchRepository watchRepository) {
        this.watchRepository = watchRepository;
    }

    @Override
    public Watch addWatch(WatchDTO dto) {
        log.info("Adding new watch: {} {}", dto.getBrand(), dto.getModel());
        Watch watch = new Watch();
        watch.setBrand(dto.getBrand());
        watch.setModel(dto.getModel());
        watch.setPrice(dto.getPrice());
        watch.setDiscount(dto.getDiscount() != null ? dto.getDiscount() : BigDecimal.ZERO);
        watch.setCategory(dto.getCategory());
        watch.setStock(dto.getStock());
        watch.setDescription(dto.getDescription());

        if (dto.getImageFile() != null && !dto.getImageFile().isEmpty()) {
            watch.setImageUrl(saveImage(dto.getImageFile()));
        } else if (dto.getImageUrl() != null) {
            watch.setImageUrl(dto.getImageUrl());
        }

        return watchRepository.save(watch);
    }

    @Override
    public Watch updateWatch(Long id, WatchDTO dto) {
        log.info("Updating watch: {}", id);
        Watch watch = watchRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Watch not found with id: " + id));

        watch.setBrand(dto.getBrand());
        watch.setModel(dto.getModel());
        watch.setPrice(dto.getPrice());
        watch.setDiscount(dto.getDiscount() != null ? dto.getDiscount() : BigDecimal.ZERO);
        watch.setCategory(dto.getCategory());
        watch.setStock(dto.getStock());
        watch.setDescription(dto.getDescription());

        if (dto.getImageFile() != null && !dto.getImageFile().isEmpty()) {
            watch.setImageUrl(saveImage(dto.getImageFile()));
        } else if (dto.getImageUrl() != null && !dto.getImageUrl().isBlank()) {
            watch.setImageUrl(dto.getImageUrl());
        }

        return watchRepository.save(watch);
    }

    @Override
    public void deleteWatch(Long id) {
        log.info("Deleting watch: {}", id);
        if (!watchRepository.existsById(id)) {
            throw new ResourceNotFoundException("Watch not found with id: " + id);
        }
        watchRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Watch> findById(Long id) {
        return watchRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Watch> getAllWatches(Pageable pageable) {
        return watchRepository.findAll(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Watch> searchAndFilter(String search, Watch.Category category, BigDecimal minPrice, BigDecimal maxPrice, Pageable pageable) {
        return watchRepository.findByFilters(
                (search != null && !search.isBlank()) ? search : null,
                category,
                minPrice,
                maxPrice,
                pageable
        );
    }

    @Override
    @Transactional(readOnly = true)
    public List<Watch> getFeaturedWatches() {
        return watchRepository.findTop8ByOrderByCreatedAtDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Watch> getWatchesByCategory(Watch.Category category) {
        return watchRepository.findTop4ByCategory(category);
    }

    @Override
    @Transactional(readOnly = true)
    public long getTotalWatches() {
        return watchRepository.count();
    }

    private String saveImage(MultipartFile file) {
        try {
            String filename = "watch_" + UUID.randomUUID() + getExtension(file.getOriginalFilename());
            Path uploadPath = Paths.get(UPLOAD_DIR + "watches/");
            Files.createDirectories(uploadPath);
            Path filePath = uploadPath.resolve(filename);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            return "/uploads/watches/" + filename;
        } catch (IOException e) {
            log.error("Error saving watch image: {}", e.getMessage());
            throw new RuntimeException("Failed to save image", e);
        }
    }

    private String getExtension(String filename) {
        if (filename == null) return ".jpg";
        int lastDot = filename.lastIndexOf('.');
        return lastDot >= 0 ? filename.substring(lastDot) : ".jpg";
    }
}
