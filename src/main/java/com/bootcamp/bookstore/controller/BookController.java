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

import com.bootcamp.bookstore.model.Book;
import com.bootcamp.bookstore.model.Category;
import com.bootcamp.bookstore.service.BookService;
import com.bootcamp.bookstore.service.CategoryService;

@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String listBooks(Model theModel) {
        List<Book> theBooks = bookService.getBooks();
        theModel.addAttribute("books", theBooks);
        return "list-books";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model theModel) {
        Book theBook = new Book();
        List<Category> categories = categoryService.getCategories();
        theModel.addAttribute("book", theBook);
        theModel.addAttribute("categories", categories);
        return "book-form";
    }

    @PostMapping("/saveBook")
    public String saveBook(@ModelAttribute("book") Book theBook) {
        if (theBook.getCategory() != null && theBook.getCategory().getId() > 0) {
            Category category = categoryService.getCategory(theBook.getCategory().getId());
            theBook.setCategory(category);
        } else {
            theBook.setCategory(null);
        }

        if (theBook.getId() == 0) {
            bookService.saveBook(theBook);
        } else {
            bookService.updateBook(theBook);
        }
        return "redirect:/book/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("bookId") int theId, Model theModel) {
        Book theBook = bookService.getBook(theId);
        List<Category> categories = categoryService.getCategories();
        theModel.addAttribute("book", theBook);
        theModel.addAttribute("categories", categories);
        return "book-form";
    }

    @GetMapping("/delete")
    public String deleteBook(@RequestParam("bookId") int theId) {
        bookService.deleteBook(theId);
        return "redirect:/book/list";
    }
}
