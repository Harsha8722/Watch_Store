<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container py-5" style="margin-top: 70px;">
                    <h2 class="page-title mb-4"><i class="fas fa-user me-2 gold-text"></i>My Profile</h2>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="row g-4">
                        <!-- Profile Card -->
                        <div class="col-lg-4">
                            <div class="profile-card text-center">
                                <div class="profile-avatar-wrap mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.profileImage}">
                                            <img src="${user.profileImage}" alt="Profile" class="profile-avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="profile-avatar-placeholder">
                                                <i class="fas fa-user-circle fa-5x gold-text"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <h4 class="mb-1">${user.name}</h4>
                                <p class="text-muted mb-3">${user.email}</p>
                                <span class="badge gold-badge">${user.role}</span>

                                <form action="/user/profile/image" method="post" enctype="multipart/form-data"
                                    class="mt-4">
                                    <label class="btn btn-outline-gold btn-sm w-100">
                                        <i class="fas fa-camera me-2"></i>Change Photo
                                        <input type="file" name="profileImage" accept="image/*" class="d-none"
                                            onchange="this.form.submit()">
                                    </label>
                                </form>
                            </div>
                        </div>

                        <!-- Edit Profile -->
                        <div class="col-lg-8">
                            <div class="profile-edit-card">
                                <ul class="nav nav-tabs luxury-tabs mb-4" id="profileTabs">
                                    <li class="nav-item">
                                        <button class="nav-link active" data-bs-toggle="tab"
                                            data-bs-target="#editDetails">Edit Profile</button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link" data-bs-toggle="tab"
                                            data-bs-target="#orderHistory">Order History</button>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="editDetails">
                                        <form action="/user/profile/update" method="post">
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <div class="form-floating">
                                                        <input type="text" name="name" class="form-control luxury-input"
                                                            value="${user.name}" placeholder="Name" required>
                                                        <label>Full Name</label>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="form-floating">
                                                        <input type="email" name="email"
                                                            class="form-control luxury-input" value="${user.email}"
                                                            placeholder="Email" required>
                                                        <label>Email Address</label>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <h6 class="mt-2">Change Password (leave blank to keep current)</h6>
                                                </div>
                                                <div class="col-12">
                                                    <div class="form-floating">
                                                        <input type="password" name="currentPassword"
                                                            class="form-control luxury-input"
                                                            placeholder="Current Password">
                                                        <label>Current Password</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="password" name="newPassword"
                                                            class="form-control luxury-input"
                                                            placeholder="New Password">
                                                        <label>New Password</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="password" name="confirmNewPassword"
                                                            class="form-control luxury-input"
                                                            placeholder="Confirm New Password">
                                                        <label>Confirm New Password</label>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-gold"><i
                                                            class="fas fa-save me-2"></i>Update Profile</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="tab-pane fade" id="orderHistory">
                                        <c:choose>
                                            <c:when test="${not empty orders}">
                                                <div class="table-responsive">
                                                    <table class="table luxury-table">
                                                        <thead>
                                                            <tr>
                                                                <th>#ID</th>
                                                                <th>Date</th>
                                                                <th>Total</th>
                                                                <th>Status</th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="order" items="${orders}">
                                                                <tr>
                                                                    <td>#${order.id}</td>
                                                                    <td>
                                                                        <fmt:formatDate value="${order.orderDateAsDate}"
                                                                            pattern="dd MMM yyyy" />
                                                                    </td>
                                                                    <td>₹
                                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                                            pattern="#,##,##0.00" />
                                                                    </td>
                                                                    <td><span
                                                                            class="badge status-badge-${order.status}">${order.status}</span>
                                                                    </td>
                                                                    <td><a href="/orders/${order.id}"
                                                                            class="btn btn-sm btn-outline-gold">View</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center py-3">
                                                    <p class="text-muted">No orders yet.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />