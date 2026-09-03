package com.bootcamp.bookstore.service;

import java.util.List;
import com.bootcamp.bookstore.model.Category;

public interface CategoryService {

    void saveCategory(Category category);

    Category getCategory(int id);

    List<Category> getCategories();

    void updateCategory(Category category);

    void deleteCategory(int id);
}
