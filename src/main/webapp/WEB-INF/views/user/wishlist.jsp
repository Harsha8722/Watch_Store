<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5" style="margin-top: 70px;">
                    <h2 class="page-title mb-4"><i class="fas fa-heart me-2 gold-text"></i>My Wishlist</h2>

                    <c:choose>
                        <c:when test="${not empty wishlistItems}">
                            <div class="row g-4">
                                <c:forEach var="item" items="${wishlistItems}">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-card">
                                            <div class="product-image-wrap">
                                                <c:choose>
                                                    <c:when test="${not empty item.watch.imageUrl}">
                                                        <img src="${item.watch.imageUrl}" alt="${item.watch.brand}"
                                                            class="product-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-img-placeholder"><i
                                                                class="fas fa-clock"></i></div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <form action="/wishlist/remove/${item.watch.id}" method="post"
                                                    class="wishlist-remove-btn">
                                                    <button type="submit" class="action-btn"
                                                        title="Remove from wishlist">
                                                        <i class="fas fa-heart text-danger"></i>
                                                    </button>
                                                </form>
                                            </div>
                                            <div class="product-body">
                                                <span class="product-category">${item.watch.category}</span>
                                                <h6 class="product-brand">${item.watch.brand}</h6>
                                                <p class="product-model">${item.watch.model}</p>
                                                <div class="product-price">
                                                    <span class="current-price">₹
                                                        <fmt:formatNumber value="${item.watch.discountedPrice}"
                                                            pattern="#,##,##0.00" />
                                                    </span>
                                                </div>
                                                <div class="d-flex gap-2 mt-2">
                                                    <a href="/watches/${item.watch.id}"
                                                        class="btn btn-outline-gold btn-sm flex-grow-1">View</a>
                                                    <form action="/cart/add" method="post" class="flex-grow-1">
                                                        <input type="hidden" name="watchId" value="${item.watch.id}">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <button type="submit" class="btn btn-cart btn-sm w-100">
                                                            <i class="fas fa-cart-plus"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state text-center py-5">
                                <i class="fas fa-heart fa-4x gold-text mb-3"></i>
                                <h4>Your wishlist is empty</h4>
                                <p class="text-muted">Save your favourite watches to come back to them later.</p>
                                <a href="/watches" class="btn btn-gold">Browse Watches</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />