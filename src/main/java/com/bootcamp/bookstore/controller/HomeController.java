package com.bootcamp.bookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bootcamp.bookstore.service.AuthorService;
import com.bootcamp.bookstore.service.BookService;
import com.bootcamp.bookstore.service.CategoryService;

@Controller
public class HomeController {

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AuthorService authorService;

    @GetMapping("/")
    public String showHomePage(Model model) {
        model.addAttribute("totalBooks", bookService.getBooks().size());
        model.addAttribute("totalCategories", categoryService.getCategories().size());
        model.addAttribute("totalAuthors", authorService.getAuthors().size());
        model.addAttribute("recentBooks", bookService.getBooks());
        return "home";
    }
}
