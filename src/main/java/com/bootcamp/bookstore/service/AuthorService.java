package com.bootcamp.bookstore.service;

import java.util.List;
import com.bootcamp.bookstore.model.Author;

public interface AuthorService {

    void saveAuthor(Author author);

    Author getAuthor(int id);

    List<Author> getAuthors();

    void updateAuthor(Author author);

    void deleteAuthor(int id);
}
