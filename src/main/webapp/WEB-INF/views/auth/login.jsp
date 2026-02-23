<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en" data-theme="dark">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Login - WatchStore</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap"
                    rel="stylesheet">
                <link href="/static/css/style.css" rel="stylesheet">
            </head>

            <body class="auth-body">
                <div class="auth-container">
                    <div class="auth-card">
                        <div class="auth-logo">
                            <a href="/" class="luxury-brand"><i class="fas fa-crown me-2"></i>WatchStore</a>
                        </div>
                        <h2 class="auth-title">Welcome Back</h2>
                        <p class="auth-subtitle">Sign in to your luxury account</p>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"><i class="fas fa-exclamation-triangle me-2"></i>${error}
                            </div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success"><i class="fas fa-check-circle me-2"></i>${message}</div>
                        </c:if>
                        <c:if test="${not empty success}">
                            <div class="alert alert-success"><i class="fas fa-check-circle me-2"></i>${success}</div>
                        </c:if>

                        <form action="/login" method="post" class="auth-form">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control luxury-input" id="email" name="email"
                                    placeholder="Email" required>
                                <label for="email"><i class="fas fa-envelope me-2"></i>Email Address</label>
                            </div>
                            <div class="form-floating mb-3 position-relative">
                                <input type="password" class="form-control luxury-input" id="password" name="password"
                                    placeholder="Password" required>
                                <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                                <button type="button" class="pwd-toggle" onclick="togglePwd('password')">
                                    <i class="fas fa-eye" id="pwdEye"></i>
                                </button>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember">
                                    <label class="form-check-label" for="remember">Remember me</label>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-gold w-100 btn-lg auth-btn">
                                <i class="fas fa-sign-in-alt me-2"></i>Sign In
                            </button>
                        </form>

                        <div class="auth-divider"><span>OR</span></div>
                        <div class="auth-links">
                            <p>Don't have an account? <a href="/register" class="gold-text">Create Account</a></p>
                        </div>

                        <div class="demo-credentials mt-3 p-3">
                            <small class="text-muted">
                                <strong>Demo Admin:</strong> admin@watchstore.com / admin123<br>
                                <strong>Demo User:</strong> user@watchstore.com / user123
                            </small>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function togglePwd(id) {
                        const inp = document.getElementById(id);
                        inp.type = inp.type === 'password' ? 'text' : 'password';
                    }
                </script>
            </body>

            </html>