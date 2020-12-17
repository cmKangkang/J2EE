<!DOCTYPE html>
<html>
<head>
    <META http-equiv=Content-Type content="text/html;charset=utf-8">
    <title>Login</title>
    <link rel="icon" href="/icon/log-in-outline.svg"/>
    <script src="https://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/login-style.css" type="text/css"></link>
</head>

<body>
    <div class="container">
        <div class="tit">
            <h2>Login</h2>
        </div>
        <form action="/user/login3" method="post">
        <input id="id" type="text" name="userID" placeholder="enter your account">
        <input id="pwd" type="text" name="userPWD" placeholder="enter your password">
        <input id="btn" type="submit" value="Sign in">
        </form>
        <div class="tips">Do not have an account? <a href="/pages/register.jsp">Sign up</a>.</div>
    </div>
</body>
<!--<script>-->
<!--    $(function(){-->
<!--        $('#log-in').click(function(){-->
<!--            var acc=$('#account').val();-->
<!--            var pwd=$('#password').val();-->
<!--            var json={-->
<!--                userID:acc,-->
<!--                userPWD:pwd,-->
<!--            }-->
<!--            $.ajax({-->
<!--                url:"/user/login2",-->
<!--                type:"post",-->
<!--                data:json,-->
<!--                async:false,-->
<!--                success:()=>{},-->
<!--                erro:()=>{}-->
<!--            })-->
<!--        })-->

<!--        function login(){-->
<!--            var acc=$('#account').val();-->
<!--            var pwd=$('#password').val();-->
<!--            var json={-->
<!--                userID:acc,-->
<!--                userPWD:pwd,-->
<!--            }-->
<!--            $.ajax({-->
<!--                url:"/user/login2",-->
<!--                type:"post",-->
<!--                data:json,-->
<!--                async:false,-->
<!--                success:()=>{},-->
<!--                erro:()=>{}-->
<!--            })-->
<!--        }-->
<!--    })-->
<!--</script>-->

</html>