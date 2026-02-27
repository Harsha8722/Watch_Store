<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

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
                <div class="auth-container" id="authContainer">
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

                            <!-- Full Name -->
                            <div class="auth-field mb-3">
                                <label class="auth-field-label">
                                    <i class="fas fa-user"></i> Full Name
                                </label>
                                <form:input path="name" cssClass="form-control luxury-input"
                                    placeholder="Enter your full name" />
                                <form:errors path="name" cssClass="text-danger small d-block mt-1" />
                            </div>

                            <!-- Email -->
                            <div class="auth-field mb-3">
                                <label class="auth-field-label">
                                    <i class="fas fa-envelope"></i> Email Address
                                </label>
                                <form:input path="email" type="email" cssClass="form-control luxury-input"
                                    placeholder="Enter your email" />
                                <form:errors path="email" cssClass="text-danger small d-block mt-1" />
                            </div>

                            <!-- Password -->
                            <div class="auth-field mb-3">
                                <label class="auth-field-label">
                                    <i class="fas fa-lock"></i> Password
                                </label>
                                <div class="position-relative">
                                    <form:password path="password" cssClass="form-control luxury-input"
                                        placeholder="Create a password" id="password" />
                                    <button type="button" class="pwd-toggle" onclick="togglePwd('password', 'pwdEye1')">
                                        <i class="fas fa-eye" id="pwdEye1"></i>
                                    </button>
                                </div>
                                <form:errors path="password" cssClass="text-danger small d-block mt-1" />
                            </div>

                            <!-- Confirm Password -->
                            <div class="auth-field mb-4">
                                <label class="auth-field-label">
                                    <i class="fas fa-lock"></i> Confirm Password
                                </label>
                                <div class="position-relative">
                                    <form:password path="confirmPassword" cssClass="form-control luxury-input"
                                        placeholder="Confirm your password" id="confirmPassword" />
                                    <button type="button" class="pwd-toggle"
                                        onclick="togglePwd('confirmPassword', 'pwdEye2')">
                                        <i class="fas fa-eye" id="pwdEye2"></i>
                                    </button>
                                </div>
                                <form:errors path="confirmPassword" cssClass="text-danger small d-block mt-1" />
                            </div>

                            <button type="submit" class="btn btn-gold w-100 btn-lg auth-btn">
                                <i class="fas fa-user-plus me-2"></i>Create Account
                            </button>
                        </form:form>

                        <div class="auth-divider"><span>OR</span></div>
                        <div class="auth-links">
                            <p>Already have an account? <a href="/login" class="gold-text" id="loginLink">Sign In</a>
                            </p>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function togglePwd(id, eyeId) {
                        const inp = document.getElementById(id);
                        const eye = document.getElementById(eyeId);
                        if (inp.type === 'password') {
                            inp.type = 'text';
                            eye.classList.replace('fa-eye', 'fa-eye-slash');
                        } else {
                            inp.type = 'password';
                            eye.classList.replace('fa-eye-slash', 'fa-eye');
                        }
                    }

                    // Page transition on link click
                    document.getElementById('loginLink').addEventListener('click', function (e) {
                        e.preventDefault();
                        const container = document.getElementById('authContainer');
                        const href = this.href;
                        container.classList.add('page-exit');
                        setTimeout(function () {
                            window.location.href = href;
                        }, 350);
                    });
                </script>
            </body>

            </html>