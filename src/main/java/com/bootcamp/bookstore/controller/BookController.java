package com.bootcamp.bookstore.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bootcamp.bookstore.model.Author;
import com.bootcamp.bookstore.model.Book;
import com.bootcamp.bookstore.model.BookDetails;
import com.bootcamp.bookstore.model.Category;
import com.bootcamp.bookstore.service.AuthorService;
import com.bootcamp.bookstore.service.BookService;
import com.bootcamp.bookstore.service.CategoryService;

@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AuthorService authorService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @GetMapping("/list")
    public String listBooks(Model theModel) {
        List<Book> theBooks = bookService.getBooks();
        theModel.addAttribute("books", theBooks);
        return "list-books";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model theModel) {
        Book theBook = new Book();
        theBook.setBookDetails(new BookDetails());
        theBook.setCategory(new Category());
        List<Category> categories = categoryService.getCategories();
        List<Author> authors = authorService.getAuthors();
        theModel.addAttribute("book", theBook);
        theModel.addAttribute("categories", categories);
        theModel.addAttribute("authors", authors);
        return "book-form";
    }

    @PostMapping("/saveBook")
    public String saveBook(@ModelAttribute("book") Book theBook,
                           @RequestParam(value = "authorIds", required = false) List<Integer> authorIds,
                           Model theModel) {

        boolean hasError = false;

        // Validate Title
        if (theBook.getTitle() == null || theBook.getTitle().trim().isEmpty()) {
            theModel.addAttribute("titleError", "Book title is required.");
            hasError = true;
        }

        // Validate Category
        if (theBook.getCategory() == null || theBook.getCategory().getId() <= 0) {
            theModel.addAttribute("categoryError", "Please select a category.");
            hasError = true;
            theBook.setCategory(new Category());
        } else {
            Category category = categoryService.getCategory(theBook.getCategory().getId());
            theBook.setCategory(category != null ? category : new Category());
        }

        // at least one author
        if (authorIds == null || authorIds.isEmpty()) {
            theModel.addAttribute("authorError", "Please select at least one author for this book.");
            hasError = true;
            theBook.setAuthors(new ArrayList<>());
        } else {
            List<Author> selectedAuthors = new ArrayList<>();
            for (Integer authorId : authorIds) {
                Author author = authorService.getAuthor(authorId);
                if (author != null) {
                    selectedAuthors.add(author);
                }
            }
            theBook.setAuthors(selectedAuthors);
        }

        //  Language
        if (theBook.getBookDetails() == null ||
            theBook.getBookDetails().getLanguage() == null ||
            theBook.getBookDetails().getLanguage().trim().isEmpty()) {
            theModel.addAttribute("languageError", "Please select a language for this book.");
            hasError = true;
        }

        if (hasError) {
            if (theBook.getBookDetails() == null) {
                theBook.setBookDetails(new BookDetails());
            }
            List<Category> categories = categoryService.getCategories();
            List<Author> authors = authorService.getAuthors();
            theModel.addAttribute("categories", categories);
            theModel.addAttribute("authors", authors);
            return "book-form";
        }

        if (theBook.getBookDetails() != null) {
            theBook.getBookDetails().setBook(theBook);
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
        if (theBook.getBookDetails() == null) {
            theBook.setBookDetails(new BookDetails());
        }
        if (theBook.getCategory() == null) {
            theBook.setCategory(new Category());
        }
        List<Category> categories = categoryService.getCategories();
        List<Author> authors = authorService.getAuthors();
        theModel.addAttribute("book", theBook);
        theModel.addAttribute("categories", categories);
        theModel.addAttribute("authors", authors);
        return "book-form";
    }

    @GetMapping("/delete")
    public String deleteBook(@RequestParam("bookId") int theId) {
        bookService.deleteBook(theId);
        return "redirect:/book/list";
    }
}
