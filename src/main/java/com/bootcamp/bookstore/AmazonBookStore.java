package com.bootcamp.bookstore;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AmazonBookStore {

    public static void main(String[] args) {

        ClassPathXmlApplicationContext context =
                new ClassPathXmlApplicationContext("application-context.xml");

        System.out.println("Spring Container created");

        context.close();
    }
}