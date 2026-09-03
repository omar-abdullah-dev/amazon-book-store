<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Amazon Book Store - Book List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<div class="container">
    <div class="header">
        <h1>📚 Amazon Book Store</h1>
        <p>Book Inventory Management System</p>
    </div>

    <div class="actions-bar">
        <a href="${pageContext.request.contextPath}/book/showFormForAdd" class="btn btn-primary">
            + Add New Book
        </a>
    </div>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Actions</th>
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
                        <td>${tempBook.id}</td>
                        <td><strong>${tempBook.title}</strong></td>
                        <td class="action-links">
                            <a href="${updateLink}" class="btn btn-sm btn-edit">Update</a>
                            <a href="${deleteLink}" class="btn btn-sm btn-delete" 
                               onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty books}">
                    <tr>
                        <td colspan="3" style="text-align: center; color: #888; padding: 30px;">
                            No books available yet. Click "Add New Book" to add one!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
