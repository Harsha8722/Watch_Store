<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ include file="common/header.jsp" %>
                <main>
                    <!-- Hero Section -->
                    <section class="hero-section">
                        <div class="hero-overlay"></div>
                        <div class="container h-100">
                            <div class="row h-100 align-items-center">
                                <div class="col-lg-7">
                                    <div class="hero-content">
                                        <p class="hero-subtitle animate-fade-up">LUXURY TIMEPIECES</p>
                                        <h1 class="hero-title animate-fade-up delay-1">Timeless<br><span
                                                class="gold-text">Elegance</span></h1>
                                        <p class="hero-desc animate-fade-up delay-2">Discover our curated collection of
                                            the
                                            world's finest watches. Where craftsmanship meets precision.</p>
                                        <div class="hero-cta animate-fade-up delay-3">
                                            <a href="<c:url value='/watches'/>" class="btn btn-gold btn-lg me-3">
                                                <i class="fas fa-gem me-2"></i>Shop Collection
                                            </a>
                                            <a href="<c:url value='/watches?category=LUXURY'/>"
                                                class="btn btn-outline-light btn-lg">
                                                View Luxury
                                            </a>
                                        </div>
                                        <div class="hero-stats mt-4 animate-fade-up delay-4">
                                            <div class="stat">
                                                <span class="stat-number">500+</span>
                                                <span class="stat-label">Models</span>
                                            </div>
                                            <div class="stat">
                                                <span class="stat-number">50+</span>
                                                <span class="stat-label">Brands</span>
                                            </div>
                                            <div class="stat">
                                                <span class="stat-number">10K+</span>
                                                <span class="stat-label">Happy Customers</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="scroll-indicator">
                            <div class="scroll-dot"></div>
                        </div>
                    </section>

                    <!-- Categories Section -->
                    <section class="section-padding">
                        <div class="container">
                            <div class="section-header text-center mb-5">
                                <span class="section-tag">Explore</span>
                                <h2 class="section-title">Shop by Category</h2>
                            </div>
                            <div class="row g-3">
                                <div class="col-lg-3 col-md-6">
                                    <a href="<c:url value='/watches?category=LUXURY'/>" class="category-card">
                                        <div class="category-icon"><i class="fas fa-crown"></i></div>
                                        <h5>Luxury</h5>
                                        <p>Prestige & Elegance</p>
                                        <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                                    </a>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <a href="<c:url value='/watches?category=SPORTS'/>" class="category-card">
                                        <div class="category-icon"><i class="fas fa-running"></i></div>
                                        <h5>Sports</h5>
                                        <p>Performance & Durability</p>
                                        <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                                    </a>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <a href="<c:url value='/watches?category=CASUAL'/>" class="category-card">
                                        <div class="category-icon"><i class="fas fa-tshirt"></i></div>
                                        <h5>Casual</h5>
                                        <p>Everyday Style</p>
                                        <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                                    </a>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <a href="<c:url value='/watches?category=SMARTWATCH'/>" class="category-card">
                                        <div class="category-icon"><i class="fas fa-microchip"></i></div>
                                        <h5>Smartwatch</h5>
                                        <p>Tech & Innovation</p>
                                        <span class="category-arrow"><i class="fas fa-arrow-right"></i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Featured Watches -->
                    <section class="section-padding bg-muted">
                        <div class="container">
                            <div class="section-header text-center mb-5">
                                <span class="section-tag">Just Arrived</span>
                                <h2 class="section-title">Featured Collection</h2>
                            </div>
                            <div class="row g-4">
                                <c:forEach var="watch" items="${featuredWatches}">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="product-card">
                                            <div class="product-image-wrap">
                                                <c:choose>
                                                    <c:when test="${not empty watch.imageUrl}">
                                                        <img src="${watch.imageUrl}" alt="${watch.brand} ${watch.model}"
                                                            class="product-img" loading="lazy">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-img-placeholder"><i
                                                                class="fas fa-clock"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${watch.discount > 0}">
                                                    <span class="discount-badge">${watch.discount}% OFF</span>
                                                </c:if>
                                                <div class="product-actions">
                                                    <a href="<c:url value='/wishlist/add/${watch.id}'/>"
                                                        class="action-btn" title="Add to Wishlist">
                                                        <i class="fas fa-heart"></i>
                                                    </a>
                                                    <a href="<c:url value='/watches/${watch.id}'/>" class="action-btn"
                                                        title="Quick View">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="product-body">
                                                <span class="product-category">${watch.category}</span>
                                                <h6 class="product-brand">${watch.brand}</h6>
                                                <p class="product-model">${watch.model}</p>
                                                <div class="product-price">
                                                    <c:if test="${watch.discount > 0}">
                                                        <span class="old-price">₹
                                                            <fmt:formatNumber value="${watch.price}"
                                                                pattern="#,##,##0.00" />
                                                        </span>
                                                    </c:if>
                                                    <span class="current-price">₹
                                                        <fmt:formatNumber value="${watch.discountedPrice}"
                                                            pattern="#,##,##0.00" />
                                                    </span>
                                                </div>
                                                <div class="product-rating">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <i
                                                            class="fas fa-star ${star <= watch.averageRating ? 'active' : ''}"></i>
                                                    </c:forEach>
                                                </div>
                                                <a href="<c:url value='/cart/add?watchId=${watch.id}&quantity=1'/>"
                                                    class="btn btn-cart btn-sm w-100 mt-2">
                                                    <i class="fas fa-shopping-cart me-1"></i>Add to Cart
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty featuredWatches}">
                                    <div class="col-12 text-center py-5">
                                        <i class="fas fa-clock fa-3x gold-text mb-3"></i>
                                        <p>No watches available yet. <a href="<c:url value='/admin/products'/>"
                                                class="gold-text">Add some
                                                products!</a></p>
                                    </div>
                                </c:if>
                            </div>
                            <div class="text-center mt-5">
                                <a href="<c:url value='/watches'/>" class="btn btn-gold">View All Watches <i
                                        class="fas fa-arrow-right ms-2"></i></a>
                            </div>
                        </div>
                    </section>

                    <!-- Why Choose Us -->
                    <section class="section-padding">
                        <div class="container">
                            <div class="section-header text-center mb-5">
                                <span class="section-tag">Why Us</span>
                                <h2 class="section-title">The WatchStore Promise</h2>
                            </div>
                            <div class="row g-4 text-center">
                                <div class="col-lg-3 col-md-6">
                                    <div class="feature-card">
                                        <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
                                        <h5>Authentic Guarantee</h5>
                                        <p>Every watch is 100% authentic with manufacturer warranty.</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="feature-card">
                                        <div class="feature-icon"><i class="fas fa-shipping-fast"></i></div>
                                        <h5>Free Shipping</h5>
                                        <p>Complimentary express delivery on all orders above ₹10,000.</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="feature-card">
                                        <div class="feature-icon"><i class="fas fa-undo-alt"></i></div>
                                        <h5>30-Day Returns</h5>
                                        <p>Hassle-free returns within 30 days of purchase.</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="feature-card">
                                        <div class="feature-icon"><i class="fas fa-headset"></i></div>
                                        <h5>24/7 Support</h5>
                                        <p>Our luxury concierge team is available around the clock.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Testimonials -->
                    <section class="section-padding bg-muted">
                        <div class="container">
                            <div class="section-header text-center mb-5">
                                <span class="section-tag">Testimonials</span>
                                <h2 class="section-title">What Our Clients Say</h2>
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-4">
                                    <div class="testimonial-card">
                                        <div class="testimonial-stars">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i>
                                        </div>
                                        <p class="testimonial-text">"Bought my Rolex Submariner here. The quality and
                                            service are absolutely top-notch. Completely authentic!"</p>
                                        <div class="testimonial-author">
                                            <div class="testimonial-avatar"><i class="fas fa-user"></i></div>
                                            <div>
                                                <h6>Arjun Mehta</h6>
                                                <small>Mumbai, India</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="testimonial-card featured-testimonial">
                                        <div class="testimonial-stars">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i>
                                        </div>
                                        <p class="testimonial-text">"The best watch store online! Got my Omega Seamaster
                                            delivered in 2 days. Worth every rupee."</p>
                                        <div class="testimonial-author">
                                            <div class="testimonial-avatar gold-bg"><i class="fas fa-user"></i></div>
                                            <div>
                                                <h6>Priya Sharma</h6>
                                                <small>Bangalore, India</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="testimonial-card">
                                        <div class="testimonial-stars">
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i>
                                        </div>
                                        <p class="testimonial-text">"Excellent collection, competitive prices, and
                                            flawless
                                            packaging. My go-to for luxury watches."</p>
                                        <div class="testimonial-author">
                                            <div class="testimonial-avatar"><i class="fas fa-user"></i></div>
                                            <div>
                                                <h6>Rahul Verma</h6>
                                                <small>Delhi, India</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Newsletter -->
                    <section class="newsletter-section section-padding">
                        <div class="container">
                            <div class="newsletter-card text-center">
                                <h3>Stay Updated with Exclusive Offers</h3>
                                <p>Subscribe to receive the latest arrivals, exclusive deals, and luxury watch insights.
                                </p>
                                <div class="newsletter-form">
                                    <input type="email" class="form-control newsletter-input"
                                        placeholder="Enter your email address">
                                    <button class="btn btn-gold">Subscribe</button>
                                </div>
                            </div>
                        </div>
                    </section>
                </main>
                <%@ include file="common/footer.jsp" %>