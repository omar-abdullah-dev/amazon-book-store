CREATE DATABASE IF NOT EXISTS amazon_book_store;
USE amazon_book_store;

-- Sample Categories Data
INSERT INTO category (category_name) VALUES 
('Computer Science & Programming'),
('Science Fiction & Fantasy'),
('History & Biography'),
('Business & Economics'),
('Self-Development & Psychology'),
('Literature & Novels');

-- Verify Queries
SELECT * FROM category;
SELECT * FROM book;
SELECT * FROM book_details;
SELECT * FROM author;
SELECT * FROM book_author;