<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!-- Footer -->
        <footer class="luxury-footer mt-5">
            <div class="container">
                <div class="row gy-4">
                    <div class="col-lg-4">
                        <h5 class="luxury-brand mb-3"><i class="fas fa-crown me-2"></i>WatchStore</h5>
                        <p class="footer-text">Where time meets elegance. Discover our handpicked collection of the
                            world's finest timepieces.</p>
                        <div class="social-links mt-3">
                            <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-facebook"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <h6 class="footer-heading">Collections</h6>
                        <ul class="footer-links">
                            <li><a href="<c:url value='/watches?category=LUXURY'/>">Luxury</a></li>
                            <li><a href="<c:url value='/watches?category=SPORTS'/>">Sports</a></li>
                            <li><a href="<c:url value='/watches?category=CASUAL'/>">Casual</a></li>
                            <li><a href="<c:url value='/watches?category=SMARTWATCH'/>">Smartwatch</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <h6 class="footer-heading">Account</h6>
                        <ul class="footer-links">
                            <li><a href="<c:url value='/login'/>">Login</a></li>
                            <li><a href="<c:url value='/register'/>">Register</a></li>
                            <li><a href="<c:url value='/user/profile'/>">Profile</a></li>
                            <li><a href="<c:url value='/orders'/>">My Orders</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-4 col-md-4">
                        <h6 class="footer-heading">Contact</h6>
                        <ul class="footer-links">
                            <li><i class="fas fa-map-marker-alt me-2 gold-text"></i>123 Luxury Lane, Mumbai, India</li>
                            <li><i class="fas fa-phone me-2 gold-text"></i>+91 98765 43210</li>
                            <li><i class="fas fa-envelope me-2 gold-text"></i>support@watchstore.in</li>
                        </ul>
                    </div>
                </div>
                <hr class="footer-divider mt-4">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="footer-copyright mb-0">© 2026 WatchStore. All Rights Reserved.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <span class="badge-payment"><i class="fab fa-cc-visa me-2"></i></span>
                        <span class="badge-payment"><i class="fab fa-cc-mastercard me-2"></i></span>
                        <span class="badge-payment"><i class="fab fa-cc-paypal me-2"></i></span>
                        <a href="<c:url value='/swagger-ui/index.html'/>" class="text-muted small ms-3">API Docs</a>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<c:url value='/static/js/main.js'/>"></script>
        </body>

        </html>