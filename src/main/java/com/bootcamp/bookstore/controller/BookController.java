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
    public String listBooks(Model model) {
        List<Book> booksList = bookService.getBooks();
        model.addAttribute("books", booksList);
        return "list-books";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model model) {
        Book bookModel = new Book();
        bookModel.setBookDetails(new BookDetails());
        bookModel.setCategory(new Category());
        List<Category> categoriesList = categoryService.getCategories();
        List<Author> authorsList = authorService.getAuthors();
        model.addAttribute("book", bookModel);
        model.addAttribute("categories", categoriesList);
        model.addAttribute("authors", authorsList);
        return "book-form";
    }

    @PostMapping("/saveBook")
    public String saveBook(@ModelAttribute("book") Book bookModel,
                           @RequestParam(value = "authorIds", required = false) List<Integer> authorIds,
                           Model model) {

        boolean hasError = false;

        // Validate Title
        if (bookModel.getTitle() == null || bookModel.getTitle().trim().isEmpty()) {
            model.addAttribute("titleError", "Book title is required.");
            hasError = true;
        }

        // Validate Category
        if (bookModel.getCategory() == null || bookModel.getCategory().getId() <= 0) {
            model.addAttribute("categoryError", "Please select a category.");
            hasError = true;
            bookModel.setCategory(new Category());
        } else {
            Category category = categoryService.getCategory(bookModel.getCategory().getId());
            bookModel.setCategory(category != null ? category : new Category());
        }

        // Validate Authors (at least one author)
        if (authorIds == null || authorIds.isEmpty()) {
            model.addAttribute("authorError", "Please select at least one author for this book.");
            hasError = true;
            bookModel.setAuthors(new ArrayList<>());
        } else {
            List<Author> selectedAuthors = new ArrayList<>();
            for (Integer authorId : authorIds) {
                Author author = authorService.getAuthor(authorId);
                if (author != null) {
                    selectedAuthors.add(author);
                }
            }
            bookModel.setAuthors(selectedAuthors);
        }

        // Validate Language
        if (bookModel.getBookDetails() == null ||
            bookModel.getBookDetails().getLanguage() == null ||
            bookModel.getBookDetails().getLanguage().trim().isEmpty()) {
            model.addAttribute("languageError", "Please select a language for this book.");
            hasError = true;
        }

        // Validate ISBN (Format & Uniqueness)
        if (bookModel.getBookDetails() != null && bookModel.getBookDetails().getIsbn() != null) {
            String isbn = bookModel.getBookDetails().getIsbn().trim();
            if (isbn.isEmpty()) {
                model.addAttribute("isbnError", "ISBN is required.");
                hasError = true;
            } else if (!isbn.matches("^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$") && !isbn.matches("^[0-9\\-]{9,20}$")) {
                model.addAttribute("isbnError", "Invalid ISBN format. (Example: 978-0132350884)");
                hasError = true;
            } else {
                // Check uniqueness against existing books
                List<Book> allBooks = bookService.getBooks();
                for (Book existingBook : allBooks) {
                    if (existingBook.getId() != bookModel.getId() && 
                        existingBook.getBookDetails() != null && 
                        existingBook.getBookDetails().getIsbn() != null &&
                        existingBook.getBookDetails().getIsbn().trim().equalsIgnoreCase(isbn)) {
                        model.addAttribute("isbnError", "A book with ISBN '" + isbn + "' already exists. ISBN must be unique.");
                        hasError = true;
                        break;
                    }
                }
            }
        }

        if (hasError) {
            if (bookModel.getBookDetails() == null) {
                bookModel.setBookDetails(new BookDetails());
            }
            List<Category> categoriesList = categoryService.getCategories();
            List<Author> authorsList = authorService.getAuthors();
            model.addAttribute("categories", categoriesList);
            model.addAttribute("authors", authorsList);
            return "book-form";
        }

        if (bookModel.getBookDetails() != null) {
            bookModel.getBookDetails().setBook(bookModel);
        }

        if (bookModel.getId() == 0) {
            bookService.saveBook(bookModel);
        } else {
            bookService.updateBook(bookModel);
        }
        return "redirect:/book/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("bookId") int bookId, Model model) {
        Book bookModel = bookService.getBook(bookId);
        if (bookModel.getBookDetails() == null) {
            bookModel.setBookDetails(new BookDetails());
        }
        if (bookModel.getCategory() == null) {
            bookModel.setCategory(new Category());
        }
        List<Category> categoriesList = categoryService.getCategories();
        List<Author> authorsList = authorService.getAuthors();
        model.addAttribute("book", bookModel);
        model.addAttribute("categories", categoriesList);
        model.addAttribute("authors", authorsList);
        return "book-form";
    }

    @GetMapping("/viewMore")
    public String viewMoreBook(@RequestParam("bookId") int bookId, Model model) {
        Book bookModel = bookService.getBook(bookId);
        model.addAttribute("book", bookModel);
        return "viewMore";
    }

    @GetMapping("/delete")
    public String deleteBook(@RequestParam("bookId") int bookId) {
        bookService.deleteBook(bookId);
        return "redirect:/book/list";
    }
}
