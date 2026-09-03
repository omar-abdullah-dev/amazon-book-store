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

import com.bootcamp.bookstore.model.Author;
import com.bootcamp.bookstore.service.AuthorService;

@Controller
@RequestMapping("/author")
public class AuthorController {

    @Autowired
    private AuthorService authorService;

    @GetMapping("/list")
    public String listAuthors(Model model) {
        List<Author> authorsList = authorService.getAuthors();
        model.addAttribute("authors", authorsList);
        return "list-authors";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model model) {
        Author authorModel = new Author();
        model.addAttribute("author", authorModel);
        return "author-form";
    }

    @PostMapping("/saveAuthor")
    public String saveAuthor(@ModelAttribute("author") Author authorModel, Model model) {
        // Backend Validation
        if (authorModel.getAuthorName() == null || authorModel.getAuthorName().trim().isEmpty()) {
            model.addAttribute("nameError", "Author name is required.");
            return "author-form";
        }

        // Duplicate Name Check
        List<Author> existingAuthors = authorService.getAuthors();
        for (Author existing : existingAuthors) {
            if (existing.getAuthorName().equalsIgnoreCase(authorModel.getAuthorName().trim()) 
                && existing.getId() != authorModel.getId()) {
                model.addAttribute("nameError", "Author '" + authorModel.getAuthorName().trim() + "' already exists.");
                return "author-form";
            }
        }

        if (authorModel.getId() == 0) {
            authorService.saveAuthor(authorModel);
        } else {
            authorService.updateAuthor(authorModel);
        }
        return "redirect:/author/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("authorId") int authorId, Model model) {
        Author authorModel = authorService.getAuthor(authorId);
        model.addAttribute("author", authorModel);
        return "author-form";
    }

    @GetMapping("/delete")
    public String deleteAuthor(@RequestParam("authorId") int authorId) {
        authorService.deleteAuthor(authorId);
        return "redirect:/author/list";
    }
}
