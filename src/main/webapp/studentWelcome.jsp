<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Library Hub</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="./studentWelcome.css">
	 <link rel="icon" type="image/png" href="./images/icon.png">
	<link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700,800&display=swap" rel="stylesheet">
</head>
<body>
	<!-- Portal Heading -->
	<h1 class="portal-header">Welcome to Student Portal</h1>

	<div class="cont">
		<!-- Login Form -->
		<form class="form sign-in" action="student_login" method="post">
			<h2>Login</h2>
			<label>
				<input type="email" name="email" placeholder="Enter your Email" required>
			</label>
			<label>
				<input type="password" name="password" placeholder="Enter your Password" required>
			</label>
			<button class="submit" type="submit">Login</button>

			<div class="social-media">
				<ul>
					<li><img src="./images/facebook.png" alt="Facebook"></li>
					<li><img src="images/twitter.png" alt="Twitter"></li>
					<li><img src="images/linkedin.png" alt="LinkedIn"></li>
					<li><img src="images/instagram.png" alt="Instagram"></li>
				</ul>
			</div>
		</form>

		<div class="sub-cont">
			<div class="img">
				<div class="img-text m-up">
					<h1>New here?</h1>
					<p>Sign up and discover</p>
				</div>
				<div class="img-text m-in">
					<h1>One of us?</h1>
					<p>Just Login</p>
				</div>
				<div class="img-btn">
					<span class="m-up">Sign Up</span>
					<span class="m-in">Login</span>
				</div>
			</div>

			<!-- Sign-Up Form -->
			<form class="form sign-up" action="student_signup" method="post">
				<h2>Sign Up</h2>
				<label>
					<input type="text" name="name" placeholder="Enter your Name" required>
				</label>
				<label>
					<input type="email" name="email" placeholder="Enter your Email" required>
				</label>
				<label>
					<input type="password" name="password" placeholder="Password" required>
				</label>
				<label>
					<input type="tel" name="mobile" placeholder="Enter your Mobile No" required>
				</label>
				<button type="submit" class="submit">Sign Up Now</button>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		document.querySelector('.img-btn').addEventListener('click', function()
				{
					document.querySelector('.cont').classList.toggle('s-signup')
				}
			);
	</script>
</body>
</html>
