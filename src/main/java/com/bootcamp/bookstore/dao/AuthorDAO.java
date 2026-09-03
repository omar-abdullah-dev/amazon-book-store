package com.bootcamp.bookstore.dao;

import java.util.List;
import com.bootcamp.bookstore.model.Author;

public interface AuthorDAO {

    void save(Author author);

    Author findById(int id);

    List<Author> findAll();

    void update(Author author);

    void delete(int id);
}
