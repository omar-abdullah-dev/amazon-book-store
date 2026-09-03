<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - Book Inventory</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
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
                <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-amazon shadow-sm btn-sm">
                    <i class="bi bi-plus-circle me-1"></i> Add Book
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5">
    
    <!-- Page Header (Matching Screenshot) -->
    <div class="header text-center mb-4">
        <h1 class="fw-bold"><i class="bi bi-book-half text-warning me-2"></i>Amazon Book Store</h1>
        <p class="text-secondary">Book Inventory Management System</p>
    </div>

    <!-- Collection Subheader & Add Button -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="m-0 text-secondary fw-semibold">Book Collection</h4>
        <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-amazon shadow-sm">
            <i class="bi bi-plus-circle me-1"></i> + Add New Book
        </a>
    </div>

    <!-- Live Search Bar -->
    <div class="card border-0 shadow-sm rounded-3 mb-3">
        <div class="card-body p-2">
            <div class="input-group">
                <span class="input-group-text bg-transparent border-0 text-muted ps-3">
                    <i class="bi bi-search"></i>
                </span>
                <input type="text" id="bookSearchInput" class="form-control border-0 shadow-none" 
                       placeholder="Search books by title, category, author, or ISBN..." onkeyup="filterBooks()">
                <button class="btn btn-link text-muted pe-3 text-decoration-none" type="button" onclick="clearBookSearch()" title="Clear search">
                    <i class="bi bi-x-circle-fill"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Inventory Table Card -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="booksTable">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-3" style="width: 8%;">ID</th>
                            <th style="width: 30%;">TITLE</th>
                            <th style="width: 18%;">CATEGORY</th>
                            <th style="width: 20%;">AUTHORS</th>
                            <th style="width: 12%;">DETAILS</th>
                            <th class="text-end pe-3" style="width: 12%;">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tempBook" items="${books}">
                            <c:url var="updateLink" value="/book/showFormForUpdate">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>
                            <c:url var="viewMoreLink" value="/book/viewMore">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>
                            <c:url var="deleteLink" value="/book/delete">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>

                            <tr class="book-row">
                                <td class="ps-3 fw-semibold text-muted book-id">#${tempBook.id}</td>
                                <td>
                                    <strong class="text-primary-emphasis book-title">${tempBook.title}</strong>
                                    <c:if test="${not empty tempBook.bookDetails.isbn}">
                                        <small class="text-muted d-block book-isbn">ISBN: ${tempBook.bookDetails.isbn}</small>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty tempBook.category}">
                                            <span class="badge badge-category px-2 py-1 book-category">
                                                <i class="bi bi-tag me-1"></i>${tempBook.category.categoryName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border book-category">Uncategorized</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="book-authors">
                                        <c:choose>
                                            <c:when test="${not empty tempBook.authors}">
                                                <c:forEach var="author" items="${tempBook.authors}">
                                                    <span class="badge badge-author px-2 py-1 me-1 mb-1">
                                                        <i class="bi bi-person me-1"></i>${author.authorName}
                                                    </span>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted fst-italic small">No Authors</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <!-- Button to open Modal -->
                                    <button type="button" class="btn btn-sm btn-outline-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#detailsModal${tempBook.id}">
                                        <i class="bi bi-info-circle me-1"></i> View Details
                                    </button>
                                </td>
                                <td class="text-end pe-3">
                                    <div class="d-inline-flex flex-column gap-1 align-items-end">
                                        <a href="${updateLink}" class="btn btn-sm btn-outline-secondary py-1 px-3" style="min-width: 85px;" title="Edit">
                                            <i class="bi bi-pencil me-1"></i>Edit
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger py-1 px-3" style="min-width: 85px;" title="Delete"
                                                onclick="openDeleteModal('${deleteLink}', '${tempBook.title}')">
                                            <i class="bi bi-trash me-1"></i>Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- No Results Row -->
                        <tr id="noBookMatchRow" style="display: none;">
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="bi bi-search fs-3 d-block mb-1 text-secondary"></i>
                                No matching books found.
                            </td>
                        </tr>

                        <c:if test="${empty books}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-5">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    No books available in the inventory yet.<br/>
                                    <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-amazon btn-sm mt-3">
                                        + Add Your First Book
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modals Container -->
    <c:forEach var="tempBook" items="${books}">
        <c:url var="modalUpdateLink" value="/book/showFormForUpdate">
            <c:param name="bookId" value="${tempBook.id}" />
        </c:url>
        <c:url var="modalViewMoreLink" value="/book/viewMore">
            <c:param name="bookId" value="${tempBook.id}" />
        </c:url>

        <div class="modal fade" id="detailsModal${tempBook.id}" tabindex="-1" aria-labelledby="detailsModalLabel${tempBook.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow border-0">
                    <div class="modal-header">
                        <h5 class="modal-title fs-5" id="detailsModalLabel${tempBook.id}">
                            <i class="bi bi-journal-bookmark text-warning me-2"></i>${tempBook.title}
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        
                        <!-- Classification -->
                        <div class="mb-3">
                            <span class="text-muted text-uppercase fw-bold small d-block mb-1">CLASSIFICATION</span>
                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold text-secondary">Category:</span>
                                <c:choose>
                                    <c:when test="${not empty tempBook.category}">
                                        <span class="badge badge-category px-2 py-1">${tempBook.category.categoryName}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-muted border">Uncategorized</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Authors -->
                        <div class="mb-3">
                            <span class="text-muted text-uppercase fw-bold small d-block mb-1">AUTHOR(S)</span>
                            <div>
                                <c:choose>
                                    <c:when test="${not empty tempBook.authors}">
                                        <c:forEach var="author" items="${tempBook.authors}">
                                            <span class="badge badge-author me-1"><i class="bi bi-person me-1"></i>${author.authorName}</span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fst-italic small">No authors assigned</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <hr class="my-3"/>

                        <!-- Publication Details -->
                        <div class="mb-2">
                            <span class="text-muted text-uppercase fw-bold small d-block mb-2">
                                <i class="bi bi-card-checklist me-1"></i> Book Details
                            </span>
                            <table class="table table-bordered table-sm mb-0">
                                <tbody>
                                    <tr>
                                        <th class="table-light text-secondary w-50 ps-3">ISBN</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails.isbn ? tempBook.bookDetails.isbn : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Publisher</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails.publisher ? tempBook.bookDetails.publisher : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Publication Date</th>
                                        <td class="ps-3">
                                            <c:choose>
                                                <c:when test="${not empty tempBook.bookDetails.publicationDate}">
                                                    <fmt:formatDate value="${tempBook.bookDetails.publicationDate}" pattern="yyyy-MM-dd" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted fst-italic">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Number of Pages</th>
                                        <td class="ps-3">${tempBook.bookDetails.numberOfPages > 0 ? tempBook.bookDetails.numberOfPages : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Language</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails.language ? tempBook.bookDetails.language : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <a href="${modalViewMoreLink}" class="btn btn-outline-info btn-sm">
                            <i class="bi bi-box-arrow-up-right me-1"></i> Full Page Details
                        </a>
                        <div>
                            <a href="${modalUpdateLink}" class="btn btn-amazon btn-sm me-1">
                                <i class="bi bi-pencil me-1"></i> Edit Book
                            </a>
                            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    <!-- Modern Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 420px;">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title fs-5" id="deleteModalLabel">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>Confirm Deletion
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center p-4">
                    <div class="mb-3 text-danger fs-1">
                        <i class="bi bi-trash3-fill"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Are you sure?</h5>
                    <p class="text-secondary mb-1">
                        Do you really want to delete book <strong id="deleteItemName" class="text-dark"></strong>?
                    </p>
                    <small class="text-danger fst-italic">This action cannot be undone.</small>
                </div>
                <div class="modal-footer bg-light d-flex justify-content-center gap-2 border-0">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteActionBtn" class="btn btn-danger px-4 shadow-sm">
                        <i class="bi bi-trash me-1"></i> Yes, Delete
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="py-4 border-top text-center text-muted small mt-auto">
    <div class="container">
        Amazon Book Store Application &bull; Built with Spring MVC 4 & Hibernate 4
    </div>
</footer>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Theme Switcher & Search Script -->
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

    // Books Live Search Function
    function filterBooks() {
        const input = document.getElementById("bookSearchInput").value.toLowerCase().trim();
        const rows = document.querySelectorAll(".book-row");
        const noMatch = document.getElementById("noBookMatchRow");
        let visibleCount = 0;

        rows.forEach(row => {
            const title = row.querySelector(".book-title") ? row.querySelector(".book-title").textContent.toLowerCase() : "";
            const category = row.querySelector(".book-category") ? row.querySelector(".book-category").textContent.toLowerCase() : "";
            const authors = row.querySelector(".book-authors") ? row.querySelector(".book-authors").textContent.toLowerCase() : "";
            const id = row.querySelector(".book-id") ? row.querySelector(".book-id").textContent.toLowerCase() : "";
            const isbn = row.querySelector(".book-isbn") ? row.querySelector(".book-isbn").textContent.toLowerCase() : "";

            if (title.includes(input) || category.includes(input) || authors.includes(input) || id.includes(input) || isbn.includes(input)) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        if (noMatch) {
            noMatch.style.display = (visibleCount === 0 && rows.length > 0) ? "" : "none";
        }
    }

    function clearBookSearch() {
        const input = document.getElementById("bookSearchInput");
        input.value = "";
        filterBooks();
        input.focus();
    }

    // Open Custom Delete Confirmation Modal
    function openDeleteModal(deleteUrl, itemName) {
        document.getElementById("deleteItemName").textContent = itemName;
        document.getElementById("confirmDeleteActionBtn").setAttribute("href", deleteUrl);
        const modal = new bootstrap.Modal(document.getElementById("deleteConfirmModal"));
        modal.show();
    }

    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);
    });
</script>

</body>
</html>
