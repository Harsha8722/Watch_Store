<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin Dashboard - WatchStore</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet">
                <link href="/static/css/style.css" rel="stylesheet">
                <link href="/static/css/admin.css" rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            </head>

            <body class="admin-body">

                <!-- Admin Sidebar -->
                <div class="admin-sidebar" id="adminSidebar">
                    <div class="sidebar-brand">
                        <i class="fas fa-crown me-2"></i>WatchStore
                        <span class="badge gold-badge ms-2">Admin</span>
                    </div>
                    <nav class="sidebar-nav">
                        <a href="/admin/dashboard" class="sidebar-link active"><i
                                class="fas fa-tachometer-alt"></i>Dashboard</a>
                        <a href="/admin/products" class="sidebar-link"><i class="fas fa-clock"></i>Products</a>
                        <a href="/admin/users" class="sidebar-link"><i class="fas fa-users"></i>Users</a>
                        <a href="/admin/orders" class="sidebar-link"><i class="fas fa-box"></i>Orders</a>
                        <a href="/swagger-ui/index.html" class="sidebar-link"><i class="fas fa-code"></i>API Docs</a>
                        <hr class="sidebar-divider">
                        <a href="/" class="sidebar-link"><i class="fas fa-store"></i>Store Front</a>
                        <form action="/logout" method="post">
                            <button type="submit" class="sidebar-link sidebar-logout"><i
                                    class="fas fa-sign-out-alt"></i>Logout</button>
                        </form>
                    </nav>
                </div>

                <!-- Admin Main -->
                <div class="admin-main">
                    <!-- Top Bar -->
                    <div class="admin-topbar">
                        <button class="sidebar-toggle" onclick="toggleSidebar()">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="topbar-title">Dashboard</div>
                        <div class="topbar-actions">
                            <span class="text-muted"><i class="fas fa-calendar me-2"></i>
                                <%= new java.util.Date() %>
                            </span>
                        </div>
                    </div>

                    <div class="admin-content">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show"><i
                                    class="fas fa-check-circle me-2"></i>${success}<button type="button"
                                    class="btn-close" data-bs-dismiss="alert"></button></div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show"><i
                                    class="fas fa-exclamation-circle me-2"></i>${error}<button type="button"
                                    class="btn-close" data-bs-dismiss="alert"></button></div>
                        </c:if>

                        <!-- Stats Cards -->
                        <div class="row g-4 mb-4">
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card stat-users">
                                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                                    <div class="stat-info">
                                        <h3>${totalUsers}</h3>
                                        <p>Total Users</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card stat-products">
                                    <div class="stat-icon"><i class="fas fa-clock"></i></div>
                                    <div class="stat-info">
                                        <h3>${totalProducts}</h3>
                                        <p>Total Products</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card stat-orders">
                                    <div class="stat-icon"><i class="fas fa-box"></i></div>
                                    <div class="stat-info">
                                        <h3>${totalOrders}</h3>
                                        <p>Total Orders</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="stat-card stat-revenue">
                                    <div class="stat-icon"><i class="fas fa-rupee-sign"></i></div>
                                    <div class="stat-info">
                                        <h3>
                                            <fmt:formatNumber value="${totalRevenue}" pattern="#,##,##0" />
                                        </h3>
                                        <p>Total Revenue (₹)</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Revenue Chart -->
                        <div class="row g-4 mb-4">
                            <div class="col-lg-8">
                                <div class="admin-card">
                                    <div class="admin-card-header">
                                        <h5>Monthly Revenue - 2026</h5>
                                    </div>
                                    <div class="admin-card-body">
                                        <canvas id="revenueChart" height="100"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="admin-card">
                                    <div class="admin-card-header">
                                        <h5>Quick Actions</h5>
                                    </div>
                                    <div class="admin-card-body">
                                        <a href="/admin/products?action=add" class="quick-action-btn mb-2">
                                            <i class="fas fa-plus-circle me-2"></i>Add New Watch
                                        </a>
                                        <a href="/admin/orders" class="quick-action-btn mb-2">
                                            <i class="fas fa-box-open me-2"></i>View Orders
                                        </a>
                                        <a href="/admin/users" class="quick-action-btn mb-2">
                                            <i class="fas fa-users-cog me-2"></i>Manage Users
                                        </a>
                                        <a href="/swagger-ui/index.html" class="quick-action-btn">
                                            <i class="fas fa-code me-2"></i>API Docs
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Orders -->
                        <div class="admin-card">
                            <div class="admin-card-header d-flex justify-content-between align-items-center">
                                <h5>Recent Orders</h5>
                                <a href="/admin/orders" class="btn btn-sm btn-outline-gold">View All</a>
                            </div>
                            <div class="admin-card-body">
                                <div class="table-responsive">
                                    <table class="table admin-table">
                                        <thead>
                                            <tr>
                                                <th>#ID</th>
                                                <th>User</th>
                                                <th>Total</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${recentOrders}">
                                                <tr>
                                                    <td>#${order.id}</td>
                                                    <td>${order.user.name}</td>
                                                    <td>₹
                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                            pattern="#,##,##0.00" />
                                                    </td>
                                                    <td><span
                                                            class="badge status-badge-${order.status}">${order.status}</span>
                                                    </td>
                                                    <td>${order.orderDate}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recentOrders}">
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted">No orders yet.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Revenue Chart
                    const monthlyRevenue = {
    < c: forEach var="entry" items = "${monthlyRevenue}" varStatus = "vs" >
                        "${entry.key}": ${ entry.value } <c:if test="${!vs.last}">,</c:if>
    </c: forEach >
};
                    const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    const data = Object.keys(monthlyRevenue).sort((a, b) => a - b).map(k => monthlyRevenue[k]);
                    const ctx = document.getElementById('revenueChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Revenue (₹)',
                                data: data,
                                backgroundColor: 'rgba(198, 167, 94, 0.7)',
                                borderColor: '#C6A75E',
                                borderWidth: 2,
                                borderRadius: 6
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: { legend: { labels: { color: '#ffffff' } } },
                            scales: {
                                y: { ticks: { color: '#aaa' }, grid: { color: '#333' } },
                                x: { ticks: { color: '#aaa' }, grid: { color: '#333' } }
                            }
                        }
                    });

                    function toggleSidebar() {
                        document.getElementById('adminSidebar').classList.toggle('sidebar-collapsed');
                    }
                </script>
            </body>

            </html>