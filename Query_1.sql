USE amazon_book_store;


select * from author;
select * from book;
select * from book_author;
select * from book_details;
select * from category;


SELECT * FROM book_details;



INSERT INTO category (category_name) VALUES
                                         ('Computer Science & Programming'),
                                         ('Science Fiction & Fantasy'),
                                         ('History & Biography'),
                                         ('Business & Economics'),
                                         ('Self-Development & Psychology'),
                                         ('Literature & Novels');


-- Sample Authors Data
INSERT INTO author (author_name) VALUES
                                     ('Robert C. Martin'),
                                     ('Martin Fowler'),
                                     ('Joshua Bloch'),
                                     ('Eric Evans'),
                                     ('George Orwell'),
                                     ('J.K. Rowling');



SELECT * FROM category;
SELECT * FROM book;
SELECT * FROM book_details;
SELECT * FROM author;
SELECT * FROM book_author;

