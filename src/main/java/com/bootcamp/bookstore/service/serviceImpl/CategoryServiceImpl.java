package com.bootcamp.bookstore.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bootcamp.bookstore.dao.CategoryDAO;
import com.bootcamp.bookstore.model.Category;
import com.bootcamp.bookstore.service.CategoryService;
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDAO categoryDAO;

    @Override
    @Transactional
    public void saveCategory(Category category) {
        categoryDAO.save(category);
    }

    @Override
    @Transactional
    public Category getCategory(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    @Transactional
    public List<Category> getCategories() {
        return categoryDAO.findAll();
    }

    @Override
    @Transactional
    public void updateCategory(Category category) {
        categoryDAO.update(category);
    }

    @Override
    @Transactional
    public void deleteCategory(int id) {
        categoryDAO.delete(id);
    }
}