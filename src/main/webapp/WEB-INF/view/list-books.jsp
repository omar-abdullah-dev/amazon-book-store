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
<body class="bg-light">

<div class="container my-5">
    <div class="header text-center mb-4">
        <h1 class="fw-bold text-dark"><i class="bi bi-book-half text-warning me-2"></i>Amazon Book Store</h1>
        <p class="text-secondary">Book Inventory Management System</p>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="m-0 text-secondary fw-semibold">Book Collection</h4>
        <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-warning fw-semibold shadow-sm">
            <i class="bi bi-plus-circle me-1"></i> Add New Book
        </a>
    </div>

    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Authors</th>
                            <th>Details</th>
                            <th class="text-end pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tempBook" items="${books}">
                            <c:url var="updateLink" value="/book/showFormForUpdate">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>
                            <c:url var="deleteLink" value="/book/delete">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>

                            <tr>
                                <td class="ps-3 fw-semibold text-muted">#${tempBook.id}</td>
                                <td><strong class="text-dark">${tempBook.title}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty tempBook.category}">
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1">
                                                <i class="bi bi-tag me-1"></i>${tempBook.category.categoryName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light text-muted border">Uncategorized</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty tempBook.authors}">
                                            <c:forEach var="author" items="${tempBook.authors}">
                                                <span class="badge bg-purple-subtle text-purple border px-2 py-1 me-1 mb-1">
                                                    <i class="bi bi-person me-1"></i>${author.authorName}
                                                </span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic small">No Authors</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Button to open Modal -->
                                    <button type="button" class="btn btn-sm btn-outline-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#detailsModal${tempBook.id}">
                                        <i class="bi bi-info-circle me-1"></i> View Details
                                    </button>
                                </td>
                                <td class="text-end pe-3">
                                    <a href="${updateLink}" class="btn btn-sm btn-outline-secondary me-1">
                                        <i class="bi bi-pencil me-1"></i>Edit
                                    </a>
                                    <a href="${deleteLink}" class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Are you sure you want to delete this book?');">
                                        <i class="bi bi-trash me-1"></i>Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty books}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-5">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    No books available in the inventory yet.<br/>
                                    <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-warning btn-sm mt-3">
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

    <!-- Modals Container (Cleanly outside <table> to avoid HTML parsing bugs) -->
    <c:forEach var="tempBook" items="${books}">
        <c:url var="modalUpdateLink" value="/book/showFormForUpdate">
            <c:param name="bookId" value="${tempBook.id}" />
        </c:url>

        <div class="modal fade" id="detailsModal${tempBook.id}" tabindex="-1" aria-labelledby="detailsModalLabel${tempBook.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow border-0">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title fs-5" id="detailsModalLabel${tempBook.id}">
                            <i class="bi bi-journal-bookmark text-warning me-2"></i>${tempBook.title}
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 bg-white">
                        
                        <!-- Classification -->
                        <div class="mb-3">
                            <span class="text-muted text-uppercase fw-bold small d-block mb-1">Classification</span>
                            <div class="d-flex align-items-center gap-2">
                                <span class="fw-semibold text-secondary">Category:</span>
                                <c:choose>
                                    <c:when test="${not empty tempBook.category}">
                                        <span class="badge bg-primary-subtle text-primary border px-2 py-1">${tempBook.category.categoryName}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-muted border">Uncategorized</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Authors -->
                        <div class="mb-3">
                            <span class="text-muted text-uppercase fw-bold small d-block mb-1">Author(s)</span>
                            <div>
                                <c:choose>
                                    <c:when test="${not empty tempBook.authors}">
                                        <c:forEach var="author" items="${tempBook.authors}">
                                            <span class="badge bg-dark me-1"><i class="bi bi-person me-1"></i>${author.authorName}</span>
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
                            <span class="text-muted text-uppercase fw-bold small d-block mb-2">Book Details</span>
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
                    <div class="modal-footer bg-light">
                        <a href="${modalUpdateLink}" class="btn btn-warning btn-sm fw-semibold">
                            <i class="bi bi-pencil me-1"></i> Edit Book
                        </a>
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Bootstrap 5 Bundle JS (Includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
