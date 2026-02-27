<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="light">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>WatchStore - Timeless Elegance</title>
                <meta name="description" content="Premium luxury watches collection - Rolex, Omega, Cartier and more.">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet">
                <link href="<c:url value='/static/css/style.css'/>" rel="stylesheet">
                <link rel="icon" href="/favicon.svg" type="image/svg+xml">
            </head>

            <body>

                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg fixed-top luxury-nav" id="mainNav">
                    <div class="container">
                        <a class="navbar-brand luxury-brand" href="<c:url value='/'/>">
                            <i class="fas fa-crown me-2"></i>WatchStore
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav mx-auto">
                                <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">Home</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/watches'/>">Collections</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/watches?category=LUXURY'/>">Luxury</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/watches?category=SPORTS'/>">Sports</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/watches?category=SMARTWATCH'/>">Smart</a></li>
                            </ul>
                            <ul class="navbar-nav ms-auto align-items-center gap-2">
                                <!-- Theme Toggle -->
                                <li class="nav-item">
                                    <button class="btn btn-sm theme-toggle" onclick="toggleTheme()" id="themeBtn"
                                        title="Toggle Theme">
                                        <i class="fas fa-moon" id="themeIcon"></i>
                                    </button>
                                </li>
                                <sec:authorize access="isAuthenticated()">
                                    <sec:authorize access="hasRole('USER')">
                                        <li class="nav-item">
                                            <a class="nav-link position-relative" href="<c:url value='/cart'/>">
                                                <i class="fas fa-shopping-cart"></i>
                                                <span class="cart-badge" id="cartBadge"></span>
                                            </a>
                                        </li>
                                        <li class="nav-item"><a class="nav-link" href="<c:url value='/wishlist'/>"><i
                                                    class="fas fa-heart"></i></a></li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                                <i class="fas fa-user-circle me-1"></i>
                                                <sec:authentication property="name" />
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end luxury-dropdown">
                                                <li><a class="dropdown-item" href="<c:url value='/user/profile'/>"><i
                                                            class="fas fa-user me-2"></i>Profile</a></li>
                                                <li><a class="dropdown-item" href="<c:url value='/orders'/>"><i
                                                            class="fas fa-box me-2"></i>My Orders</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li>
                                                    <form action="<c:url value='/logout'/>" method="post">
                                                        <button type="submit" class="dropdown-item text-danger">
                                                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                                                        </button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </li>
                                    </sec:authorize>
                                    <sec:authorize access="hasRole('ADMIN')">
                                        <li class="nav-item"><a class="nav-link gold-text"
                                                href="<c:url value='/admin/dashboard'/>"><i
                                                    class="fas fa-tachometer-alt me-1"></i>Dashboard</a></li>
                                        <li class="nav-item">
                                            <form action="<c:url value='/logout'/>" method="post" class="d-inline">
                                                <button type="submit"
                                                    class="btn btn-sm btn-outline-danger">Logout</button>
                                            </form>
                                        </li>
                                    </sec:authorize>
                                </sec:authorize>
                                <sec:authorize access="isAnonymous()">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/login'/>">Login</a>
                                    </li>
                                    <li class="nav-item"><a class="btn btn-gold btn-sm"
                                            href="<c:url value='/register'/>">Register</a></li>
                                </sec:authorize>
                            </ul>
                        </div>
                    </div>
                </nav>

                <!-- Toast Notification -->
                <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index:9999">
                    <c:if test="${not empty success}">
                        <div class="toast align-items-center text-bg-success border-0 show" role="alert">
                            <div class="d-flex">
                                <div class="toast-body"><i class="fas fa-check-circle me-2"></i>${success}</div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="toast align-items-center text-bg-danger border-0 show" role="alert">
                            <div class="d-flex">
                                <div class="toast-body"><i class="fas fa-exclamation-circle me-2"></i>${error}</div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="toast align-items-center text-bg-info border-0 show" role="alert">
                            <div class="d-flex">
                                <div class="toast-body"><i class="fas fa-info-circle me-2"></i>${message}</div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>
                </div>