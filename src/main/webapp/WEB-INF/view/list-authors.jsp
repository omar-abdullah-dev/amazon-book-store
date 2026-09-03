<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - Authors</title>
    
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
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/book/list"><i class="bi bi-collection me-1"></i> Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/category/list"><i class="bi bi-tags me-1"></i> Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/author/list"><i class="bi bi-people me-1"></i> Authors</a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-2 mt-2 mt-lg-0">
                <button type="button" class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
                    <i class="bi bi-moon-stars" id="themeIcon"></i> <span id="themeText">Dark</span>
                </button>
                <a href="${pageContext.request.contextPath}/author/showFormForAdd" class="btn btn-amazon shadow-sm btn-sm">
                    <i class="bi bi-person-plus me-1"></i> Add Author
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 850px;">
    
    <!-- Header & Add Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-1"><i class="bi bi-people text-purple me-2"></i>Authors</h3>
            <p class="text-secondary m-0">Manage book authors and writers directory</p>
        </div>
        <a href="${pageContext.request.contextPath}/author/showFormForAdd" class="btn btn-amazon shadow-sm">
            <i class="bi bi-person-plus me-1"></i> + Add Author
        </a>
    </div>

    <!-- Live Search Bar -->
    <div class="card border-0 shadow-sm rounded-3 mb-3">
        <div class="card-body p-2">
            <div class="input-group">
                <span class="input-group-text bg-transparent border-0 text-muted ps-3">
                    <i class="bi bi-search"></i>
                </span>
                <input type="text" id="authorSearchInput" class="form-control border-0 shadow-none" 
                       placeholder="Search authors by name or ID..." onkeyup="filterAuthors()">
                <button class="btn btn-link text-muted pe-3 text-decoration-none" type="button" onclick="clearAuthorSearch()" title="Clear search">
                    <i class="bi bi-x-circle-fill"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Authors Table Card -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="authorsTable">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-4" style="width: 15%;">ID</th>
                            <th style="width: 60%;">Author Name</th>
                            <th class="text-end pe-4" style="width: 25%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tempAuthor" items="${authors}">
                            <c:url var="updateLink" value="/author/showFormForUpdate">
                                <c:param name="authorId" value="${tempAuthor.id}" />
                            </c:url>
                            <c:url var="deleteLink" value="/author/delete">
                                <c:param name="authorId" value="${tempAuthor.id}" />
                            </c:url>

                            <tr class="author-row">
                                <td class="ps-4 fw-semibold text-muted author-id">#${tempAuthor.id}</td>
                                <td>
                                    <span class="badge badge-author px-3 py-2 fs-6 author-name">
                                        <i class="bi bi-person me-1"></i>${tempAuthor.authorName}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex flex-column gap-1 align-items-end">
                                        <a href="${updateLink}" class="btn btn-sm btn-outline-secondary py-1 px-3" style="min-width: 90px;">
                                            <i class="bi bi-pencil me-1"></i>Update
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger py-1 px-3" style="min-width: 90px;"
                                                onclick="openDeleteModal('${deleteLink}', '${tempAuthor.authorName}')">
                                            <i class="bi bi-trash me-1"></i>Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- No results found row -->
                        <tr id="noAuthorMatchRow" style="display: none;">
                            <td colspan="3" class="text-center text-muted py-4">
                                <i class="bi bi-search fs-3 d-block mb-1 text-secondary"></i>
                                No matching authors found.
                            </td>
                        </tr>

                        <c:if test="${empty authors}">
                            <tr>
                                <td colspan="3" class="text-center text-muted py-5">
                                    <i class="bi bi-people fs-1 d-block mb-2 text-secondary"></i>
                                    No authors available yet.<br/>
                                    <a href="${pageContext.request.contextPath}/author/showFormForAdd" class="btn btn-amazon btn-sm mt-3">
                                        + Add First Author
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

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
                    Do you really want to delete author <strong id="deleteItemName" class="text-dark"></strong>?
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

    // Author Live Search Function
    function filterAuthors() {
        const input = document.getElementById("authorSearchInput").value.toLowerCase().trim();
        const rows = document.querySelectorAll(".author-row");
        const noMatch = document.getElementById("noAuthorMatchRow");
        let visibleCount = 0;

        rows.forEach(row => {
            const name = row.querySelector(".author-name").textContent.toLowerCase();
            const id = row.querySelector(".author-id").textContent.toLowerCase();

            if (name.includes(input) || id.includes(input)) {
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

    function clearAuthorSearch() {
        const input = document.getElementById("authorSearchInput");
        input.value = "";
        filterAuthors();
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
