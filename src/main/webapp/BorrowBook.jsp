<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="addBook.css">
    <link rel="icon" type="image/png" href="./images/icon.png">
    <script>
        // Set the borrow date to the user's local date
        window.onload = function () {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById("borrow_date").value = today;
        };
    </script>
</head>
<body>
    <div class="form-container">
        <h1>Borrow this Book</h1>
        <form action="borrow_book" method="post">
            <!-- Book ID (Read-Only) -->
            <label for="book_id">Book ID:</label>
            <input type="number" id="book_id" name="book_id" value="<%= request.getParameter("book_id") %>" readonly>
            
            <!-- Book Title (Read-Only) -->
            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" value="<%= request.getParameter("title") %>" readonly>
            
            <!-- Borrow Date (Automatically Set to Local Date) -->
            <label for="borrow_date">Borrow Date:</label>
            <input type="date" id="borrow_date" name="borrow_date" readonly>
            
            <!-- Submission Date (User Input) -->
            <label for="submission_date">Submission Date:</label>
            <input type="date" id="submission_date" name="submission_date" required>
            
            <!-- College Roll Number (User Input) -->
            <label for="college_roll_number">College Roll Number:</label>
            <input type="text" id="college_roll_number" name="college_roll_number" required>
            
            <!-- Submit Button -->
            <button type="submit" class="submit-btn">Request Book</button>
        </form>
    </div>
</body>
</html>
