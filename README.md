# 📚 Amazon Book Store - Spring MVC & Hibernate CRUD Application

An enterprise-grade, full-stack Book Inventory Management Web Application built with **Spring MVC 4**, **Hibernate 4 ORM**, **MySQL 8**, **JSP / JSTL**, and **Bootstrap 5**.

---

## 🌟 Features Overview

- **📖 Book Inventory Management (Full CRUD):**
  - Browse all books in an inventory table with badges for categories and authors.
  - **Quick Details Modal:** Instant preview modal window for publication details without page reload.
  - **Dedicated `viewMore` Page:** Full page view showing comprehensive book metadata and publication information.
  - Add & Update books with responsive validation.
  - Delete books with browser confirmation alerts.

- **🏷️ Category Management (Many-to-One):**
  - Dedicated category management (`/category/list`).
  - Add, update, and delete categories with validation.
  - Dynamically populate categories in the Book Form dropdown.

- **✍️ Author Directory (Many-to-Many):**
  - Dedicated author management (`/author/list`).
  - Add, update, and delete authors.
  - Assign multiple authors to a book via checkboxes (`book_author` join table).

- **📄 Publication Details (One-to-One with `CascadeType.ALL`):**
  - Track ISBN, Publisher, Publication Date (`java.util.Date`), Number of Pages, and Language.
  - Automatic persistence and lifecycle cascading.

- **🛡️ Full-Stack Validation:**
  - **Frontend:** HTML5 validation + JavaScript submit-time checks for required fields, at least 1 author, and mandatory language.
  - **Backend:** Spring Controller validation with customized error alerts.

- **🌐 Interactive Draggable Language Selector:**
  - HTML5 Drag-and-Drop language chips to easily assign book language.

---

## 🛠️ Technologies & Stack

| Layer | Technology |
| :--- | :--- |
| **Backend Framework** | Spring Framework `4.3.30.RELEASE` (Spring MVC, Spring ORM, Spring Tx) |
| **ORM / Persistence** | Hibernate ORM `4.3.8.Final`, JPA 2.1 Annotations |
| **Database** | MySQL 8.0 with MySQL Connector `8.0.33` |
| **Connection Pool** | C3P0 `ComboPooledDataSource` |
| **Frontend / Views** | JSP 2.1, JSTL 1.2, HTML5, CSS3, JavaScript |
| **UI Framework** | Bootstrap `5.3.0` & Bootstrap Icons `1.11.0` |
| **Servlet Container** | Apache Tomcat 9 |
| **Build Tool** | Apache Maven 3 |

---

## 🏛️ Architecture & Database Design

### Relationships:
1. **`Book` ⟷ `BookDetails`:** `@OneToOne(mappedBy = "book", cascade = CascadeType.ALL)`
2. **`Book` ⟷ `Category`:** `@ManyToOne` with `@JoinColumn(name = "category_id")`
3. **`Book` ⟷ `Author`:** `@ManyToMany` with `@JoinTable(name = "book_author")`

```
  ┌──────────────┐         1:1 (Cascade ALL)         ┌──────────────────┐
  │     Book     │ ───────────────────────────────── │   BookDetails    │
  │──────────────│                                   │──────────────────│
  │ id (PK)      │                                   │ id (PK)          │
  │ title        │                                   │ isbn             │
  │ category_id  │                                   │ publication_date │
  └──────────────┘                                   │ publisher        │
         │                                           │ number_of_pages  │
         │ N:1                                       │ language         │
         ▼                                           │ book_id (FK, UQ) │
  ┌──────────────┐                                   └──────────────────┘
  │   Category   │
  │──────────────│
  │ id (PK)      │
  │ category_name│
  └──────────────┘
         
         ▲
         │ N:M (Join Table: book_author)
         ▼
  ┌──────────────┐
  │    Author    │
  │──────────────│
  │ id (PK)      │
  │ author_name  │
  └──────────────┘
```

---

## 📐 UML Class Diagram

```mermaid
classDiagram
    class Book {
        -int id
        -String title
        -BookDetails bookDetails
        -Category category
        -List~Author~ authors
        +getId() int
        +setId(int id) void
        +getTitle() String
        +setTitle(String title) void
        +getBookDetails() BookDetails
        +setBookDetails(BookDetails bookDetails) void
        +getCategory() Category
        +setCategory(Category category) void
        +getAuthors() List~Author~
        +setAuthors(List~Author~ authors) void
    }

    class BookDetails {
        -int id
        -String isbn
        -Date publicationDate
        -String publisher
        -int numberOfPages
        -String language
        -Book book
        +getId() int
        +getIsbn() String
        +getPublicationDate() Date
        +getPublisher() String
        +getNumberOfPages() int
        +getLanguage() String
        +getBook() Book
    }

    class Category {
        -int id
        -String categoryName
        -List~Book~ books
        +getId() int
        +getCategoryName() String
        +getBooks() List~Book~
    }

    class Author {
        -int id
        -String authorName
        -List~Book~ books
        +getId() int
        +getAuthorName() String
        +getBooks() List~Book~
    }

    Book "1" *-- "1" BookDetails : OneToOne (Cascade ALL)
    Book "N" --> "1" Category : ManyToOne
    Book "M" <--> "N" Author : ManyToMany
```

---

## 🔄 Sequence Diagram (Create New Book Workflow)

