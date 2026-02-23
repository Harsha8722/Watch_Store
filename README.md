# WatchStore - Premium E-Commerce Application

A high-end, modern e-commerce platform for luxury timepieces built with **Spring Boot 3**, **Java 17+,** **JSP**, and **Bootstrap 5**.

## ✨ Features

- **Luxury User Interface**: Minimalist gold-on-black theme with glassmorphism effects and smooth animations.
- **Dark/Light Mode**: Full support for theme switching.
- **User Authentication**: Secure Login/Registration with Role-Based Access Control (RBAC).
- **Product Management**: Browse by categories (Luxury, Sports, Casual, Smartwatch), search, and filter.
- **Shopping Experience**: Add to cart, wishlist, and seamless checkout flow.
- **Order Tracking**: Detailed order history and status tracking for users.
- **Admin Dashboard**: Comprehensive management of products, orders, and users.
- **REST API Support**: Built-in Swagger/OpenAPI documentation.

## 🛠️ Technology Stack

- **Backend**: Java 17+, Spring Boot 3.x, Spring Data JPA, Spring Security.
- **Database**: MySQL.
- **Frontend**: JSP, JSTL, Bootstrap 5, FontAwesome 6, Chart.js.
- **Build Tool**: Maven.

## 🚀 Getting Started

### Prerequisites

- JDK 17 or higher.
- MySQL Server.
- Maven.

### Configuration

1. **Database Setup**:
   - Create a database named `watchstore` in MySQL.
   - Update `src/main/resources/application.properties` with your database credentials.

2. **File Storage**:
   - The application stores uploaded images in `d:/Watches/uploads/` by default. You can change this in `application.properties`:
     ```properties
     app.upload.dir=path/to/your/upload/folder/
     ```

### Running the Application

```bash
mvn clean spring-boot:run
```

The application will be available at [http://localhost:8080](http://localhost:8080).

### Demo Credentials

- **Admin**: `admin@watchstore.com` / `admin123`
- **User**: `user@watchstore.com` / `user123`

## 📖 API Documentation

Once the application is running, you can access the Swagger UI at:
[http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)

## 📁 Project Structure

```text
src/main/java/com/watchstore/
├── config/         # Security, MVC, and Data configurations
├── controller/     # Web & API controllers
├── dto/            # Data Transfer Objects
├── entity/         # JPA Entities
├── repository/     # Data Access Objects
└── service/        # Business Logic
src/main/webapp/
├── WEB-INF/views/  # JSP views
└── static/         # CSS, JS, and Images
```

---
*Built with elegance by Antigravity AI.*
