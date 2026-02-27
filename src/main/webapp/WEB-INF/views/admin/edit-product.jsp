<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container-fluid py-4" style="margin-top: 70px;">
                    <div class="row">
                        <!-- Admin Sidebar -->
                        <div class="col-lg-2 mb-4">
                            <div class="admin-sidebar">
                                <div class="admin-logo mb-4">
                                    <i class="fas fa-crown gold-text me-2"></i>
                                    <span class="fw-bold">Admin Panel</span>
                                </div>
                                <nav class="admin-nav">
                                    <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-link">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                    </a>
                                    <a href="<c:url value='/admin/products'/>" class="admin-nav-link active">
                                        <i class="fas fa-watch me-2"></i>Products
                                    </a>
                                    <a href="<c:url value='/admin/orders'/>" class="admin-nav-link">
                                        <i class="fas fa-shopping-bag me-2"></i>Orders
                                    </a>
                                    <a href="<c:url value='/admin/users'/>" class="admin-nav-link">
                                        <i class="fas fa-users me-2"></i>Users
                                    </a>
                                </nav>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-10">
                            <!-- Page Header -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <h2 class="admin-page-title">Edit Product</h2>
                                    <p class="text-muted mb-0">Update watch details in the catalogue</p>
                                </div>
                                <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Products
                                </a>
                            </div>

                            <!-- Edit Form -->
                            <div class="admin-card">
                                <div class="admin-card-header">
                                    <h5 class="mb-0"><i class="fas fa-edit me-2 gold-text"></i>Product Information</h5>
                                </div>
                                <div class="admin-card-body">
                                    <form action="<c:url value='/admin/products/edit/${watchDTO.id}'/>" method="post"
                                        enctype="multipart/form-data">

                                        <div class="row g-4">
                                            <!-- Brand -->
                                            <div class="col-md-6">
                                                <label for="brand" class="form-label fw-semibold">Brand <span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="brand" name="brand"
                                                    value="${watchDTO.brand}" placeholder="e.g. Rolex, Omega" required>
                                            </div>

                                            <!-- Model -->
                                            <div class="col-md-6">
                                                <label for="model" class="form-label fw-semibold">Model <span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="model" name="model"
                                                    value="${watchDTO.model}" placeholder="e.g. Submariner, Speedmaster"
                                                    required>
                                            </div>

                                            <!-- Price -->
                                            <div class="col-md-4">
                                                <label for="price" class="form-label fw-semibold">Price (₹) <span
                                                        class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text">₹</span>
                                                    <input type="number" class="form-control" id="price" name="price"
                                                        value="${watchDTO.price}" step="0.01" min="0" required>
                                                </div>
                                            </div>

                                            <!-- Discount -->
                                            <div class="col-md-4">
                                                <label for="discount" class="form-label fw-semibold">Discount
                                                    (%)</label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="discount"
                                                        name="discount" value="${watchDTO.discount}" step="0.01" min="0"
                                                        max="99">
                                                    <span class="input-group-text">%</span>
                                                </div>
                                            </div>

                                            <!-- Stock -->
                                            <div class="col-md-4">
                                                <label for="stock" class="form-label fw-semibold">Stock <span
                                                        class="text-danger">*</span></label>
                                                <input type="number" class="form-control" id="stock" name="stock"
                                                    value="${watchDTO.stock}" min="0" required>
                                            </div>

                                            <!-- Category -->
                                            <div class="col-md-6">
                                                <label for="category" class="form-label fw-semibold">Category <span
                                                        class="text-danger">*</span></label>
                                                <select class="form-select" id="category" name="category" required>
                                                    <option value="">-- Select Category --</option>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat}" ${watchDTO.category==cat ? 'selected'
                                                            : '' }>${cat}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <!-- Image URL -->
                                            <div class="col-md-6">
                                                <label for="imageUrl" class="form-label fw-semibold">Image URL</label>
                                                <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                                                    value="${watchDTO.imageUrl}" placeholder="https://...">
                                                <small class="text-muted">Enter a URL or upload a file below</small>
                                            </div>

                                            <!-- Image File Upload -->
                                            <div class="col-md-6">
                                                <label for="imageFile" class="form-label fw-semibold">Upload New
                                                    Image</label>
                                                <input type="file" class="form-control" id="imageFile" name="imageFile"
                                                    accept="image/*">
                                                <small class="text-muted">Max 10MB. Uploading a file overrides the URL
                                                    above.</small>
                                            </div>

                                            <!-- Current Image Preview -->
                                            <c:if test="${not empty watchDTO.imageUrl}">
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Current Image</label>
                                                    <div class="current-img-preview">
                                                        <img src="${watchDTO.imageUrl}" alt="Current watch image"
                                                            onerror="this.src=''; this.parentElement.innerHTML='<p class=text-muted>Image not available</p>'">
                                                    </div>
                                                </div>
                                            </c:if>

                                            <!-- Description -->
                                            <div class="col-12">
                                                <label for="description"
                                                    class="form-label fw-semibold">Description</label>
                                                <textarea class="form-control" id="description" name="description"
                                                    rows="4"
                                                    placeholder="Write a compelling product description...">${watchDTO.description}</textarea>
                                            </div>
                                        </div>

                                        <hr class="my-4">
                                        <div class="d-flex gap-3">
                                            <button type="submit" class="btn btn-gold btn-lg">
                                                <i class="fas fa-save me-2"></i>Update Product
                                            </button>
                                            <a href="<c:url value='/admin/products'/>"
                                                class="btn btn-outline-secondary btn-lg">
                                                <i class="fas fa-times me-2"></i>Cancel
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <style>
                .admin-sidebar {
                    background: var(--card-bg);
                    border: 1px solid var(--border);
                    border-radius: 12px;
                    padding: 20px;
                    position: sticky;
                    top: 80px;
                }

                .admin-logo {
                    font-size: 1rem;
                }

                .admin-nav {
                    display: flex;
                    flex-direction: column;
                    gap: 4px;
                }

                .admin-nav-link {
                    display: flex;
                    align-items: center;
                    padding: 10px 14px;
                    border-radius: 8px;
                    color: var(--text-secondary);
                    text-decoration: none;
                    font-size: 0.9rem;
                    transition: all 0.2s;
                }

                .admin-nav-link:hover,
                .admin-nav-link.active {
                    background: rgba(197, 168, 90, 0.12);
                    color: var(--gold);
                }

                .admin-page-title {
                    font-family: 'Playfair Display', serif;
                    font-size: 1.8rem;
                    color: var(--text-primary);
                    margin: 0;
                }

                .admin-card {
                    background: var(--card-bg);
                    border: 1px solid var(--border);
                    border-radius: 12px;
                    overflow: hidden;
                }

                .admin-card-header {
                    padding: 18px 24px;
                    border-bottom: 1px solid var(--border);
                    background: rgba(197, 168, 90, 0.05);
                }

                .admin-card-body {
                    padding: 28px;
                }

                .current-img-preview img {
                    max-height: 150px;
                    object-fit: contain;
                    border-radius: 8px;
                    border: 1px solid var(--border);
                    padding: 4px;
                }
            </style>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />