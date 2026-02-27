<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
                <jsp:include page="/WEB-INF/views/common/header.jsp" />

                <main class="page-main">
                    <div class="container py-5" style="margin-top: 80px;">

                        <!-- Breadcrumb -->
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb luxury-breadcrumb">
                                <li class="breadcrumb-item"><a href="<c:url value='/'/>">Home</a></li>
                                <li class="breadcrumb-item"><a href="<c:url value='/watches'/>">Collections</a></li>
                                <li class="breadcrumb-item active">${watch.brand} ${watch.model}</li>
                            </ol>
                        </nav>

                        <!-- Product Detail -->
                        <div class="row g-5">
                            <!-- Image Section -->
                            <div class="col-lg-6">
                                <div class="watch-detail-image-wrap">
                                    <c:choose>
                                        <c:when test="${not empty watch.imageUrl}">
                                            <img src="${watch.imageUrl}" alt="${watch.brand} ${watch.model}"
                                                class="watch-detail-img" id="mainWatchImage">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="watch-detail-placeholder">
                                                <i class="fas fa-clock fa-5x gold-text"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${watch.discount > 0}">
                                        <span class="detail-discount-badge">${watch.discount}% OFF</span>
                                    </c:if>
                                </div>

                                <!-- Feature Pills -->
                                <div class="watch-features-row mt-3 d-flex gap-2 flex-wrap">
                                    <span class="feature-pill"><i class="fas fa-shield-alt me-1"></i> Authentic</span>
                                    <span class="feature-pill"><i class="fas fa-certificate me-1"></i> Certified</span>
                                    <span class="feature-pill"><i class="fas fa-undo-alt me-1"></i> 30-Day Return</span>
                                    <span class="feature-pill"><i class="fas fa-shipping-fast me-1"></i> Free
                                        Shipping</span>
                                </div>
                            </div>

                            <!-- Details Section -->
                            <div class="col-lg-6">
                                <div class="watch-detail-info">
                                    <span class="product-category detail-category">${watch.category}</span>
                                    <h1 class="watch-detail-brand">${watch.brand}</h1>
                                    <h2 class="watch-detail-model">${watch.model}</h2>

                                    <!-- Rating -->
                                    <div class="detail-rating mb-3">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i
                                                class="fas fa-star ${star <= watch.averageRating ? 'text-warning' : 'text-muted'}"></i>
                                        </c:forEach>
                                        <span class="rating-count ms-2">(${not empty reviews ? reviews.size() : 0}
                                            reviews)</span>
                                    </div>

                                    <!-- Price -->
                                    <div class="detail-price-box mb-4">
                                        <c:if test="${watch.discount > 0}">
                                            <span class="detail-old-price">
                                                ₹
                                                <fmt:formatNumber value="${watch.price}" pattern="#,##,##0.00" />
                                            </span>
                                            <span class="detail-save-badge">Save ${watch.discount}%</span>
                                        </c:if>
                                        <div class="detail-current-price">
                                            ₹
                                            <fmt:formatNumber value="${watch.discountedPrice}" pattern="#,##,##0.00" />
                                        </div>
                                        <small class="text-muted">*Inclusive of all taxes</small>
                                    </div>

                                    <!-- Stock Status -->
                                    <div class="mb-3">
                                        <c:choose>
                                            <c:when test="${watch.stock > 5}">
                                                <span class="stock-badge in-stock"><i
                                                        class="fas fa-check-circle me-1"></i>In Stock (${watch.stock}
                                                    available)</span>
                                            </c:when>
                                            <c:when test="${watch.stock > 0}">
                                                <span class="stock-badge low-stock"><i
                                                        class="fas fa-exclamation-circle me-1"></i>Only ${watch.stock}
                                                    left!</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-badge out-stock"><i
                                                        class="fas fa-times-circle me-1"></i>Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Description -->
                                    <p class="watch-description mb-4">${watch.description}</p>

                                    <!-- Actions -->
                                    <sec:authorize access="isAuthenticated()">
                                        <c:if test="${watch.stock > 0}">
                                            <div class="d-flex gap-3 mb-4">
                                                <form action="<c:url value='/cart/add'/>" method="post"
                                                    class="flex-grow-1">
                                                    <input type="hidden" name="watchId" value="${watch.id}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-gold btn-lg w-100">
                                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                                    </button>
                                                </form>
                                                <c:choose>
                                                    <c:when test="${isInWishlist}">
                                                        <form action="<c:url value='/wishlist/remove/${watch.id}'/>"
                                                            method="post">
                                                            <button type="submit"
                                                                class="btn btn-outline-danger btn-lg px-4"
                                                                title="Remove from Wishlist">
                                                                <i class="fas fa-heart"></i>
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="<c:url value='/wishlist/add/${watch.id}'/>"
                                                            method="post">
                                                            <button type="submit"
                                                                class="btn btn-outline-secondary btn-lg px-4"
                                                                title="Add to Wishlist">
                                                                <i class="far fa-heart"></i>
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:if>
                                        <c:if test="${watch.stock <= 0}">
                                            <button class="btn btn-secondary btn-lg w-100 mb-4" disabled>
                                                <i class="fas fa-times-circle me-2"></i>Out of Stock
                                            </button>
                                        </c:if>
                                    </sec:authorize>
                                    <sec:authorize access="isAnonymous()">
                                        <a href="<c:url value='/login'/>" class="btn btn-gold btn-lg w-100 mb-4">
                                            <i class="fas fa-sign-in-alt me-2"></i>Login to Purchase
                                        </a>
                                    </sec:authorize>

                                    <!-- Watch Specifications -->
                                    <div class="spec-card">
                                        <h6 class="spec-title"><i class="fas fa-info-circle me-2 gold-text"></i>Watch
                                            Details</h6>
                                        <table class="spec-table">
                                            <tr>
                                                <td class="spec-key">Brand</td>
                                                <td class="spec-val">${watch.brand}</td>
                                            </tr>
                                            <tr>
                                                <td class="spec-key">Model</td>
                                                <td class="spec-val">${watch.model}</td>
                                            </tr>
                                            <tr>
                                                <td class="spec-key">Category</td>
                                                <td class="spec-val">${watch.category}</td>
                                            </tr>
                                            <tr>
                                                <td class="spec-key">Availability</td>
                                                <td class="spec-val">${watch.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Reviews Section -->
                        <div class="row mt-5">
                            <div class="col-12">
                                <div class="section-header mb-4">
                                    <span class="section-tag">Feedback</span>
                                    <h3 class="section-title">Customer Reviews</h3>
                                </div>

                                <!-- Write Review (logged in, hasn't reviewed) -->
                                <sec:authorize access="hasRole('USER')">
                                    <c:if test="${not hasReviewed}">
                                        <div class="review-form-card mb-4">
                                            <h5><i class="fas fa-pen me-2 gold-text"></i>Write a Review</h5>
                                            <form action="<c:url value='/reviews/add'/>" method="post">
                                                <input type="hidden" name="watchId" value="${watch.id}">
                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold">Your Rating</label>
                                                    <div class="star-rating-input" id="starRating">
                                                        <i class="far fa-star" data-val="1"></i>
                                                        <i class="far fa-star" data-val="2"></i>
                                                        <i class="far fa-star" data-val="3"></i>
                                                        <i class="far fa-star" data-val="4"></i>
                                                        <i class="far fa-star" data-val="5"></i>
                                                    </div>
                                                    <input type="hidden" name="rating" id="ratingInput" value="5">
                                                </div>
                                                <div class="mb-3">
                                                    <label for="reviewComment" class="form-label fw-semibold">Your
                                                        Review</label>
                                                    <textarea name="comment" id="reviewComment" class="form-control"
                                                        rows="3" placeholder="Share your experience with this watch..."
                                                        required></textarea>
                                                </div>
                                                <button type="submit" class="btn btn-gold">
                                                    <i class="fas fa-paper-plane me-2"></i>Submit Review
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </sec:authorize>

                                <!-- Reviews List -->
                                <c:choose>
                                    <c:when test="${not empty reviews}">
                                        <div class="reviews-list">
                                            <c:forEach var="review" items="${reviews}">
                                                <div class="review-card">
                                                    <div class="review-header">
                                                        <div class="review-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <div class="review-meta">
                                                            <h6 class="review-author">${review.user.name}</h6>
                                                            <div class="review-stars">
                                                                <c:forEach begin="1" end="5" var="s">
                                                                    <i
                                                                        class="fas fa-star ${s <= review.rating ? 'text-warning' : 'text-muted small'}"></i>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <p class="review-comment">${review.comment}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state text-center py-4">
                                            <i class="fas fa-star fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No reviews yet. Be the first to review this watch!</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </main>

                <style>
                    .luxury-breadcrumb {
                        background: transparent;
                        padding: 0;
                    }

                    .luxury-breadcrumb a {
                        color: var(--gold);
                        text-decoration: none;
                    }

                    .watch-detail-image-wrap {
                        position: relative;
                        border-radius: 16px;
                        overflow: hidden;
                        background: var(--card-bg);
                        padding: 20px;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
                    }

                    .watch-detail-img {
                        width: 100%;
                        height: 480px;
                        object-fit: cover;
                        border-radius: 12px;
                        transition: transform 0.4s ease;
                    }

                    .watch-detail-img:hover {
                        transform: scale(1.03);
                    }

                    .watch-detail-placeholder {
                        height: 480px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: var(--bg-secondary);
                        border-radius: 12px;
                    }

                    .detail-discount-badge {
                        position: absolute;
                        top: 16px;
                        left: 16px;
                        background: #e53e3e;
                        color: #fff;
                        padding: 6px 14px;
                        border-radius: 20px;
                        font-weight: 700;
                        font-size: 0.85rem;
                    }

                    .feature-pill {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        color: var(--text-secondary);
                        padding: 5px 12px;
                        border-radius: 20px;
                        font-size: 0.78rem;
                        font-weight: 500;
                    }

                    .detail-category {
                        font-size: 0.75rem;
                        font-weight: 600;
                        letter-spacing: 2px;
                        text-transform: uppercase;
                        color: var(--gold);
                        background: rgba(197, 168, 90, 0.12);
                        padding: 4px 12px;
                        border-radius: 20px;
                    }

                    .watch-detail-brand {
                        font-family: 'Playfair Display', serif;
                        font-size: 2.4rem;
                        font-weight: 700;
                        color: var(--text-primary);
                        margin: 8px 0 4px;
                    }

                    .watch-detail-model {
                        font-size: 1.2rem;
                        color: var(--text-secondary);
                        margin-bottom: 12px;
                    }

                    .detail-rating {
                        color: #f0c040;
                        font-size: 1rem;
                    }

                    .rating-count {
                        color: var(--text-secondary);
                        font-size: 0.9rem;
                    }

                    .detail-price-box {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        padding: 20px;
                        border-radius: 12px;
                    }

                    .detail-old-price {
                        font-size: 1.1rem;
                        color: var(--text-secondary);
                        text-decoration: line-through;
                        margin-right: 10px;
                    }

                    .detail-save-badge {
                        background: #e53e3e;
                        color: #fff;
                        font-size: 0.75rem;
                        padding: 3px 10px;
                        border-radius: 12px;
                        font-weight: 600;
                    }

                    .detail-current-price {
                        font-size: 2rem;
                        font-weight: 700;
                        color: var(--gold);
                        font-family: 'Playfair Display', serif;
                        margin-top: 6px;
                    }

                    .stock-badge {
                        padding: 5px 14px;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 600;
                    }

                    .stock-badge.in-stock {
                        background: rgba(56, 161, 105, 0.15);
                        color: #38a169;
                    }

                    .stock-badge.low-stock {
                        background: rgba(237, 137, 54, 0.15);
                        color: #dd6b20;
                    }

                    .stock-badge.out-stock {
                        background: rgba(229, 62, 62, 0.15);
                        color: #e53e3e;
                    }

                    .watch-description {
                        color: var(--text-secondary);
                        line-height: 1.8;
                        font-size: 0.95rem;
                    }

                    .spec-card {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        padding: 20px;
                        border-radius: 12px;
                    }

                    .spec-title {
                        font-weight: 600;
                        margin-bottom: 14px;
                    }

                    .spec-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .spec-table tr {
                        border-bottom: 1px solid var(--border);
                    }

                    .spec-table tr:last-child {
                        border-bottom: none;
                    }

                    .spec-key {
                        color: var(--text-secondary);
                        font-size: 0.88rem;
                        padding: 8px 0;
                        width: 40%;
                    }

                    .spec-val {
                        color: var(--text-primary);
                        font-weight: 500;
                        font-size: 0.88rem;
                        padding: 8px 0;
                    }

                    .review-form-card {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        padding: 24px;
                        border-radius: 12px;
                    }

                    .star-rating-input {
                        font-size: 1.6rem;
                        cursor: pointer;
                        color: #f0c040;
                        margin-bottom: 8px;
                    }

                    .star-rating-input i {
                        margin-right: 4px;
                        transition: transform 0.15s;
                    }

                    .star-rating-input i:hover {
                        transform: scale(1.2);
                    }

                    .reviews-list {
                        display: flex;
                        flex-direction: column;
                        gap: 16px;
                    }

                    .review-card {
                        background: var(--card-bg);
                        border: 1px solid var(--border);
                        padding: 20px;
                        border-radius: 12px;
                    }

                    .review-header {
                        display: flex;
                        align-items: center;
                        gap: 14px;
                        margin-bottom: 12px;
                    }

                    .review-avatar {
                        width: 42px;
                        height: 42px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, var(--gold), #a0782a);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #fff;
                    }

                    .review-author {
                        font-weight: 600;
                        margin: 0;
                        color: var(--text-primary);
                    }

                    .review-stars {
                        font-size: 0.85rem;
                    }

                    .review-comment {
                        color: var(--text-secondary);
                        line-height: 1.7;
                        margin: 0;
                    }
                </style>

                <script>
                    // Star rating interaction
                    const stars = document.querySelectorAll('#starRating i');
                    const ratingInput = document.getElementById('ratingInput');
                    if (stars && ratingInput) {
                        stars.forEach((star, idx) => {
                            star.addEventListener('mouseover', () => highlightStars(idx + 1));
                            star.addEventListener('click', () => {
                                ratingInput.value = idx + 1;
                                highlightStars(idx + 1, true);
                            });
                        });
                        document.getElementById('starRating').addEventListener('mouseleave', () => {
                            highlightStars(parseInt(ratingInput.value), true);
                        });
                    }
                    function highlightStars(count, permanent) {
                        stars.forEach((s, i) => {
                            s.className = i < count ? 'fas fa-star' : 'far fa-star';
                        });
                    }
                    highlightStars(5, true);
                </script>

                <jsp:include page="/WEB-INF/views/common/footer.jsp" />