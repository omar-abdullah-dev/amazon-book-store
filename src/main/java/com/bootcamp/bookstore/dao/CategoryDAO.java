package com.bootcamp.bookstore.dao;

import java.util.List;
import com.bootcamp.bookstore.model.Category;

public interface CategoryDAO {

    void save(Category category);

    Category findById(int id);

    List<Category> findAll();

    void update(Category category);

    void delete(int id);
}
