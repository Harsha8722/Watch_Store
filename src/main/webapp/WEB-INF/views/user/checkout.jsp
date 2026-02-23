<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <jsp:include page="/WEB-INF/views/common/header.jsp" />

                <main class="page-main">
                    <div class="container py-5" style="margin-top: 70px;">
                        <h2 class="page-title mb-4"><i class="fas fa-credit-card me-2 gold-text"></i>Checkout</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"><i class="fas fa-exclamation-triangle me-2"></i>${error}
                            </div>
                        </c:if>

                        <div class="row g-4">
                            <div class="col-lg-7">
                                <div class="checkout-card">
                                    <h5 class="checkout-section-title"><i
                                            class="fas fa-map-marker-alt me-2 gold-text"></i>Shipping Information</h5>
                                    <form:form action="/checkout" method="post" modelAttribute="checkoutDTO">
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <div class="form-floating">
                                                    <form:input path="fullName" cssClass="form-control luxury-input"
                                                        placeholder="Full Name" />
                                                    <label>Full Name</label>
                                                    <form:errors path="fullName" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating">
                                                    <form:input path="address" cssClass="form-control luxury-input"
                                                        placeholder="Address" />
                                                    <label>Street Address</label>
                                                    <form:errors path="address" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-floating">
                                                    <form:input path="city" cssClass="form-control luxury-input"
                                                        placeholder="City" />
                                                    <label>City</label>
                                                    <form:errors path="city" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-floating">
                                                    <form:input path="state" cssClass="form-control luxury-input"
                                                        placeholder="State" />
                                                    <label>State</label>
                                                    <form:errors path="state" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-floating">
                                                    <form:input path="postalCode" cssClass="form-control luxury-input"
                                                        placeholder="Postal Code" />
                                                    <label>Postal Code</label>
                                                    <form:errors path="postalCode" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-floating">
                                                    <form:input path="phone" cssClass="form-control luxury-input"
                                                        placeholder="Phone" />
                                                    <label>Phone Number</label>
                                                    <form:errors path="phone" cssClass="text-danger small" />
                                                </div>
                                            </div>
                                        </div>

                                        <h5 class="checkout-section-title mt-4"><i
                                                class="fas fa-credit-card me-2 gold-text"></i>Payment Method</h5>
                                        <div class="payment-options">
                                            <label class="payment-option">
                                                <form:radiobutton path="paymentMethod" value="COD" />
                                                <div class="payment-label">
                                                    <i class="fas fa-money-bill-wave"></i>
                                                    <span>Cash on Delivery</span>
                                                </div>
                                            </label>
                                            <label class="payment-option">
                                                <form:radiobutton path="paymentMethod" value="UPI" />
                                                <div class="payment-label">
                                                    <i class="fas fa-mobile-alt"></i>
                                                    <span>UPI Payment</span>
                                                </div>
                                            </label>
                                            <label class="payment-option">
                                                <form:radiobutton path="paymentMethod" value="CARD" />
                                                <div class="payment-label">
                                                    <i class="fas fa-credit-card"></i>
                                                    <span>Credit/Debit Card</span>
                                                </div>
                                            </label>
                                        </div>
                                        <form:errors path="paymentMethod" cssClass="text-danger small" />

                                        <button type="submit" class="btn btn-gold w-100 btn-lg mt-4">
                                            <i class="fas fa-shopping-bag me-2"></i>Place Order
                                        </button>
                                    </form:form>
                                </div>
                            </div>

                            <div class="col-lg-5">
                                <div class="cart-summary">
                                    <h5 class="summary-title">Order Summary</h5>
                                    <c:forEach var="item" items="${cartItems}">
                                        <div class="checkout-item">
                                            <span>${item.watch.brand} ${item.watch.model} x${item.quantity}</span>
                                            <span>₹
                                                <fmt:formatNumber value="${item.watch.discountedPrice * item.quantity}"
                                                    pattern="#,##,##0.00" />
                                            </span>
                                        </div>
                                    </c:forEach>
                                    <hr>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <jsp:include page="/WEB-INF/views/common/footer.jsp" />