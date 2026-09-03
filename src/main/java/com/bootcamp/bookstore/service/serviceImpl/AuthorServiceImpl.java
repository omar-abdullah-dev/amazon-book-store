package com.bootcamp.bookstore.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bootcamp.bookstore.dao.AuthorDAO;
import com.bootcamp.bookstore.model.Author;
import com.bootcamp.bookstore.service.AuthorService;

@Service
public class AuthorServiceImpl implements AuthorService {

    @Autowired
    private AuthorDAO authorDAO;

    @Override
    @Transactional
    public void saveAuthor(Author author) {
        authorDAO.save(author);
    }

    @Override
    @Transactional
    public Author getAuthor(int id) {
        return authorDAO.findById(id);
    }

    @Override
    @Transactional
    public List<Author> getAuthors() {
        return authorDAO.findAll();
    }

    @Override
    @Transactional
    public void updateAuthor(Author author) {
        authorDAO.update(author);
    }

    @Override
    @Transactional
    public void deleteAuthor(int id) {
        authorDAO.delete(id);
    }
}
