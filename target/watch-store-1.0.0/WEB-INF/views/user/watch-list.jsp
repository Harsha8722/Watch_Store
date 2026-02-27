<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <jsp:include page="/WEB-INF/views/common/header.jsp" />

            <main class="page-main">
                <div class="container-fluid py-4" style="margin-top: 70px;">
                    <div class="row">
                        <!-- Filter Sidebar -->
                        <div class="col-lg-3 mb-4">
                            <div class="filter-sidebar">
                                <h5 class="filter-title"><i class="fas fa-sliders-h me-2"></i>Filters</h5>
                                <form action="/watches" method="get" id="filterForm">
                                    <!-- Search -->
                                    <div class="filter-group">
                                        <label class="filter-label">Search</label>
                                        <div class="input-group">
                                            <input type="text" name="search" class="form-control"
                                                placeholder="Brand or model..." value="${currentSearch}">
                                            <button type="submit" class="btn btn-gold"><i
                                                    class="fas fa-search"></i></button>
                                        </div>
                                    </div>

                                    <!-- Category -->
                                    <div class="filter-group">
                                        <label class="filter-label">Category</label>
                                        <div class="category-filters">
                                            <a href="/watches"
                                                class="filter-chip ${empty currentCategory ? 'active' : ''}">All</a>
                                            <a href="/watches?category=LUXURY${not empty currentSearch ? '&search='.concat(currentSearch) : ''}"
                                                class="filter-chip ${currentCategory == 'LUXURY' ? 'active' : ''}">Luxury</a>
                                            <a href="/watches?category=SPORTS${not empty currentSearch ? '&search='.concat(currentSearch) : ''}"
                                                class="filter-chip ${currentCategory == 'SPORTS' ? 'active' : ''}">Sports</a>
                                            <a href="/watches?category=CASUAL${not empty currentSearch ? '&search='.concat(currentSearch) : ''}"
                                                class="filter-chip ${currentCategory == 'CASUAL' ? 'active' : ''}">Casual</a>
                                            <a href="/watches?category=SMARTWATCH${not empty currentSearch ? '&search='.concat(currentSearch) : ''}"
                                                class="filter-chip ${currentCategory == 'SMARTWATCH' ? 'active' : ''}">Smartwatch</a>
                                        </div>
                                    </div>

                                    <!-- Price Range -->
                                    <div class="filter-group">
                                        <label class="filter-label">Price Range</label>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <input type="number" name="minPrice"
                                                    class="form-control form-control-sm" placeholder="Min ₹"
                                                    value="${currentMinPrice}">
                                            </div>
                                            <div class="col-6">
                                                <input type="number" name="maxPrice"
                                                    class="form-control form-control-sm" placeholder="Max ₹"
                                                    value="${currentMaxPrice}">
                                            </div>
                                        </div>
                                        <c:if test="${not empty currentCategory}">
                                            <input type="hidden" name="category" value="${currentCategory}">
                                        </c:if>
                                        <button type="submit" class="btn btn-outline-gold btn-sm w-100 mt-2">Apply Price
                                            Filter</button>
                                    </div>

                                    <!-- Sort -->
                                    <div class="filter-group">
                                        <label class="filter-label">Sort By</label>
                                        <select name="sortBy" class="form-select form-select-sm"
                                            onchange="this.form.submit()">
                                            <option value="id" ${currentSortBy=='id' ? 'selected' : '' }>Latest</option>
                                            <option value="price" ${currentSortBy=='price' ? 'selected' : '' }>Price
                                            </option>
                                            <option value="brand" ${currentSortBy=='brand' ? 'selected' : '' }>Brand
                                            </option>
                                        </select>
                                        <select name="sortDir" class="form-select form-select-sm mt-2"
                                            onchange="this.form.submit()">
                                            <option value="ASC" ${currentSortDir=='ASC' ? 'selected' : '' }>Low to High
                                            </option>
                                            <option value="DESC" ${currentSortDir=='DESC' ? 'selected' : '' }>High to
                                                Low</option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Products Grid -->
                        <div class="col-lg-9">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h4 class="products-heading">
                                        <c:choose>
                                            <c:when test="${not empty currentCategory}">
                                                ${currentCategory} Watches
                                            </c:when>
                                            <c:when test="${not empty currentSearch}">
                                                Results for "${currentSearch}"
                                            </c:when>
                                            <c:otherwise>All Collections</c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <small class="text-muted">${watches.totalElements} products found</small>
                                </div>
                            </div>

                            <div class="row g-3">
                                <c:forEach var="watch" items="${watches.content}">
                                    <div class="col-lg-4 col-md-6">
                                        <div class="product-card">
                                            <div class="product-image-wrap">
                                                <c:choose>
                                                    <c:when test="${not empty watch.imageUrl}">
                                                        <img src="${watch.imageUrl}" alt="${watch.brand} ${watch.model}"
                                                            class="product-img" loading="lazy">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-img-placeholder"><i
                                                                class="fas fa-clock"></i></div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${watch.discount > 0}">
                                                    <span class="discount-badge">${watch.discount}% OFF</span>
                                                </c:if>
                                                <div class="product-actions">
                                                    <a href="/wishlist/add/${watch.id}" class="action-btn"><i
                                                            class="fas fa-heart"></i></a>
                                                    <a href="/watches/${watch.id}" class="action-btn"><i
                                                            class="fas fa-eye"></i></a>
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
                                                <div class="stock-badge ${watch.stock > 0 ? 'in-stock' : 'out-stock'}">
                                                    ${watch.stock > 0 ? 'In Stock' : 'Out of Stock'}
                                                </div>
                                                <div class="d-flex gap-2 mt-2">
                                                    <a href="/watches/${watch.id}"
                                                        class="btn btn-outline-gold btn-sm flex-grow-1">Details</a>
                                                    <c:if test="${watch.stock > 0}">
                                                        <form action="/cart/add" method="post" class="flex-grow-1">
                                                            <input type="hidden" name="watchId" value="${watch.id}">
                                                            <input type="hidden" name="quantity" value="1">
                                                            <button type="submit" class="btn btn-cart btn-sm w-100">
                                                                <i class="fas fa-cart-plus"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty watches.content}">
                                    <div class="col-12 text-center py-5">
                                        <i class="fas fa-search fa-3x gold-text mb-3"></i>
                                        <h5>No watches found</h5>
                                        <p class="text-muted">Try adjusting your filters or search term.</p>
                                        <a href="/watches" class="btn btn-gold">Clear Filters</a>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${watches.totalPages > 1}">
                                <nav class="mt-4">
                                    <ul class="pagination luxury-pagination justify-content-center">
                                        <c:if test="${not watches.first}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                    href="/watches?page=${watches.number - 1}&category=${currentCategory}&search=${currentSearch}&sortBy=${currentSortBy}&sortDir=${currentSortDir}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach begin="0" end="${watches.totalPages - 1}" var="pageNum">
                                            <li class="page-item ${pageNum == watches.number ? 'active' : ''}">
                                                <a class="page-link"
                                                    href="/watches?page=${pageNum}&category=${currentCategory}&search=${currentSearch}&sortBy=${currentSortBy}&sortDir=${currentSortDir}">
                                                    ${pageNum + 1}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${not watches.last}">
                                            <li class="page-item">
                                                <a class="page-link"
                                                    href="/watches?page=${watches.number + 1}&category=${currentCategory}&search=${currentSearch}&sortBy=${currentSortBy}&sortDir=${currentSortDir}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />