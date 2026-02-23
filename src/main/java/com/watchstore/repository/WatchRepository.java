package com.watchstore.repository;

import com.watchstore.entity.Watch;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface WatchRepository extends JpaRepository<Watch, Long> {

    Page<Watch> findByBrandContainingIgnoreCaseOrModelContainingIgnoreCase(
            String brand, String model, Pageable pageable);

    Page<Watch> findByCategory(Watch.Category category, Pageable pageable);

    @Query("SELECT w FROM Watch w WHERE w.price BETWEEN :minPrice AND :maxPrice")
    Page<Watch> findByPriceBetween(@Param("minPrice") BigDecimal minPrice,
                                   @Param("maxPrice") BigDecimal maxPrice, Pageable pageable);

    @Query("SELECT w FROM Watch w WHERE " +
           "(:search IS NULL OR LOWER(w.brand) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(w.model) LIKE LOWER(CONCAT('%', :search, '%'))) AND " +
           "(:category IS NULL OR w.category = :category) AND " +
           "(:minPrice IS NULL OR w.price >= :minPrice) AND " +
           "(:maxPrice IS NULL OR w.price <= :maxPrice)")
    Page<Watch> findByFilters(@Param("search") String search,
                               @Param("category") Watch.Category category,
                               @Param("minPrice") BigDecimal minPrice,
                               @Param("maxPrice") BigDecimal maxPrice,
                               Pageable pageable);

    List<Watch> findTop8ByOrderByCreatedAtDesc();

    List<Watch> findTop4ByCategory(Watch.Category category);
}
