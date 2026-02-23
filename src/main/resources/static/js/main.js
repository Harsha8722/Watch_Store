// =========================================
// WatchStore - Main JavaScript
// =========================================

// --- Theme Toggle ---
function toggleTheme() {
    const html = document.documentElement;
    const isDark = html.getAttribute('data-theme') === 'dark';
    const newTheme = isDark ? 'light' : 'dark';
    html.setAttribute('data-theme', newTheme);
    localStorage.setItem('watchstore-theme', newTheme);
    updateThemeIcon(newTheme);
}

function updateThemeIcon(theme) {
    const icon = document.getElementById('themeIcon');
    if (icon) {
        icon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
    }
}

function initTheme() {
    const saved = localStorage.getItem('watchstore-theme') || 'light';
    document.documentElement.setAttribute('data-theme', saved);
    updateThemeIcon(saved);
}

// --- Navbar Scroll Effect ---
function initNavbar() {
    const nav = document.getElementById('mainNav');
    if (!nav) return;
    window.addEventListener('scroll', () => {
        nav.classList.toggle('nav-scrolled', window.scrollY > 50);
    });
}

// --- Auto-dismiss Toasts ---
function initToasts() {
    document.querySelectorAll('.toast').forEach(toastEl => {
        setTimeout(() => {
            const bsToast = bootstrap.Toast.getOrCreateInstance(toastEl);
            bsToast.hide();
        }, 4000);
    });
}

// --- Cart Badge (fetch from API) ---
function loadCartBadge() {
    const badge = document.getElementById('cartBadge');
    if (!badge) return;
    fetch('/api/cart/count')
        .then(res => {
            if (res.ok) return res.json();
            throw new Error();
        })
        .then(count => {
            if (count > 0) {
                badge.textContent = count;
                badge.style.display = 'flex';
                badge.style.width = 'auto';
                badge.style.minWidth = '18px';
                badge.style.height = '18px';
                badge.style.borderRadius = '9px';
                badge.style.background = '#C6A75E';
                badge.style.color = '#111';
                badge.style.fontSize = '0.65rem';
                badge.style.fontWeight = '700';
                badge.style.padding = '0 5px';
                badge.style.alignItems = 'center';
                badge.style.justifyContent = 'center';
                badge.style.top = '-6px';
                badge.style.right = '-8px';
            }
        })
        .catch(() => {});
}

// --- Scroll Reveal Animation ---
function initScrollReveal() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.product-card, .category-card, .feature-card, .testimonial-card').forEach(el => {
        el.classList.add('reveal');
        observer.observe(el);
    });
}

// --- Add to Cart Animation ---
document.addEventListener('click', function(e) {
    const form = e.target.closest('form[action="/cart/add"]');
    if (form) {
        // Find the button
        const btn = e.target.closest('button[type="submit"]');
        if (btn) {
            btn.innerHTML = '<i class="fas fa-check"></i>';
            btn.classList.add('btn-success');
            setTimeout(() => {
                btn.innerHTML = '<i class="fas fa-cart-plus"></i>';
                btn.classList.remove('btn-success');
            }, 1500);
        }
    }
});

// --- Init on Dom Ready ---
document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initNavbar();
    initToasts();
    loadCartBadge();
    initScrollReveal();
});

// Inject reveal CSS
const style = document.createElement('style');
style.textContent = `
.reveal { opacity: 0; transform: translateY(20px); transition: opacity 0.5s ease, transform 0.5s ease; }
.reveal.visible { opacity: 1; transform: translateY(0); }
.nav-scrolled { box-shadow: 0 4px 24px rgba(0,0,0,0.15) !important; }
`;
document.head.appendChild(style);
