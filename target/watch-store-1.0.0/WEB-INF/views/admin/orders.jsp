<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Orders - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link href="/static/css/style.css" rel="stylesheet">
                <link href="/static/css/admin.css" rel="stylesheet">
            </head>

            <body class="admin-body">
                <div class="admin-sidebar" id="adminSidebar">
                    <div class="sidebar-brand"><i class="fas fa-crown me-2"></i>WatchStore</div>
                    <nav class="sidebar-nav">
                        <a href="/admin/dashboard" class="sidebar-link"><i
                                class="fas fa-tachometer-alt"></i>Dashboard</a>
                        <a href="/admin/products" class="sidebar-link"><i class="fas fa-clock"></i>Products</a>
                        <a href="/admin/users" class="sidebar-link"><i class="fas fa-users"></i>Users</a>
                        <a href="/admin/orders" class="sidebar-link active"><i class="fas fa-box"></i>Orders</a>
                        <form action="/logout" method="post"><button type="submit"
                                class="sidebar-link sidebar-logout"><i class="fas fa-sign-out-alt"></i>Logout</button>
                        </form>
                    </nav>
                </div>
                <div class="admin-main">
                    <div class="admin-topbar">
                        <button class="sidebar-toggle"
                            onclick="document.getElementById('adminSidebar').classList.toggle('sidebar-collapsed')"><i
                                class="fas fa-bars"></i></button>
                        <div class="topbar-title">Manage Orders</div>
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
                                                <th>Customer</th>
                                                <th>Items</th>
                                                <th>Total</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Update Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders.content}">
                                                <tr>
                                                    <td>#${order.id}</td>
                                                    <td>${order.user.name}</td>
                                                    <td>${order.orderItems.size()}</td>
                                                    <td>₹
                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                            pattern="#,##,##0.00" />
                                                    </td>
                                                    <td><span
                                                            class="badge status-badge-${order.status}">${order.status}</span>
                                                    </td>
                                                    <td>${order.orderDate}</td>
                                                    <td>
                                                        <form action="/admin/orders/${order.id}/status" method="post"
                                                            class="d-flex gap-2">
                                                            <select name="status" class="form-select form-select-sm"
                                                                style="width:auto">
                                                                <option value="PENDING" ${order.status=='PENDING'
                                                                    ?'selected':''}>Pending</option>
                                                                <option value="PROCESSING" ${order.status=='PROCESSING'
                                                                    ?'selected':''}>Processing</option>
                                                                <option value="SHIPPED" ${order.status=='SHIPPED'
                                                                    ?'selected':''}>Shipped</option>
                                                                <option value="DELIVERED" ${order.status=='DELIVERED'
                                                                    ?'selected':''}>Delivered</option>
                                                                <option value="CANCELLED" ${order.status=='CANCELLED'
                                                                    ?'selected':''}>Cancelled</option>
                                                            </select>
                                                            <button type="submit"
                                                                class="btn btn-sm btn-gold">Update</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${orders.totalPages > 1}">
                                    <nav>
                                        <ul class="pagination justify-content-center mt-3">
                                            <c:forEach begin="0" end="${orders.totalPages - 1}" var="p">
                                                <li class="page-item ${p == orders.number ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/orders?page=${p}">${p+1}</a>
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
            </body>

            </html>