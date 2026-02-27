<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5" style="margin-top: 70px;">
                    <div class="d-flex align-items-center mb-4">
                        <a href="/orders" class="btn btn-sm btn-outline-secondary me-3">
                            <i class="fas fa-arrow-left"></i>
                        </a>
                        <h2 class="page-title mb-0">Order #${order.id}</h2>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <div class="order-detail-card">
                                <h5 class="mb-3">Items Ordered</h5>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <div class="order-item-detail">
                                        <c:choose>
                                            <c:when test="${not empty item.watch.imageUrl}">
                                                <img src="${item.watch.imageUrl}" alt="${item.watch.brand}"
                                                    class="order-item-img">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="order-item-img-placeholder"><i class="fas fa-clock"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="order-item-info">
                                            <h6>${item.watch.brand} - ${item.watch.model}</h6>
                                            <p class="text-muted">Quantity: ${item.quantity}</p>
                                            <p class="text-muted">Price: ₹
                                                <fmt:formatNumber value="${item.price}" pattern="#,##,##0.00" />
                                            </p>
                                        </div>
                                        <div class="order-item-total gold-text fw-bold">
                                            ₹
                                            <fmt:formatNumber value="${item.subtotal}" pattern="#,##,##0.00" />
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="order-summary-card">
                                <h5 class="mb-3">Order Details</h5>
                                <div class="detail-row"><b>Status:</b> <span
                                        class="badge status-badge-${order.status}">${order.status}</span></div>
                                <div class="detail-row"><b>Date:</b>
                                    <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd MMM yyyy HH:mm" />
                                </div>
                                <div class="detail-row"><b>Payment:</b> ${order.paymentMethod}</div>
                                <div class="detail-row"><b>Shipping Address:</b><br>${order.shippingAddress}</div>
                                <hr>
                                <div class="detail-row summary-total">
                                    <b>Total:</b>
                                    <span class="gold-text fw-bold">₹
                                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,##,##0.00" />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />