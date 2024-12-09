<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="addBook.css">
     <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <div class="form-container">
        <h1>Add New Book</h1>
        <form action="AddBook" method="post">
            <label for="book_id">Book ID:</label>
            <input type="number" id="book_id" name="book_id" required>
            
            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" required>
            
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
            
            <label for="num_of_copies">Number of Copies:</label>
            <input type="number" id="num_of_copies" name="num_of_copies" required>
            
            <label for="published_year">Published Year:</label>
            <input type="number" id="published_year" name="published_year" required>
            
            <button type="submit" class="submit-btn">Add Book</button>
        </form>
    </div>
</body>
</html>
