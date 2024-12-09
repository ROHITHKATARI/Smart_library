<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Hub</title>
    <link rel="stylesheet" href="./adminWelcome.css">
     <link rel="icon" type="image/png" href="./images/icon.png">
</head>
<body>
    <div class="background-wrap">
        <h1 class="main-heading">WELCOME TO ADMIN PORTAL</h1>
        <div class="login-wrap">
            <div class="login-html">
                <input id="tab-1" type="radio" name="tab" class="sign-in" checked>
                <label for="tab-1" class="tab">Login</label>
                <input id="tab-2" type="radio" name="tab" class="sign-up">
                <label for="tab-2" class="tab">Sign Up</label>
                <div class="login-form">
                    <!-- Login Form -->
                    <form action="admin-login" method="post" class="sign-in-htm">
                        <div class="group">
                            <br>
                            <label for="user" class="label">Email</label>
                            <input id="email" name="email" type="email" class="input" placeholder="Enter your email">
                        </div>
                        <div class="group">
                            <label for="pass" class="label">Password</label>
                            <input id="pass" name="password" type="password" class="input" data-type="password" placeholder="Enter your password">
                        </div>
                        <div class="group">
                            <input id="check" type="checkbox" class="check" checked>
                            <label for="check"><span class="icon"></span> Keep me Signed in</label>
                        </div>
                        <div class="group">
                            <input type="submit" class="button" value="Login">
                        </div>
                        <div class="hr"></div>
                        <div class="foot-lnk">
                            <a href="#forgot">Forgot Password?</a>
                        </div>
                    </form>

                    <!-- Sign Up Form -->
                    <form action="admin-signup" method="post" class="sign-up-htm">
                        <div class="group">
                            <br>
                            <label for="user" class="label">Name</label>
                            <input id="user" name="username" type="text" class="input" placeholder="Choose a username">
                        </div>
                        <div class="group">
                            <label for="pass" class="label">Password</label>
                            <input id="pass" name="password" type="password" class="input" data-type="password" placeholder="Enter your password">
                        </div>
                        <div class="group">
                            <label for="pass" class="label">Mobile Number</label>
                            <input id="mobile" name="mobile" type="number" class="input" data-type="number" placeholder="Enter your Mobile Number">
                        </div>
                        <div class="group">
                            <label for="email" class="label">Email Address</label>
                            <input id="email" name="email" type="email" class="input" placeholder="Enter your email">
                        </div>
                        <div class="group">
                            <input type="submit" class="button" value="Sign Up">
                        </div>
                        <div class="hr"></div>
                        <div class="foot-lnk">
                            <label for="tab-1">Already Member?</label>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
