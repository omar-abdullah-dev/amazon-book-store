package com.bootcamp.bookstore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bootcamp.bookstore.model.Category;
import com.bootcamp.bookstore.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String listCategories(Model model) {
        List<Category> categoriesList = categoryService.getCategories();
        model.addAttribute("categories", categoriesList);
        return "list-categories";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model model) {
        Category categoryModel = new Category();
        model.addAttribute("category", categoryModel);
        return "category-form";
    }

    @PostMapping("/saveCategory")
    public String saveCategory(@ModelAttribute("category") Category categoryModel, Model model) {
        // Backend Validation
        if (categoryModel.getCategoryName() == null || categoryModel.getCategoryName().trim().isEmpty()) {
            model.addAttribute("nameError", "Category name is required.");
            return "category-form";
        }

        // Duplicate Name Check
        List<Category> existingCategories = categoryService.getCategories();
        for (Category existing : existingCategories) {
            if (existing.getCategoryName().equalsIgnoreCase(categoryModel.getCategoryName().trim()) 
                && existing.getId() != categoryModel.getId()) {
                model.addAttribute("nameError", "Category '" + categoryModel.getCategoryName().trim() + "' already exists.");
                return "category-form";
            }
        }

        if (categoryModel.getId() == 0) {
            categoryService.saveCategory(categoryModel);
        } else {
            categoryService.updateCategory(categoryModel);
        }
        return "redirect:/category/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("categoryId") int categoryId, Model model) {
        Category categoryModel = categoryService.getCategory(categoryId);
        model.addAttribute("category", categoryModel);
        return "category-form";
    }

    @GetMapping("/delete")
    public String deleteCategory(@RequestParam("categoryId") int categoryId) {
        categoryService.deleteCategory(categoryId);
        return "redirect:/category/list";
    }
}
