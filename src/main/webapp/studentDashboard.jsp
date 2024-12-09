<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve student's name from the session
    String fullName = (String) session.getAttribute("Name");

    // Redirect to login page if the student is not logged in
    if (fullName == null) {
        response.sendRedirect("studentWelcome.jsp?error=Please log in first");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="studentDashboard.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <header>
    <div class="menu-icon" onclick="toggleSidebar()">☰</div>
    <h1 class="welcome-message animated-welcome">
        Welcome, <%= fullName %>! Nice to see you here.
    </h1>
    <div class="my-collections-container">
        <a href="myCollections.jsp" class="my-collections-link animated-collections">MY COLLECTIONS</a>
    </div>
</header>


    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <ul>
    <li><a href="updateStudentProfile.jsp">Profile Refinement</a></li>
    <li>
        <a href="deleteStudentProfile?email=<%= session.getAttribute("email") %>" 
           onclick="return confirm('Are you sure you want to deactivate your profile?');">
           Deactivate Profile
        </a>
    </li>
    <li><a href="welcome.jsp">Logout</a></li>
</ul>

    </div>
    <div id="overlay" class="overlay" onclick="closeSidebar()"></div>

    <!-- Main Content -->
    <main>
        <div class="search-bar">
            <input type="text" placeholder="Search for books...">
            <button>Search</button>
        </div>

        <div class="cards-container">
            <% 
                try {
                    // Establish database connection
                    Connection conn = LIBRARY_PROJECT.dao.DBConnection.getConnection();
                    String query = "SELECT * FROM books";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();

                    // Check if books exist
                    boolean booksAvailable = false;

                    while (rs.next()) {
                        booksAvailable = true;
            %>
                        <div class="card">
                            <h3><%= rs.getString("title") %></h3>
                            <p>Author: <%= rs.getString("author") %></p>
                            <p>Published Year: <%= rs.getInt("published_year") %></p>
                            <!--  <p>Copies Available:<%= rs.getInt("num_of_copies") %></p>-->
                           <a href="BorrowBook.jsp?book_id=<%= rs.getInt("book_id") %>&title=<%= rs.getString("title") %>">
    							<button class="borrow-button">Borrow Book</button>
							</a> 
                        </div>
            <% 
                    }
                    if (!booksAvailable) {
            %>
                    <p>No books are currently available.</p>
            <% 
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error retrieving books: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </main>

    <!-- JavaScript for Sidebar -->
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            sidebar.style.left = sidebar.style.left === '0px' ? '-300px' : '0px';
            overlay.style.display = sidebar.style.left === '0px' ? 'block' : 'none';
        }

        function closeSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            sidebar.style.left = '-300px';
            overlay.style.display = 'none';
        }
    </script>
</body>
</html>
