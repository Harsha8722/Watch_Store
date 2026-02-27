<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="dark">

            <head>
                <script>
                    const theme = localStorage.getItem('adminTheme') || 'dark';
                    document.documentElement.setAttribute('data-admin-theme', theme);
                    document.documentElement.setAttribute('data-theme', theme);
                </script>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Products - Admin</title>
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
                <div class="admin-sidebar" id="adminSidebar">
                    <div class="sidebar-brand"><i class="fas fa-crown me-2"></i>WatchStore</div>
                    <nav class="sidebar-nav">
                        <a href="/admin/dashboard" class="sidebar-link"><i
                                class="fas fa-tachometer-alt"></i>Dashboard</a>
                        <a href="/admin/products" class="sidebar-link active"><i class="fas fa-clock"></i>Products</a>
                        <a href="/admin/users" class="sidebar-link"><i class="fas fa-users"></i>Users</a>
                        <a href="/admin/orders" class="sidebar-link"><i class="fas fa-box"></i>Orders</a>
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
                        <div class="topbar-title">Manage Products</div>
                        <button class="btn btn-gold btn-sm" data-bs-toggle="modal" data-bs-target="#productModal"><i
                                class="fas fa-plus me-2"></i>Add Product</button>
                        <button class="admin-theme-toggle" id="adminThemeBtn" onclick="toggleAdminTheme()">
                            <i class="fas fa-moon" id="adminThemeIcon"></i>
                            <span id="adminThemeLabel">Light Mode</span>
                        </button>
                    </div>

                    <div class="admin-content">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <!-- Search & Filter -->
                        <div class="admin-card mb-4">
                            <div class="admin-card-body">
                                <form action="/admin/products" method="get" class="row g-3 align-items-end">
                                    <div class="col-md-4">
                                        <input type="text" name="search" class="form-control"
                                            placeholder="Search by brand or model..." value="${currentSearch}">
                                    </div>
                                    <div class="col-md-3">
                                        <select name="category" class="form-select">
                                            <option value="">All Categories</option>
                                            <option value="LUXURY" ${currentCategory=='LUXURY' ?'selected':''}>Luxury
                                            </option>
                                            <option value="SPORTS" ${currentCategory=='SPORTS' ?'selected':''}>Sports
                                            </option>
                                            <option value="CASUAL" ${currentCategory=='CASUAL' ?'selected':''}>Casual
                                            </option>
                                            <option value="SMARTWATCH" ${currentCategory=='SMARTWATCH' ?'selected':''}>
                                                Smartwatch</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2"><button type="submit"
                                            class="btn btn-gold w-100">Search</button></div>
                                    <div class="col-md-2"><a href="/admin/products"
                                            class="btn btn-outline-secondary w-100">Clear</a></div>
                                </form>
                            </div>
                        </div>

                        <!-- Products Table -->
                        <div class="admin-card">
                            <div class="admin-card-body">
                                <div class="table-responsive">
                                    <table class="table admin-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Image</th>
                                                <th>Brand</th>
                                                <th>Model</th>
                                                <th>Category</th>
                                                <th>Price</th>
                                                <th>Discount</th>
                                                <th>Stock</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="watch" items="${products.content}">
                                                <tr>
                                                    <td>#${watch.id}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty watch.imageUrl}">
                                                                <img src="${watch.imageUrl}" alt="${watch.brand}"
                                                                    style="width:50px;height:50px;object-fit:cover;border-radius:8px;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="table-img-placeholder"><i
                                                                        class="fas fa-clock"></i></div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${watch.brand}</td>
                                                    <td>${watch.model}</td>
                                                    <td><span class="badge badge-category">${watch.category}</span></td>
                                                    <td>₹
                                                        <fmt:formatNumber value="${watch.price}" pattern="#,##,##0" />
                                                    </td>
                                                    <td>${watch.discount}%</td>
                                                    <td>${watch.stock}</td>
                                                    <td>
                                                        <button type="button"
                                                            class="btn btn-sm btn-outline-gold me-1 edit-product-btn"
                                                            data-id="${watch.id}"
                                                            data-brand="<c:out value='${watch.brand}' escapeXml='true'/>"
                                                            data-model="<c:out value='${watch.model}' escapeXml='true'/>"
                                                            data-price="${watch.price}"
                                                            data-discount="${watch.discount}"
                                                            data-category="<c:out value='${watch.category}' escapeXml='true'/>"
                                                            data-stock="${watch.stock}"
                                                            data-description="<c:out value='${watch.description}' escapeXml='true'/>"
                                                            data-imageurl="<c:out value='${watch.imageUrl}' escapeXml='true'/>">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <form action="/admin/products/delete/${watch.id}" method="post"
                                                            class="d-inline"
                                                            onsubmit="return confirm('Delete this product?')">
                                                            <button type="submit" class="btn btn-sm btn-danger"><i
                                                                    class="fas fa-trash"></i></button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- Pagination -->
                                <c:if test="${products.totalPages > 1}">
                                    <nav>
                                        <ul class="pagination justify-content-center mt-3">
                                            <c:forEach begin="0" end="${products.totalPages - 1}" var="p">
                                                <li class="page-item ${p == products.number ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/products?page=${p}">${p+1}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add/Edit Product Modal -->
                <div class="modal fade" id="productModal" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content admin-modal">
                            <div class="modal-header">
                                <h5 class="modal-title gold-text" id="productModalTitle">Add New Watch</h5>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form action="/admin/products/save" method="post" id="productForm"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="id" id="productId">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <input type="text" name="brand" id="pBrand"
                                                    class="form-control luxury-input-dark" placeholder="Brand" required>
                                                <label>Brand</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <input type="text" name="model" id="pModel"
                                                    class="form-control luxury-input-dark" placeholder="Model" required>
                                                <label>Model</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="number" name="price" id="pPrice"
                                                    class="form-control luxury-input-dark" step="0.01"
                                                    placeholder="Price" required>
                                                <label>Price (₹)</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="number" name="discount" id="pDiscount"
                                                    class="form-control luxury-input-dark" min="0" max="90"
                                                    placeholder="Discount" value="0">
                                                <label>Discount (%)</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-floating">
                                                <input type="number" name="stock" id="pStock"
                                                    class="form-control luxury-input-dark" min="0" placeholder="Stock"
                                                    required>
                                                <label>Stock Qty</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <select name="category" id="pCategory"
                                                    class="form-select luxury-input-dark" required>
                                                    <option value="LUXURY">Luxury</option>
                                                    <option value="SPORTS">Sports</option>
                                                    <option value="CASUAL">Casual</option>
                                                    <option value="SMARTWATCH">Smartwatch</option>
                                                </select>
                                                <label>Category</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Product Image</label>
                                            <input type="file" name="imageFile" class="form-control luxury-input-dark"
                                                accept="image/*">
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <input type="text" name="imageUrl" id="pImageUrl"
                                                    class="form-control luxury-input-dark"
                                                    placeholder="Or enter image URL">
                                                <label>Image URL (Optional)</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <textarea name="description" id="pDesc"
                                                    class="form-control luxury-input-dark" placeholder="Description"
                                                    style="height:100px"></textarea>
                                                <label>Description</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="d-flex gap-2 mt-3">
                                        <button type="submit" class="btn btn-gold"><i class="fas fa-save me-2"></i>Save
                                            Product</button>
                                        <button type="button" class="btn btn-outline-secondary"
                                            data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Admin Theme Toggle
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

                    // Attach event listener for edit buttons
                    document.addEventListener('DOMContentLoaded', function () {
                        const editButtons = document.querySelectorAll('.edit-product-btn');
                        editButtons.forEach(button => {
                            button.addEventListener('click', function () {
                                document.getElementById('productModalTitle').textContent = 'Edit Watch';
                                document.getElementById('productId').value = this.dataset.id;
                                document.getElementById('pBrand').value = this.dataset.brand;
                                document.getElementById('pModel').value = this.dataset.model;
                                document.getElementById('pPrice').value = this.dataset.price;
                                document.getElementById('pDiscount').value = this.dataset.discount;
                                document.getElementById('pCategory').value = this.dataset.category;
                                document.getElementById('pStock').value = this.dataset.stock;
                                document.getElementById('pDesc').value = this.dataset.description || '';
                                document.getElementById('pImageUrl').value = this.dataset.imageurl || '';
                                new bootstrap.Modal(document.getElementById('productModal')).show();
                            });
                        });
                    });
                    // Open modal directly if action=add in URL
                    if (window.location.search.includes('action=add')) {
                        new bootstrap.Modal(document.getElementById('productModal')).show();
                    }
                </script>
            </body>

            </html>