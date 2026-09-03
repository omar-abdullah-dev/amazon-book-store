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
