<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - ${book.title}</title>
    
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
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/"><i class="bi bi-house me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/book/list"><i class="bi bi-collection me-1"></i> Books</a>
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
            </div>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 750px;">
    
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/book/list" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Back to Inventory
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-header bg-dark text-white p-4">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span class="badge bg-warning text-dark mb-2">Book Details</span>
                    <h2 class="fw-bold m-0"><i class="bi bi-journal-bookmark me-2 text-warning"></i>${book.title}</h2>
                </div>
                <c:url var="editLink" value="/book/showFormForUpdate">
                    <c:param name="bookId" value="${book.id}" />
                </c:url>
                <a href="${editLink}" class="btn btn-amazon shadow-sm">
                    <i class="bi bi-pencil me-1"></i> Edit Book
                </a>
            </div>
        </div>

        <div class="card-body p-4">
            
            <!-- Category & Authors Info -->
            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3 border">
                        <small class="text-muted text-uppercase fw-bold d-block mb-1">Category</small>
                        <c:choose>
                            <c:when test="${not empty book.category}">
                                <span class="badge badge-category px-3 py-2 fs-6">
                                    <i class="bi bi-tag me-1"></i>${book.category.categoryName}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-light text-muted border">Uncategorized</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3 border">
                        <small class="text-muted text-uppercase fw-bold d-block mb-1">Author(s)</small>
                        <div>
                            <c:choose>
                                <c:when test="${not empty book.authors}">
                                    <c:forEach var="author" items="${book.authors}">
                                        <span class="badge badge-author px-3 py-2 fs-6 me-1 mb-1">
                                            <i class="bi bi-person me-1"></i>${author.authorName}
                                        </span>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted fst-italic">No authors assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Complete Publication Details (OneToOne) -->
            <h5 class="fw-bold mb-3"><i class="bi bi-card-checklist text-warning me-2"></i>Publication Information</h5>
            
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <tbody>
                        <tr>
                            <th class="table-light text-secondary w-35 ps-3">ISBN</th>
                            <td class="ps-3 fw-semibold">${not empty book.bookDetails.isbn ? book.bookDetails.isbn : '<span class="text-muted fst-italic">N/A</span>'}</td>
                        </tr>
                        <tr>
                            <th class="table-light text-secondary ps-3">Publisher</th>
                            <td class="ps-3">${not empty book.bookDetails.publisher ? book.bookDetails.publisher : '<span class="text-muted fst-italic">N/A</span>'}</td>
                        </tr>
                        <tr>
                            <th class="table-light text-secondary ps-3">Publication Date</th>
                            <td class="ps-3">
                                <c:choose>
                                    <c:when test="${not empty book.bookDetails.publicationDate}">
                                        <fmt:formatDate value="${book.bookDetails.publicationDate}" pattern="yyyy-MM-dd" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fst-italic">N/A</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="table-light text-secondary ps-3">Number of Pages</th>
                            <td class="ps-3">${book.bookDetails.numberOfPages > 0 ? book.bookDetails.numberOfPages : '<span class="text-muted fst-italic">N/A</span>'} pages</td>
                        </tr>
                        <tr>
                            <th class="table-light text-secondary ps-3">Language</th>
                            <td class="ps-3">${not empty book.bookDetails.language ? book.bookDetails.language : '<span class="text-muted fst-italic">N/A</span>'}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>

        <div class="card-footer bg-light p-3 d-flex justify-content-between align-items-center">
            <span class="text-muted small">Record ID: #${book.id}</span>
            <a href="${pageContext.request.contextPath}/book/list" class="btn btn-secondary btn-sm">
                Back to Inventory
            </a>
        </div>
    </div>
</div>

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
