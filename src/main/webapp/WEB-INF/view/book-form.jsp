<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Amazon Book Store - Book Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="container form-container">
    <div class="header">
        <h1>${book.id == 0 ? '➕ Add New Book' : '✏️ Update Book'}</h1>
    </div>

    <div class="form-card">
        <form:form action="${pageContext.request.contextPath}/book/saveBook" modelAttribute="book" method="POST">
            
            <!-- Hidden field to handle update vs insert -->
            <form:hidden path="id" />

            <div class="form-group">
                <label for="title">Book Title:</label>
                <form:input path="title" id="title" cssClass="form-control" placeholder="Enter book title" required="required"/>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <form:select path="category.id" id="category" cssClass="form-control">
                    <form:option value="0" label="-- Select Category --" />
                    <form:options items="${categories}" itemValue="id" itemLabel="categoryName" />
                </form:select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Book</button>
                <a href="${pageContext.request.contextPath}/book/list" class="btn btn-secondary">Cancel</a>
            </div>

        </form:form>
    </div>
</div>

</body>
</html>