```mermaid
sequenceDiagram
    autonumber
    actor User
    participant Browser as Browser (JSP/Bootstrap)
    participant Controller as BookController
    participant Service as BookService / CategoryService / AuthorService
    participant DAO as BookDAO
    participant DB as MySQL Database

    User->>Browser: Open Add Book Form
    Browser->>Controller: GET /book/showFormForAdd
    Controller->>Service: getCategories() & getAuthors()
    Service-->>Controller: Return Category & Author Lists
    Controller-->>Browser: Render book-form.jsp with Form Model

    User->>Browser: Fill Form (Title, Category, Authors, Details) & Click Save
    Browser->>Browser: JS Validation (Check required fields & at least 1 author)
    Browser->>Controller: POST /book/saveBook (FormData + authorIds)
    Controller->>Controller: Backend Validation & Bidirectional Link
    Controller->>Service: saveBook(theBook)
    Service->>DAO: save(theBook)
    DAO->>DB: INSERT into book, book_details, book_author
    DB-->>DAO: Success
    DAO-->>Service: Success
    Service-->>Controller: Transaction Committed
    Controller-->>Browser: Redirect to /book/list
    Browser-->>User: Display Updated Inventory Table
```

---

## 🚀 How to Run the Project

### 1. Prerequisites
- **Java JDK 8 or higher**
- **Apache Maven 3.6+**
- **Apache Tomcat 9.0+**
- **MySQL Server 8.0+**

### 2. Database Setup
1. Start MySQL Server.
2. Open MySQL Workbench or MySQL CLI and run the queries in `Query.sql`:
```sql
CREATE DATABASE IF NOT EXISTS amazon_book_store;
USE amazon_book_store;

INSERT INTO category (category_name) VALUES 
('Computer Science & Programming'),
('Science Fiction & Fantasy'),
('History & Biography'),
('Business & Economics'),
('Self-Development & Psychology'),
('Literature & Novels');

INSERT INTO author (author_name) VALUES 
('Robert C. Martin'),
('Martin Fowler'),
('Joshua Bloch'),
('Eric Evans'),
('George Orwell'),
('J.K. Rowling');
```

3. Update database credentials in `src/main/resources/database.properties` if different:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/amazon_book_store?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.user=root
db.password=root
```

### 3. Build & Run with Apache Tomcat 9
1. In IntelliJ IDEA / Eclipse:
   - Configure **Smart Tomcat** or **Tomcat Server (Local)**.
   - Set **Deployment Directory** to `src/main/webapp` (or artifact `amazon-book-store:war exploded`).
   - Set **Context Path** to `/amazon-book-store`.
2. Start Tomcat Server.
3. Open your browser:
   - **Home Page / Dashboard:** `http://localhost:8080/amazon-book-store/`
   - **Books Inventory:** `http://localhost:8080/amazon-book-store/book/list`
   - **Categories:** `http://localhost:8080/amazon-book-store/category/list`
   - **Authors:** `http://localhost:8080/amazon-book-store/author/list`

---

## 📌 Application Endpoints

| HTTP Method | URL Pattern | Description |
| :--- | :--- | :--- |
| `GET` | `/` | Home Landing Page & Statistics Dashboard |
| `GET` | `/book/list` | Display Books Inventory Table |
| `GET` | `/book/showFormForAdd` | Show form to add a new Book |
| `POST` | `/book/saveBook` | Handle Add / Update Book submission with validation |
| `GET` | `/book/showFormForUpdate?bookId={id}` | Show form populated with existing Book data |
| `GET` | `/book/viewMore?bookId={id}` | Dedicated View More full details page |
| `GET` | `/book/delete?bookId={id}` | Delete a Book and its details |
| `GET` | `/category/list` | List all Categories |
| `GET` | `/category/showFormForAdd` | Show form to add Category |
| `POST` | `/category/saveCategory` | Save new or updated Category |
| `GET` | `/category/showFormForUpdate?categoryId={id}` | Show form to edit Category |
| `GET` | `/category/delete?categoryId={id}` | Delete a Category |
| `GET` | `/author/list` | List all Authors |
| `GET` | `/author/showFormForAdd` | Show form to add Author |
| `POST` | `/author/saveAuthor` | Save new or updated Author |
| `GET` | `/author/showFormForUpdate?authorId={id}` | Show form to edit Author |
| `GET` | `/author/delete?authorId={id}` | Delete an Author |

---

## 👨‍💻 Project Structure

```
amazon-book-store/
├── pom.xml
├── Query.sql
├── README.md
└── src/
    └── main/
        ├── java/com/bootcamp/bookstore/
        │   ├── AmazonBookStore.java
        │   ├── controller/
        │   │   ├── HomeController.java
        │   │   ├── BookController.java
        │   │   ├── CategoryController.java
        │   │   └── AuthorController.java
        │   ├── dao/
        │   │   ├── BookDAO.java & BookDAOImpl.java
        │   │   ├── CategoryDAO.java & CategoryDAOImpl.java
        │   │   └── AuthorDAO.java & AuthorDAOImpl.java
        │   ├── service/
        │   │   ├── BookService.java & BookServiceImpl.java
        │   │   ├── CategoryService.java & CategoryServiceImpl.java
        │   │   └── AuthorService.java & AuthorServiceImpl.java
        │   └── model/
        │       ├── Book.java
        │       ├── BookDetails.java
        │       ├── Category.java
        │       └── Author.java
        ├── resources/
        │   ├── application-context.xml
        │   └── database.properties
        └── webapp/
            ├── resources/css/style.css
            └── WEB-INF/
                ├── web.xml
                └── view/
                    ├── home.jsp
                    ├── list-books.jsp
                    ├── viewMore.jsp
                    ├── book-form.jsp
                    ├── list-categories.jsp
                    ├── category-form.jsp
                    ├── list-authors.jsp
                    └── author-form.jsp
```
