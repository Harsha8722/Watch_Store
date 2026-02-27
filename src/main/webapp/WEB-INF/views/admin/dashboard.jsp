<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-admin-theme="dark">

            <head>
                <script>
                    const theme = localStorage.getItem('adminTheme') || 'dark';
                    document.documentElement.setAttribute('data-admin-theme', theme);
                    document.documentElement.setAttribute('data-theme', theme);
                </script>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet">
                <link href="/static/css/style.css" rel="stylesheet">
                <link href="/static/css/admin.css" rel="stylesheet">
                <link rel="icon" href="/favicon.svg" type="image/svg+xml">
            </head>

            <body class="admin-body">
                <!-- Sidebar -->
                <div class="admin-sidebar" id="adminSidebar">
                    <div class="sidebar-brand"><i class="fas fa-crown me-2"></i>WatchStore</div>
                    <nav class="sidebar-nav">
                        <a href="/admin/dashboard" class="sidebar-link active"><i
                                class="fas fa-tachometer-alt"></i>Dashboard</a>
                        <a href="/admin/products" class="sidebar-link"><i class="fas fa-clock"></i>Products</a>
                        <a href="/admin/users" class="sidebar-link"><i class="fas fa-users"></i>Users</a>
                        <a href="/admin/orders" class="sidebar-link"><i class="fas fa-box"></i>Orders</a>
                        <form action="/logout" method="post">
                            <button type="submit" class="sidebar-link sidebar-logout">
                                <i class="fas fa-sign-out-alt"></i>Logout
                            </button>
                        </form>
                    </nav>
                </div>

                <!-- Main -->
                <div class="admin-main">
                    <!-- Topbar -->
                    <div class="admin-topbar">
                        <button class="sidebar-toggle"
                            onclick="document.getElementById('adminSidebar').classList.toggle('sidebar-collapsed')">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="topbar-title">Dashboard Overview</div>
                        <!-- Dark / Light Mode Toggle -->
                        <button class="admin-theme-toggle" id="adminThemeBtn" onclick="toggleAdminTheme()">
                            <i class="fas fa-moon" id="adminThemeIcon"></i>
                            <span id="adminThemeLabel">Light Mode</span>
                        </button>
                    </div>

                    <!-- Content -->
                    <div class="admin-content">
                        <div class="row g-4 mb-4">
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <div class="stat-icon bg-primary-subtle text-primary"><i class="fas fa-watch"></i>
                                    </div>
                                    <div>
                                        <div class="stat-label">Total Products</div>
                                        <div class="stat-value">${totalProducts}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <div class="stat-icon bg-success-subtle text-success"><i
                                            class="fas fa-shopping-bag"></i></div>
                                    <div>
                                        <div class="stat-label">Total Orders</div>
                                        <div class="stat-value">${totalOrders}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <div class="stat-icon bg-info-subtle text-info"><i class="fas fa-users"></i></div>
                                    <div>
                                        <div class="stat-label">Total Users</div>
                                        <div class="stat-value">${totalUsers}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stat-card">
                                    <div class="stat-icon bg-gold-subtle text-gold"><i
                                            class="fas fa-indian-rupee-sign"></i></div>
                                    <div>
                                        <div class="stat-label">Total Revenue</div>
                                        <div class="stat-value">₹
                                            <fmt:formatNumber value="${totalRevenue}" pattern="#,##,##0" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="admin-card">
                            <div class="admin-card-header">
                                <h5>Quick Actions</h5>
                            </div>
                            <div class="admin-card-body">
                                <div class="d-flex gap-3">
                                    <a href="/admin/products?action=add" class="btn btn-gold">
                                        <i class="fas fa-plus me-2"></i>Add New Product
                                    </a>
                                    <a href="/admin/orders" class="btn btn-outline-secondary">View Recent Orders</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Admin Theme Toggle - persists via localStorage
                    const THEME_KEY = 'adminTheme';

                    function applyAdminTheme(theme) {
                        document.documentElement.setAttribute('data-admin-theme', theme);
                        document.documentElement.setAttribute('data-theme', theme);
                        const icon = document.getElementById('adminThemeIcon');
                        const label = document.getElementById('adminThemeLabel');
                        if (theme === 'light') {
                            icon.className = 'fas fa-moon';
                            label.textContent = 'Dark Mode';
                        } else {
                            icon.className = 'fas fa-sun';
                            label.textContent = 'Light Mode';
                        }
                    }

                    function toggleAdminTheme() {
                        const current = document.documentElement.getAttribute('data-admin-theme') || 'dark';
                        const next = current === 'dark' ? 'light' : 'dark';
                        localStorage.setItem(THEME_KEY, next);
                        applyAdminTheme(next);
                    }

                    // Load saved theme on page load
                    (function () {
                        const saved = localStorage.getItem(THEME_KEY) || 'dark';
                        applyAdminTheme(saved);
                    })();
                </script>
            </body>

            </html>