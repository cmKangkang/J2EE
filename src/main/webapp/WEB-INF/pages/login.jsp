<%--
  Created by IntelliJ IDEA.
  User: RKK
  Date: 2020/11/1
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login</title>
</head>
<body>
<div>
    <form action="/user/login" method="post">
        账号: <input type="text" name="userID"><br>
        密码： <input type="password" name="userPWD"><br>
        <input type="button" value="login">
    </form>
</div>
</body>
</html>
