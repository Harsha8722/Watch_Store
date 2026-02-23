package com.watchstore.repository;

import com.watchstore.entity.Order;
import com.watchstore.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUserOrderByOrderDateDesc(User user);
    Page<Order> findAll(Pageable pageable);

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.status != 'CANCELLED'")
    BigDecimal getTotalRevenue();

    @Query("SELECT COALESCE(SUM(o.totalAmount), 0) FROM Order o WHERE o.orderDate BETWEEN :start AND :end AND o.status != 'CANCELLED'")
    BigDecimal getRevenueByDateRange(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT MONTH(o.orderDate) as month, COALESCE(SUM(o.totalAmount), 0) as revenue FROM Order o " +
           "WHERE YEAR(o.orderDate) = :year AND o.status != 'CANCELLED' GROUP BY MONTH(o.orderDate)")
    List<Object[]> getMonthlyRevenue(@Param("year") int year);
}
