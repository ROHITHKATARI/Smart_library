<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve student email from session
    String email = (String) session.getAttribute("email");

    // Redirect to login if not logged in
    if (email == null) {
        response.sendRedirect("studentDashboard.jsp?error=Please log in");
        return;
    }

    // Fetch borrowed books from database
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
        String query = "SELECT book_id, title, borrow_date, submission_date FROM borrowed_books WHERE student_email = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, email);
        rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="my_collections.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <header class="header">
        <div class="logo">My Library Collections</div>
        <nav class="nav-links">
            <a href="studentDashboard.jsp">Dashboard</a>
            <a href="welcome.jsp" class="logout-btn">Logout</a>
        </nav>
    </header>
    
    <main class="main-content">
        <h1>Your Borrowed Books</h1>
        <table class="borrowed-books-table">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Borrow Date</th>
                    <th>Submission Date</th>
                    <th>Action</th>
                    <th>Read Book</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    boolean hasBooks = false;
                    while (rs.next()) {
                        hasBooks = true;
                %>
                <tr>
                    <td><%= rs.getInt("book_id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getDate("borrow_date") %></td>
                    <td><%= rs.getDate("submission_date") %></td>
                    <td>
                        <form action="return_book" method="post">
                            <input type="hidden" name="book_id" value="<%= rs.getInt("book_id") %>">
                            <button type="submit" class="return-btn">Return</button>
                        </form>
                    </td>
                    <td>
                        <a href="readBook.jsp?book_id=<%= rs.getInt("book_id") %>" class="read-btn">Read</a>
                    </td>
                </tr>
                <% 
                    }
                    if (!hasBooks) {
                %>
                <tr>
                    <td colspan="6" class="no-books">You haven't borrowed any books yet.</td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
