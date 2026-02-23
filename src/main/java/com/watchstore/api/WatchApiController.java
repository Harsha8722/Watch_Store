package com.watchstore.api;

import com.watchstore.entity.Watch;
import com.watchstore.service.WatchService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.data.domain.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Optional;

@RestController
@RequestMapping("/api/watches")
@Tag(name = "Watch API", description = "REST API for watches")
public class WatchApiController {

    private final WatchService watchService;

    public WatchApiController(WatchService watchService) {
        this.watchService = watchService;
    }

    @GetMapping
    @Operation(summary = "Get all watches with filters")
    public ResponseEntity<Page<Watch>> getWatches(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(defaultValue = "id") String sortBy) {

        Watch.Category watchCategory = null;
        if (category != null && !category.isBlank()) {
            try { watchCategory = Watch.Category.valueOf(category.toUpperCase()); }
            catch (Exception ignored) {}
        }

        Page<Watch> watches = watchService.searchAndFilter(search, watchCategory, minPrice, maxPrice,
                PageRequest.of(page, size, Sort.by(sortBy)));
        return ResponseEntity.ok(watches);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get watch by ID")
    public ResponseEntity<Watch> getWatch(@PathVariable Long id) {
        Optional<Watch> watch = watchService.findById(id);
        return watch.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/featured")
    @Operation(summary = "Get featured watches")
    public ResponseEntity<?> getFeatured() {
        return ResponseEntity.ok(watchService.getFeaturedWatches());
    }
}
