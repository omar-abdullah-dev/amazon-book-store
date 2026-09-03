package com.bootcamp.bookstore.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bootcamp.bookstore.model.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.save(category);
    }

    @Override
    public Category findById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Category) session.get(Category.class, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Category> findAll() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from Category").list();
    }

    @Override
    public void update(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.update(category);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Category category = (Category) session.get(Category.class, id);
        if (category != null) {
            session.delete(category);
        }
    }
}
