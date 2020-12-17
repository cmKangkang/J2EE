<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="icon" href="/icon/log-in-outline.svg"/>
    <script src="https://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/login-style.css" type="text/css">
</head>


<body>
    <div class="container">
        <div class="tit">
            <h2>Register</h2>
        </div>
        <form action="/user/register" method="post">
            <input id="id" type="text" name="userID" placeholder="enter your account">
            <input id="pwd" type="text" name="userPWD" placeholder="enter your password">
            <input id="btn" type="submit" value="Sign up">
        </form>
        <div class="tips">Already have an account, go to <a href="/pages/login.jsp">Sign in</a>.</div>
    </div>
</body>
</html>