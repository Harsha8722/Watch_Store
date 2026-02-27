<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5 text-center" style="margin-top: 70px;">
                    <div class="success-animation mb-4">
                        <div class="success-circle"><i class="fas fa-check"></i></div>
                    </div>
                    <h2 class="page-title">Order Placed Successfully!</h2>
                    <p class="text-muted">Thank you for your purchase. Your order has been confirmed.</p>

                    <div class="order-success-card mx-auto" style="max-width: 600px;">
                        <div class="order-info-row">
                            <span>Order ID</span>
                            <span class="gold-text fw-bold">#${order.id}</span>
                        </div>
                        <div class="order-info-row">
                            <span>Status</span>
                            <span class="badge status-badge-PENDING">${order.status}</span>
                        </div>
                        <div class="order-info-row">
                            <span>Total Amount</span>
                            <span class="gold-text fw-bold">₹
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##,##0.00" />
                            </span>
                        </div>
                        <div class="order-info-row">
                            <span>Payment Method</span>
                            <span>${order.paymentMethod}</span>
                        </div>
                        <div class="order-info-row">
                            <span>Shipping Address</span>
                            <span>${order.shippingAddress}</span>
                        </div>

                        <h6 class="mt-4 mb-3">Items Ordered</h6>
                        <c:forEach var="item" items="${order.orderItems}">
                            <div class="order-item-row">
                                <span>${item.watch.brand} - ${item.watch.model} (x${item.quantity})</span>
                                <span>₹
                                    <fmt:formatNumber value="${item.subtotal}" pattern="#,##,##0.00" />
                                </span>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="mt-4 d-flex gap-3 justify-content-center">
                        <a href="/orders" class="btn btn-gold"><i class="fas fa-box me-2"></i>My Orders</a>
                        <a href="/watches" class="btn btn-outline-gold">Continue Shopping</a>
                    </div>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />