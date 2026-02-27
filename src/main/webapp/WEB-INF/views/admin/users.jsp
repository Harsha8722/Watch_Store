<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            <title>Manage Users - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
            <link href="/static/css/style.css" rel="stylesheet">
            <link href="/static/css/admin.css" rel="stylesheet">
            <link rel="icon" href="/favicon.svg" type="image/svg+xml">
        </head>

        <body class="admin-body">
            <div class="admin-sidebar" id="adminSidebar">
                <div class="sidebar-brand"><i class="fas fa-crown me-2"></i>WatchStore</div>
                <nav class="sidebar-nav">
                    <a href="/admin/dashboard" class="sidebar-link"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                    <a href="/admin/products" class="sidebar-link"><i class="fas fa-clock"></i>Products</a>
                    <a href="/admin/users" class="sidebar-link active"><i class="fas fa-users"></i>Users</a>
                    <a href="/admin/orders" class="sidebar-link"><i class="fas fa-box"></i>Orders</a>
                    <form action="/logout" method="post"><button type="submit" class="sidebar-link sidebar-logout"><i
                                class="fas fa-sign-out-alt"></i>Logout</button></form>
                </nav>
            </div>
            <div class="admin-main">
                <div class="admin-topbar">
                    <button class="sidebar-toggle"
                        onclick="document.getElementById('adminSidebar').classList.toggle('sidebar-collapsed')"><i
                            class="fas fa-bars"></i></button>
                    <div class="topbar-title">Manage Users</div>
                    <button class="admin-theme-toggle" id="adminThemeBtn" onclick="toggleAdminTheme()">
                        <i class="fas fa-moon" id="adminThemeIcon"></i>
                        <span id="adminThemeLabel">Light Mode</span>
                    </button>
                </div>
                <div class="admin-content">
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <div class="admin-card">
                        <div class="admin-card-body">
                            <div class="table-responsive">
                                <table class="table admin-table">
                                    <thead>
                                        <tr>
                                            <th>#ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="u" items="${users.content}">
                                            <tr>
                                                <td>#${u.id}</td>
                                                <td>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="user-avatar-sm">
                                                            ${u.name.substring(0,1).toUpperCase()}</div>
                                                        ${u.name}
                                                    </div>
                                                </td>
                                                <td>${u.email}</td>
                                                <td><span class="badge badge-role">${u.role}</span></td>
                                                <td>
                                                    <span class="badge ${u.enabled ? 'bg-success' : 'bg-danger'}">
                                                        ${u.enabled ? 'Active' : 'Blocked'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <form action="/admin/users/${u.id}/toggle" method="post"
                                                        class="d-inline">
                                                        <button type="submit"
                                                            class="btn btn-sm ${u.enabled ? 'btn-warning' : 'btn-success'}">
                                                            ${u.enabled ? 'Block' : 'Unblock'}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${users.totalPages > 1}">
                                <nav>
                                    <ul class="pagination justify-content-center mt-3">
                                        <c:forEach begin="0" end="${users.totalPages - 1}" var="p">
                                            <li class="page-item ${p == users.number ? 'active' : ''}">
                                                <a class="page-link" href="/admin/users?page=${p}">${p+1}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                const THEME_KEY = 'adminTheme';
                function applyAdminTheme(theme) {
                    document.documentElement.setAttribute('data-admin-theme', theme);
                    document.documentElement.setAttribute('data-theme', theme);
                    const icon = document.getElementById('adminThemeIcon');
                    const label = document.getElementById('adminThemeLabel');
                    if (theme === 'light') { icon.className = 'fas fa-moon'; label.textContent = 'Dark Mode'; }
                    else { icon.className = 'fas fa-sun'; label.textContent = 'Light Mode'; }
                }
                function toggleAdminTheme() {
                    const next = (document.documentElement.getAttribute('data-admin-theme') || 'dark') === 'dark' ? 'light' : 'dark';
                    localStorage.setItem(THEME_KEY, next); applyAdminTheme(next);
                }
                (function () { applyAdminTheme(localStorage.getItem(THEME_KEY) || 'dark'); })();
            </script>
        </body>

        </html>