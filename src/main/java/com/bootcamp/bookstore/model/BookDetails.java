package com.bootcamp.bookstore.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Pattern;
import com.bootcamp.bookstore.util.AppConstants;

@Entity
@Table(name = "book_details")
public class BookDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Pattern(regexp = AppConstants.ISBN_FORMAT, message = AppConstants.ISBN_ERROR_MESSAGE)
    @Column(name = "isbn")
    private String isbn;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "publication_date")
    private Date publicationDate;

    @Column(name = "publisher")
    private String publisher;

    @Column(name = "number_of_pages")
    private int numberOfPages;

    @Column(name = "language")
    private String language;

    @OneToOne(optional = false)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    public BookDetails() {
    }

    public BookDetails(String isbn, Date publicationDate, String publisher, int numberOfPages, String language, Book book) {
        this.isbn = isbn;
        this.publicationDate = publicationDate;
        this.publisher = publisher;
        this.numberOfPages = numberOfPages;
        this.language = language;
        this.book = book;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public int getNumberOfPages() {
        return numberOfPages;
    }

    public void setNumberOfPages(int numberOfPages) {
        this.numberOfPages = numberOfPages;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @Override
    public String toString() {
        return "BookDetails [id=" + id
                + ", isbn=" + isbn
                + ", publicationDate=" + publicationDate
                + ", publisher=" + publisher
                + ", numberOfPages=" + numberOfPages
                + ", language=" + language + "]";
    }
}