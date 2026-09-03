package com.bootcamp.bookstore.dao;

import java.util.List;
import com.bootcamp.bookstore.model.Book;

public interface BookDAO {

    void save(Book book);

    Book findById(int id);

    List<Book> findAll();

    void update(Book book);

    void delete(int id);
}
