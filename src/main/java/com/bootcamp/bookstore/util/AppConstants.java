package com.bootcamp.bookstore.util;

public final class AppConstants {

    private AppConstants() {
        // Private constructor to prevent instantiation
    }

    /**
     * Standard ISBN Regex Pattern supporting ISBN-10, ISBN-13 (with/without hyphens or prefix).
     */
    public static final String ISBN_FORMAT = "^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$|^[0-9\\-]{9,20}$";

    public static final String ISBN_ERROR_MESSAGE = "Invalid ISBN format. (Example: 978-0132350884)";
    
    public static final String DATE_FORMAT = "yyyy-MM-dd";
}
