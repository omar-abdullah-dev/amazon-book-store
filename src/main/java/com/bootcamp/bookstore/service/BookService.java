package com.bootcamp.bookstore.service;

import java.util.List;
import com.bootcamp.bookstore.model.Book;

public interface BookService {

    void saveBook(Book book);

    Book getBook(int id);

    List<Book> getBooks();

    void updateBook(Book book);

    void deleteBook(int id);
}
