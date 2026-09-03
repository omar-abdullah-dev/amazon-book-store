package com.bootcamp.bookstore.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bootcamp.bookstore.dao.BookDAO;
import com.bootcamp.bookstore.model.Book;
import com.bootcamp.bookstore.service.BookService;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookDAO bookDAO;

    @Override
    @Transactional
    public void saveBook(Book book) {
        bookDAO.save(book);
    }

    @Override
    @Transactional(readOnly = true)
    public Book getBook(int id) {
        return bookDAO.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Book> getBooks() {
        return bookDAO.findAll();
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        bookDAO.update(book);
    }

    @Override
    @Transactional
    public void deleteBook(int id) {
        bookDAO.delete(id);
    }
}
