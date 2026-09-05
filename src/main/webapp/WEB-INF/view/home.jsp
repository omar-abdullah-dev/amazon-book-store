<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - Home</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark amazon-navbar sticky-top">
    <div class="container">
        <a class="navbar-brand amazon-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-book-half"></i> Amazon Book Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#amazonNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="amazonNav">
            <ul class="navbar-nav me-auto ms-lg-3">
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/"><i class="bi bi-house me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/book/list"><i class="bi bi-collection me-1"></i> Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/category/list"><i class="bi bi-tags me-1"></i> Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/author/list"><i class="bi bi-people me-1"></i> Authors</a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-2 mt-2 mt-lg-0">
                <button type="button" class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
                    <i class="bi bi-moon-stars" id="themeIcon"></i> <span id="themeText">Dark</span>
                </button>
                <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-amazon shadow-sm btn-sm">
                    <i class="bi bi-plus-circle me-1"></i> Add Book
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="py-5 text-center border-bottom">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
<%--                <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-3 py-2 rounded-pill mb-3 fw-semibold">--%>
<%--                    <i class="bi bi-stars me-1"></i> Spring MVC & Hibernate Book Inventory--%>
<%--                </span>--%>
                <h1 class="display-5 fw-bold mb-3">Welcome to Amazon Book Store</h1>
                <p class="lead text-secondary mb-4">
                    A comprehensive management system to organize books, categorize genres, map authors, and track publication details with ease.
                </p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/book/list" class="btn btn-amazon btn-lg px-4 shadow-sm">
                        <i class="bi bi-journal-richtext me-2"></i> Browse All Books
                    </a>
                    <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-outline-secondary btn-lg px-4 fw-semibold">
                        <i class="bi bi-plus-lg me-2"></i> Add New Book
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Dashboard Stats -->
<section class="py-5">
    <div class="container">
        <div class="row g-4">
            <!-- Books Stat Card -->
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 h-100 p-3">
                    <div class="card-body d-flex align-items-center">
                        <div class="rounded-3 bg-warning-subtle text-warning p-3 me-3 fs-2">
                            <i class="bi bi-book"></i>
                        </div>
                        <div>
                            <span class="text-muted small text-uppercase fw-semibold">Total Books</span>
                            <h2 class="fw-bold mb-0">${totalBooks}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Categories Stat Card -->
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 h-100 p-3">
                    <div class="card-body d-flex align-items-center">
                        <div class="rounded-3 bg-primary-subtle text-primary p-3 me-3 fs-2">
                            <i class="bi bi-tags"></i>
                        </div>
                        <div>
                            <span class="text-muted small text-uppercase fw-semibold">Categories</span>
                            <h2 class="fw-bold mb-0">${totalCategories}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Authors Stat Card -->
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3 h-100 p-3">
                    <div class="card-body d-flex align-items-center">
                        <div class="rounded-3 badge-author p-3 me-3 fs-2">
                            <i class="bi bi-people"></i>
                        </div>
                        <div>
                            <span class="text-muted small text-uppercase fw-semibold">Authors</span>
                            <h2 class="fw-bold mb-0">${totalAuthors}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Access Feature Cards -->
        <div class="row g-4 mt-2">
            <div class="col-md-6">
                <div class="card border-0 shadow-sm rounded-3 h-100 p-4">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-table fs-3 text-primary me-2"></i>
                            <h5 class="fw-bold m-0">Book Inventory List</h5>
                        </div>
                        <p class="text-secondary mb-4">
                            View, update, or remove existing books. Inspect interactive details modals for ISBN, publication dates, and pages.
                        </p>
                        <a href="${pageContext.request.contextPath}/book/list" class="btn btn-outline-primary fw-semibold">
                            Open Inventory <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card border-0 shadow-sm rounded-3 h-100 p-4">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-plus-circle fs-3 text-warning me-2"></i>
                            <h5 class="fw-bold m-0">Add New Book</h5>
                        </div>
                        <p class="text-secondary mb-4">
                            Register a new book with full JPA relationships: Category (ManyToOne), Authors (ManyToMany), and BookDetails (OneToOne).
                        </p>
                        <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-amazon fw-semibold shadow-sm">
                            Create Book <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="py-4 border-top text-center text-muted small mt-auto">
    <div class="container">
        Amazon Book Store Application &bull; Built with Spring MVC 4 & Hibernate 4
    </div>
</footer>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Theme Switcher Script -->
<script>
    (function() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-bs-theme', savedTheme);
    })();

    function updateThemeUI(theme) {
        const themeIcon = document.getElementById('themeIcon');
        const themeText = document.getElementById('themeText');
        if (themeIcon && themeText) {
            if (theme === 'dark') {
                themeIcon.className = 'bi bi-sun-fill text-warning';
                themeText.textContent = 'Light';
            } else {
                themeIcon.className = 'bi bi-moon-stars';
                themeText.textContent = 'Dark';
            }
        }
    }

    function toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-bs-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeUI(newTheme);
    }

    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);
    });
</script>

</body>
</html>
