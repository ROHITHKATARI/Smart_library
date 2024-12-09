<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve email from session
    String email = (String) session.getAttribute("email");

    // Redirect to login page if email is not set in the session
    if (email == null) {
        response.sendRedirect("adminWelcome.jsp?error=Please log in");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="admin_dashboard.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <header class="header">
        <div class="logo">Library Admin</div>
        <span class="welcome-message">
            Welcome, <%= session.getAttribute("Name") != null ? session.getAttribute("Name") : "Guest" %>
        </span>
        <nav class="nav-links">
            <a href="updateAdminProfile.jsp">Update Profile</a>
            <a href="deleteProfile?email=<%= session.getAttribute("email") %>" 
   onclick="return confirm('Are you sure you want to delete your profile?');">
   Delete Profile
</a>
            <a href="welcome.jsp" class="logout-btn">Logout</a>
        </nav>
    </header>

    <main class="main-content">
        <div class="content-wrapper">
            <div class="book-list">
                <h1>List of Books</h1>

                <table class="book-table">
                    <thead>
                        <tr>
                            <th>Book ID</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Number of Copies</th>
                            <th>Published Year</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
                                String query = "SELECT * FROM books";
                                PreparedStatement ps = conn.prepareStatement(query);
                                ResultSet rs = ps.executeQuery();

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("book_id") %></td>
                            <td><%= rs.getString("title") %></td>
                            <td><%= rs.getString("author") %></td>
                            <td><%= rs.getInt("num_of_copies") %></td>
                            <td><%= rs.getInt("published_year") %></td>
                            <td><a href="editBook.jsp?book_id=<%= rs.getInt("book_id") %>">Edit</a></td>
                            <td>
                                <a href="deleteBook?book_id=<%= rs.getInt("book_id") %>" 
                                   onclick="return confirm('Are you sure you want to delete this book?');">
                                   Delete
                                </a>
                            </td>
                        </tr>
                        <% 
                                }
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <div class="add-book-btn-container">
        <a href="addBook.jsp" class="add-book-btn">Add New Book</a>
    </div>
</body>
</html>
