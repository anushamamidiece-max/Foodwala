<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodwala.model.User" %>
<%@ page import="com.foodwala.model.CartItem" %>
<%
    String ctx = request.getContextPath();
    User loginUser = (User) session.getAttribute("user");
    @SuppressWarnings("unchecked")
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    int cartCount = (cartItems == null) ? 0 : cartItems.size();
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null) pageTitle = "Fresh food, delivered fast";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= pageTitle %> · Foodwala</title>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ctext y='.9em' font-size='90'%3E%F0%9F%8D%94%3C/text%3E%3C/svg%3E">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>

<nav class="navbar">
    <div class="nav-inner">
        <a href="<%= ctx %>/restaurants" class="logo ripple">🍔 Food<span>wala</span></a>

        <div class="location" title="Delivery location">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M12 21s-7-5.1-7-11a7 7 0 1 1 14 0c0 5.9-7 11-7 11z"/><circle cx="12" cy="10" r="2.6"/></svg>
            Bengaluru <span class="chev">▾</span>
        </div>

        <form class="nav-search" action="<%= ctx %>/restaurants" method="get">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
            <input type="text" name="q" value="<%= request.getAttribute("q") == null ? "" : request.getAttribute("q") %>"
                   placeholder="Search for restaurants, cuisines or dishes…">
        </form>

        <div class="nav-links">
            <a href="<%= ctx %>/restaurants" class="nav-link ripple">Restaurants</a>
            <% if (loginUser != null) { %>
                <a href="<%= ctx %>/orders" class="nav-link ripple">Orders</a>
            <% } %>
            <a href="<%= ctx %>/cart" class="nav-link ripple cart-link">
                <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="9" cy="20" r="1.6"/><circle cx="17" cy="20" r="1.6"/><path d="M3 4h2l2.4 12.2A2 2 0 0 0 9.4 18h7.7a2 2 0 0 0 2-1.6L21 8H6"/></svg>
                Cart
                <% if (cartCount > 0) { %><span class="cart-badge"><%= cartCount %></span><% } %>
            </a>
            <% if (loginUser != null) { %>
                <span class="nav-user">Hi, <%= loginUser.getName().split(" ")[0] %></span>
                <a href="<%= ctx %>/logout" class="nav-link ripple logout">Logout</a>
            <% } else { %>
                <a href="<%= ctx %>/login" class="btn btn-outline btn-sm ripple">Login</a>
            <% } %>
        </div>
    </div>
</nav>
