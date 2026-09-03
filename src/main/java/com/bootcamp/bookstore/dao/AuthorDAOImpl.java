package com.bootcamp.bookstore.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bootcamp.bookstore.model.Author;

@Repository
public class AuthorDAOImpl implements AuthorDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.save(author);
    }

    @Override
    public Author findById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Author) session.get(Author.class, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Author> findAll() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from Author").list();
    }

    @Override
    public void update(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.update(author);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        
        // 1. Remove references from book_author join table first
        session.createSQLQuery("DELETE FROM book_author WHERE author_id = :authorId")
               .setParameter("authorId", id)
               .executeUpdate();

        // 2. Delete the author
        Author author = (Author) session.get(Author.class, id);
        if (author != null) {
            session.delete(author);
        }
    }
}
