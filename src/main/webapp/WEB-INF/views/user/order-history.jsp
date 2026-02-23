<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5" style="margin-top: 70px;">
                    <h2 class="page-title mb-4"><i class="fas fa-box-open me-2 gold-text"></i>My Orders</h2>

                    <c:choose>
                        <c:when test="${not empty orders}">
                            <div class="table-responsive">
                                <table class="table luxury-table">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Date</th>
                                            <th>Items</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td><span class="gold-text fw-bold">#${order.id}</span></td>
                                                <td>
                                                    <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy" />
                                                </td>
                                                <td>${order.orderItems.size()} item(s)</td>
                                                <td>₹
                                                    <fmt:formatNumber value="${order.totalAmount}"
                                                        pattern="#,##,##0.00" />
                                                </td>
                                                <td><span
                                                        class="badge status-badge-${order.status}">${order.status}</span>
                                                </td>
                                                <td><a href="/orders/${order.id}"
                                                        class="btn btn-sm btn-outline-gold">View Details</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state text-center py-5">
                                <i class="fas fa-box fa-4x gold-text mb-3"></i>
                                <h4>No orders yet</h4>
                                <p class="text-muted">Start shopping to see your orders here.</p>
                                <a href="/watches" class="btn btn-gold">Browse Watches</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />