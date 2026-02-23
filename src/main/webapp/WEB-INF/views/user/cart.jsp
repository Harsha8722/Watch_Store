<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5" style="margin-top: 70px;">
                    <h2 class="page-title mb-4"><i class="fas fa-shopping-cart me-2 gold-text"></i>Your Cart</h2>

                    <c:choose>
                        <c:when test="${not empty cartItems}">
                            <div class="row g-4">
                                <div class="col-lg-8">
                                    <div class="cart-table-wrap">
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="cart-item">
                                                <div class="cart-item-image">
                                                    <c:choose>
                                                        <c:when test="${not empty item.watch.imageUrl}">
                                                            <img src="${item.watch.imageUrl}" alt="${item.watch.brand}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="cart-img-placeholder"><i
                                                                    class="fas fa-clock"></i></div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="cart-item-details">
                                                    <h6 class="cart-brand">${item.watch.brand}</h6>
                                                    <p class="cart-model">${item.watch.model}</p>
                                                    <span class="cart-price">₹
                                                        <fmt:formatNumber value="${item.watch.discountedPrice}"
                                                            pattern="#,##,##0.00" />
                                                    </span>
                                                </div>
                                                <div class="cart-item-qty">
                                                    <form action="/cart/update/${item.id}" method="post"
                                                        class="d-flex align-items-center gap-2">
                                                        <div class="quantity-selector-sm">
                                                            <button type="button" class="qty-btn-sm"
                                                                onclick="this.parentElement.querySelector('input').stepDown(); this.closest('form').submit()">-</button>
                                                            <input type="number" name="quantity"
                                                                value="${item.quantity}" min="1"
                                                                max="${item.watch.stock}" class="qty-input-sm"
                                                                onchange="this.form.submit()">
                                                            <button type="button" class="qty-btn-sm"
                                                                onclick="this.parentElement.querySelector('input').stepUp(); this.closest('form').submit()">+</button>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="cart-item-subtotal">
                                                    ₹
                                                    <fmt:formatNumber
                                                        value="${item.watch.discountedPrice * item.quantity}"
                                                        pattern="#,##,##0.00" />
                                                </div>
                                                <div class="cart-item-remove">
                                                    <form action="/cart/remove/${item.id}" method="post">
                                                        <button type="submit" class="btn-remove"><i
                                                                class="fas fa-trash-alt"></i></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="mt-3">
                                        <a href="/watches" class="btn btn-outline-secondary">
                                            <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                                        </a>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <div class="cart-summary">
                                        <h5 class="summary-title">Order Summary</h5>
                                        <div class="summary-row">
                                            <span>Subtotal</span>
                                            <span>₹
                                                <fmt:formatNumber value="${cartTotal}" pattern="#,##,##0.00" />
                                            </span>
                                        </div>
                                        <div class="summary-row">
                                            <span>Shipping</span>
                                            <span class="text-success">FREE</span>
                                        </div>
                                        <hr>
                                        <div class="summary-row summary-total">
                                            <span>Total</span>
                                            <span class="gold-text">₹
                                                <fmt:formatNumber value="${cartTotal}" pattern="#,##,##0.00" />
                                            </span>
                                        </div>
                                        <a href="/checkout" class="btn btn-gold w-100 mt-3 btn-lg">
                                            <i class="fas fa-lock me-2"></i>Proceed to Checkout
                                        </a>
                                        <div class="secure-badge mt-3 text-center">
                                            <i class="fas fa-shield-alt me-2 gold-text"></i>
                                            <small>Secured with SSL Encryption</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state text-center py-5">
                                <i class="fas fa-shopping-cart fa-4x gold-text mb-3"></i>
                                <h4>Your cart is empty</h4>
                                <p class="text-muted">Explore our luxury collection and add something special.</p>
                                <a href="/watches" class="btn btn-gold">Browse Watches</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />