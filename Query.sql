-- ============================================================
-- Amazon Book Store - Complete Database Reset & Fresh Sample Data
-- ============================================================

CREATE DATABASE IF NOT EXISTS amazon_book_store;
USE amazon_book_store;

-- 1. Disable Foreign Key Checks for clean truncation
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE book_author;
TRUNCATE TABLE book_details;
TRUNCATE TABLE book;
TRUNCATE TABLE category;
TRUNCATE TABLE author;

-- 2. Re-enable Foreign Key Checks
SET FOREIGN_KEY_CHECKS = 1;

-- 3. Insert Clean Categories
INSERT INTO category (id, category_name) VALUES 
(1, 'Computer Science & Programming'),
(2, 'Software Engineering & Architecture'),
(3, 'Science Fiction & Fantasy'),
(4, 'History & Biography'),
(5, 'Business & Economics'),
(6, 'Self-Development & Psychology');

-- 4. Insert Clean Authors
INSERT INTO author (id, author_name) VALUES 
(1, 'Robert C. Martin'),
(2, 'Martin Fowler'),
(3, 'Joshua Bloch'),
(4, 'Eric Evans'),
(5, 'George Orwell'),
(6, 'J.K. Rowling'),
(7, 'James Clear');

-- 5. Insert Sample Books
INSERT INTO book (id, title, category_id) VALUES 
(1, 'Clean Code: A Handbook of Agile Software Craftsmanship', 1),
(2, 'Refactoring: Improving the Design of Existing Code', 2),
(3, 'Effective Java', 1),
(4, 'Domain-Driven Design: Tackling Complexity in the Heart of Software', 2),
(5, '1984', 3),
(6, 'Atomic Habits', 6);

-- 6. Insert Book Details (One-to-One with Book)
INSERT INTO book_details (id, isbn, publisher, publication_date, number_of_pages, language, book_id) VALUES 
(1, '978-0132350884', 'Prentice Hall', '2008-08-01', 464, 'English', 1),
(2, '978-0134757599', 'Addison-Wesley Professional', '2018-11-30', 448, 'English', 2),
(3, '978-0134685991', 'Addison-Wesley Professional', '2017-12-27', 412, 'English', 3),
(4, '978-0321125217', 'Addison-Wesley Professional', '2003-08-30', 560, 'English', 4),
(5, '978-0451524935', 'Signet Classic', '1950-07-01', 328, 'English', 5),
(6, '978-0735211292', 'Avery', '2018-10-16', 320, 'English', 6);

-- 7. Map Books to Authors (Many-to-Many Join Table)
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1), -- Clean Code -> Robert C. Martin
(2, 2), -- Refactoring -> Martin Fowler
(3, 3), -- Effective Java -> Joshua Bloch
(4, 4), -- Domain-Driven Design -> Eric Evans
(5, 5), -- 1984 -> George Orwell
(6, 7); -- Atomic Habits -> James Clear

-- 8. Verify Queries
SELECT * FROM category;
SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM book_details;
SELECT * FROM book_author;