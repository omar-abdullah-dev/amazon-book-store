<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - ${book.id == 0 ? 'Add Book' : 'Update Book'}</title>
    
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
            </div>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 650px;">
    <div class="header text-center mb-4">
        <h2 class="fw-bold">
            <i class="bi ${book.id == 0 ? 'bi-plus-circle-fill text-warning' : 'bi-pencil-square text-primary'} me-2"></i>
            ${book.id == 0 ? 'Add New Book' : 'Update Book'}
        </h2>
        <p class="text-secondary">Enter book information and publication details</p>
    </div>

    <!-- Global Backend Error Alert if any -->
    <c:if test="${not empty titleError or not empty categoryError or not empty authorError or not empty languageError or not empty isbnError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <strong>Please correct the following errors:</strong>
            <ul class="mb-0 mt-1">
                <c:if test="${not empty titleError}"><li>${titleError}</li></c:if>
                <c:if test="${not empty categoryError}"><li>${categoryError}</li></c:if>
                <c:if test="${not empty authorError}"><li>${authorError}</li></c:if>
                <c:if test="${not empty languageError}"><li>${languageError}</li></c:if>
                <c:if test="${not empty isbnError}"><li>${isbnError}</li></c:if>
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4">
            <form:form id="bookForm" action="${pageContext.request.contextPath}/book/saveBook" modelAttribute="book" method="POST">
                
                <!-- Hidden fields -->
                <form:hidden path="id" />
                <form:hidden path="bookDetails.id" />

                <!-- Basic Info Section -->
                <h6 class="text-secondary fw-bold mb-3"><i class="bi bi-info-circle me-1"></i> Basic Information</h6>

                <!-- Title Field -->
                <div class="mb-3">
                    <label for="title" class="form-label fw-semibold">Book Title <span class="text-danger">*</span></label>
                    <form:input path="title" id="title" cssClass="form-control ${not empty titleError ? 'is-invalid' : ''}" 
                                placeholder="Enter book title" required="required"/>
                    <c:if test="${not empty titleError}">
                        <div class="invalid-feedback">${titleError}</div>
                    </c:if>
                </div>

                <!-- Category Field -->
                <div class="mb-3">
                    <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                    <form:select path="category.id" id="category" cssClass="form-select ${not empty categoryError ? 'is-invalid' : ''}">
                        <form:option value="0" label="-- Select Category --" />
                        <form:options items="${categories}" itemValue="id" itemLabel="categoryName" />
                    </form:select>
                    <c:if test="${not empty categoryError}">
                        <div class="invalid-feedback">${categoryError}</div>
                    </c:if>
                </div>

                <!-- Authors Field (Mandatory) -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label class="form-label fw-semibold mb-0">Authors <span class="text-danger">*</span></label>
                        <small class="text-muted fst-italic">(At least 1 author required)</small>
                    </div>

                    <div id="authorsContainer" class="p-3 bg-light rounded-2 border ${not empty authorError ? 'border-danger bg-danger-subtle' : ''}">
                        <div class="row g-2">
                            <c:forEach var="tempAuthor" items="${authors}">
                                <c:set var="isAuthorSelected" value="false" />
                                <c:forEach var="bookAuthor" items="${book.authors}">
                                    <c:if test="${bookAuthor.id == tempAuthor.id}">
                                        <c:set var="isAuthorSelected" value="true" />
                                    </c:if>
                                </c:forEach>

                                <div class="col-sm-6">
                                    <div class="form-check">
                                        <input class="form-check-input author-checkbox" type="checkbox" name="authorIds" 
                                               id="author_${tempAuthor.id}" value="${tempAuthor.id}"
                                               ${isAuthorSelected ? 'checked="checked"' : ''} />
                                        <label class="form-check-label" for="author_${tempAuthor.id}">
                                            ${tempAuthor.authorName}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <!-- Client and Server Error Message for Authors -->
                    <div id="authorClientError" class="text-danger small mt-1 ${empty authorError ? 'd-none' : ''}">
                        <i class="bi bi-exclamation-circle-fill me-1"></i>
                        <span>${not empty authorError ? authorError : 'Please select at least one author for this book.'}</span>
                    </div>
                </div>

                <hr class="my-4"/>

                <!-- Publication Details Section -->
                <h6 class="text-secondary fw-bold mb-3"><i class="bi bi-card-checklist me-1"></i> Publication Details (One-to-One)</h6>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="isbn" class="form-label fw-semibold">
                            ISBN <span class="text-danger">*</span>
                        </label>
                        <form:input path="bookDetails.isbn" id="isbn" 
                                    cssClass="form-control ${not empty isbnError ? 'is-invalid border-danger' : ''}" 
                                    placeholder="e.g. 978-0132350884" required="required" />
                        <div class="form-text text-muted small">
                            <i class="bi bi-info-circle me-1"></i> Format: e.g. 978-0132350884 (Must be unique)
                        </div>
                        <c:if test="${not empty isbnError}">
                            <div class="invalid-feedback d-block">${isbnError}</div>
                        </c:if>
                        <div id="isbnClientError" class="text-danger small mt-1 d-none">
                            <i class="bi bi-exclamation-circle-fill me-1"></i> Please enter a valid ISBN.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="publisher" class="form-label fw-semibold">Publisher</label>
                        <form:input path="bookDetails.publisher" id="publisher" cssClass="form-control" placeholder="e.g. Prentice Hall" />
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="publicationDate" class="form-label fw-semibold">Publication Date</label>
                        <form:input path="bookDetails.publicationDate" id="publicationDate" type="date" cssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label for="numberOfPages" class="form-label fw-semibold">Number of Pages</label>
                        <form:input path="bookDetails.numberOfPages" id="numberOfPages" type="number" cssClass="form-control" placeholder="e.g. 464" />
                    </div>
                </div>

                <!-- Language Field (Mandatory) -->
                <div class="mb-4">
                    <label for="language" class="form-label fw-semibold">
                        Language <span class="text-danger">*</span> <i class="bi bi-translate text-primary ms-1"></i>
                    </label>
                    <form:select path="bookDetails.language" id="language" cssClass="form-select border-2 ${not empty languageError ? 'is-invalid border-danger' : ''}">
                        <form:option value="" label="-- Select or Drag Language Below --" />
                        <form:option value="English" label="🇬🇧 English" />
                        <form:option value="Arabic" label="🇪🇬 Arabic (العربية)" />
                        <form:option value="French" label="🇫🇷 French (Français)" />
                        <form:option value="German" label="🇩🇪 German (Deutsch)" />
                        <form:option value="Spanish" label="🇪🇸 Spanish (Español)" />
                        <form:option value="Italian" label="🇮🇹 Italian (Italiano)" />
                        <form:option value="Japanese" label="🇯🇵 Japanese (日本語)" />
                        <form:option value="Chinese" label="🇨🇳 Chinese (中文)" />
                        <form:option value="Russian" label="🇷🇺 Russian (Русский)" />
                    </form:select>

                    <div id="languageClientError" class="text-danger small mt-1 ${empty languageError ? 'd-none' : ''}">
                        <i class="bi bi-exclamation-circle-fill me-1"></i>
                        <span>${not empty languageError ? languageError : 'Please select a language for this book.'}</span>
                    </div>

                    <!-- Draggable Languages Section -->
                    <div class="mt-2 p-2 bg-light rounded border border-dashed">
                        <small class="text-muted d-block mb-2 fw-semibold">
                            <i class="bi bi-arrows-move me-1"></i> Draggable Languages (drag & drop above or click to select):
                        </small>
                        <div class="d-flex flex-wrap gap-2" id="draggableLangContainer">
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="English" style="cursor: grab;">🇬🇧 English</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Arabic" style="cursor: grab;">🇪🇬 Arabic</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="French" style="cursor: grab;">🇫🇷 French</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="German" style="cursor: grab;">🇩🇪 German</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Spanish" style="cursor: grab;">🇪🇸 Spanish</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Italian" style="cursor: grab;">🇮🇹 Italian</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Japanese" style="cursor: grab;">🇯🇵 Japanese</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Chinese" style="cursor: grab;">🇨🇳 Chinese</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Russian" style="cursor: grab;">🇷🇺 Russian</span>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" id="saveBtn" class="btn btn-amazon shadow-sm px-4">
                        <i class="bi bi-check2-circle me-1"></i> Save Book
                    </button>
                    <a href="${pageContext.request.contextPath}/book/list" class="btn btn-secondary px-4">
                        Cancel
                    </a>
                </div>

            </form:form>
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

        // Validation & Drag and Drop
        const bookForm = document.getElementById("bookForm");
        const authorsContainer = document.getElementById("authorsContainer");
        const authorClientError = document.getElementById("authorClientError");
        const authorCheckboxes = document.querySelectorAll(".author-checkbox");
        const langSelect = document.getElementById("language");
        const languageClientError = document.getElementById("languageClientError");
        const chips = document.querySelectorAll(".lang-chip");

        // 1. Frontend Validation on Submit (Enforce Authors + Language)
        bookForm.addEventListener("submit", function (e) {
            let isValid = true;

            // Validate Authors
            const checkedAuthors = document.querySelectorAll(".author-checkbox:checked");
            if (checkedAuthors.length === 0) {
                e.preventDefault();
                authorsContainer.classList.add("border-danger", "border-2", "bg-danger-subtle");
                authorClientError.classList.remove("d-none");
                authorsContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
                isValid = false;
            }

            // Validate Language
            if (!langSelect.value || langSelect.value.trim() === "") {
                e.preventDefault();
                langSelect.classList.add("is-invalid", "border-danger");
                languageClientError.classList.remove("d-none");
                if (isValid) {
                    langSelect.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                isValid = false;
            }

            // Validate ISBN
            const isbnInput = document.getElementById("isbn");
            const isbnClientError = document.getElementById("isbnClientError");
            if (!isbnInput.value || isbnInput.value.trim() === "") {
                e.preventDefault();
                isbnInput.classList.add("is-invalid", "border-danger");
                if (isbnClientError) isbnClientError.classList.remove("d-none");
                if (isValid) {
                    isbnInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                isValid = false;
            }

            return isValid;
        });

        const isbnInput = document.getElementById("isbn");
        if (isbnInput) {
            isbnInput.addEventListener("input", function() {
                if (this.value.trim() !== "") {
                    this.classList.remove("is-invalid", "border-danger");
                    const isbnClientError = document.getElementById("isbnClientError");
                    if (isbnClientError) isbnClientError.classList.add("d-none");
                }
            });
        }

        // 2. Real-time Author Validation (on every checkbox click)
        authorCheckboxes.forEach(cb => {
            cb.addEventListener("change", function () {
                const checkedCount = document.querySelectorAll(".author-checkbox:checked").length;
                if (checkedCount === 0) {
                    authorsContainer.classList.add("border-danger", "border-2", "bg-danger-subtle");
                    authorClientError.classList.remove("d-none");
                } else {
                    authorsContainer.classList.remove("border-danger", "border-2", "bg-danger-subtle");
                    authorClientError.classList.add("d-none");
                }
            });
        });

        // 3. Clear Language Error when language changes
        langSelect.addEventListener("change", function () {
            if (this.value && this.value.trim() !== "") {
                this.classList.remove("is-invalid", "border-danger");
                languageClientError.classList.add("d-none");
            }
        });

        // 4. Draggable Languages & Click to Select
        chips.forEach(chip => {
            chip.addEventListener("dragstart", function (e) {
                e.dataTransfer.setData("text/plain", this.getAttribute("data-lang"));
                this.classList.add("opacity-50");
            });

            chip.addEventListener("dragend", function () {
                this.classList.remove("opacity-50");
            });

            chip.addEventListener("click", function () {
                const langValue = this.getAttribute("data-lang");
                langSelect.value = langValue;
                langSelect.classList.remove("is-invalid", "border-danger");
                languageClientError.classList.add("d-none");
                highlightSelect();
            });
        });

        langSelect.addEventListener("dragover", function (e) {
            e.preventDefault();
            this.classList.add("border-warning", "bg-warning-subtle");
        });

        langSelect.addEventListener("dragleave", function () {
            this.classList.remove("border-warning", "bg-warning-subtle");
        });

        langSelect.addEventListener("drop", function (e) {
            e.preventDefault();
            this.classList.remove("border-warning", "bg-warning-subtle");
            const langValue = e.dataTransfer.getData("text/plain");
            if (langValue) {
                this.value = langValue;
                this.classList.remove("is-invalid", "border-danger");
                languageClientError.classList.add("d-none");
                highlightSelect();
            }
        });

        function highlightSelect() {
            langSelect.classList.add("border-success", "bg-success-subtle");
            setTimeout(() => {
                langSelect.classList.remove("border-success", "bg-success-subtle");
            }, 600);
        }
    });
</script>

</body>
</html>
