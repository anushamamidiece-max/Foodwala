# 🍔 Foodwala — Java Full Stack Food Delivery Web Application

<p align="center">

A full-stack food delivery web application built using Java, Servlets, JSP, JDBC and MySQL.

</p>

<p align="center">

🔎 Search Restaurants • 🍔 Browse Food • 🛒 Cart • 💳 Checkout • 📦 Orders

</p>

---

## 🌐 Project Links

### 🚀 Live Demo

> Full-stack live deployment link will be added after deploying the Java application.

**Live Demo:**  
[Coming Soon]

### 💻 GitHub Repository

[Foodwala – Java Full Stack Food Delivery Application](https://github.com/YOUR-USERNAME/Foodwala)

---

# 📌 About The Project

Foodwala is a Zomato-style food delivery web application developed as a Java Full Stack project.

The application allows users to discover restaurants, browse menus, search for food, add items to a session-based cart, place orders and view their order history.

The project follows an MVC-style architecture using:

- Java Servlets
- JSP
- JDBC
- MySQL
- Apache Tomcat
- HTML
- CSS
- JavaScript

The application is designed with a fresh-food visual theme featuring rounded cards, hover effects, accent glow and click-ripple animations.

---

# 🎯 Project Objectives

The main objectives of Foodwala are:

- Build a complete Java Full Stack web application.
- Implement MVC architecture.
- Connect Java application with MySQL using JDBC.
- Implement CRUD database operations.
- Implement user registration and login.
- Implement session-based shopping cart functionality.
- Implement checkout and order placement.
- Store orders and order items in MySQL.
- Build a responsive and interactive food-delivery UI.
- Understand how frontend, backend and database layers communicate.

---

# 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Java Servlets |
| View | JSP |
| Database Connectivity | JDBC |
| Database | MySQL |
| Database Tool | MySQL Workbench |
| Server | Apache Tomcat 10.1 |
| Java Version | Java 17+ / Java 21 |
| Architecture | MVC |
| IDE | Eclipse IDE for Enterprise Java and Web Developers |
| JDBC Driver | MySQL Connector/J |

---

# 🏗️ Architecture

Foodwala follows an MVC-based layered architecture.

```text
                ┌─────────────────────┐
                │      Browser        │
                │ HTML/CSS/JavaScript │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │     JSP / View      │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Java Servlets       │
                │    Controller       │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │        DAO          │
                │    DAO Interface    │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │     DAOImpl         │
                │       JDBC          │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │       MySQL         │
                └─────────────────────┘