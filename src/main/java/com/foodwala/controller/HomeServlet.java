package com.foodwala.controller;

import java.io.IOException;
import java.util.List;

import com.foodwala.daoimpl.RestaurantDAOImpl;
import com.foodwala.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Landing page - lists all 50 restaurants with search + cuisine filters. */
@WebServlet("/restaurants")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String q = request.getParameter("q");
        String cuisine = request.getParameter("cuisine");

        try {
            List<Restaurant> restaurants = new RestaurantDAOImpl().getAll(q, cuisine);
            request.setAttribute("restaurants", restaurants);
            request.setAttribute("q", q == null ? "" : q);
            request.setAttribute("cuisine", cuisine == null ? "" : cuisine);
            request.setAttribute("pageTitle", "Order food online in Bengaluru");
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dbError", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
