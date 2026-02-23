<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Register - WatchStore</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet">
                <link href="/static/css/style.css" rel="stylesheet">
            </head>

            <body class="auth-body">
                <div class="auth-container">
                    <div class="auth-card" style="max-width: 480px;">
                        <div class="auth-logo">
                            <a href="/" class="luxury-brand"><i class="fas fa-crown me-2"></i>WatchStore</a>
                        </div>
                        <h2 class="auth-title">Create Account</h2>
                        <p class="auth-subtitle">Join the world of luxury timepieces</p>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"><i class="fas fa-exclamation-triangle me-2"></i>${error}
                            </div>
                        </c:if>

                        <form:form action="/register" method="post" modelAttribute="userRegistrationDTO"
                            class="auth-form">
                            <div class="form-floating mb-3">
                                <form:input path="name" cssClass="form-control luxury-input" placeholder="Full Name" />
                                <label><i class="fas fa-user me-2"></i>Full Name</label>
                                <form:errors path="name" cssClass="text-danger small" />
                            </div>
                            <div class="form-floating mb-3">
                                <form:input path="email" type="email" cssClass="form-control luxury-input"
                                    placeholder="Email" />
                                <label><i class="fas fa-envelope me-2"></i>Email Address</label>
                                <form:errors path="email" cssClass="text-danger small" />
                            </div>
                            <div class="form-floating mb-3 position-relative">
                                <form:password path="password" cssClass="form-control luxury-input"
                                    placeholder="Password" id="password" />
                                <label><i class="fas fa-lock me-2"></i>Password</label>
                                <form:errors path="password" cssClass="text-danger small" />
                            </div>
                            <div class="form-floating mb-4 position-relative">
                                <form:password path="confirmPassword" cssClass="form-control luxury-input"
                                    placeholder="Confirm Password" id="confirmPassword" />
                                <label><i class="fas fa-lock me-2"></i>Confirm Password</label>
                                <form:errors path="confirmPassword" cssClass="text-danger small" />
                            </div>
                            <button type="submit" class="btn btn-gold w-100 btn-lg auth-btn">
                                <i class="fas fa-user-plus me-2"></i>Create Account
                            </button>
                        </form:form>

                        <div class="auth-divider"><span>OR</span></div>
                        <div class="auth-links">
                            <p>Already have an account? <a href="/login" class="gold-text">Sign In</a></p>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>