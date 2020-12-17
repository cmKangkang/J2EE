<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ajax-test</title>
    <script src="/js/jquery/jquery-3.3.1.js"></script>
    <script src="/js/jquery/axios.js"></script>
<%--    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>--%>
</head>
<body>
<div id="ht">
    <button onclick="myclick()">获取测试1</button><br>
    <button onclick="myclick2()">获取测试2</button>
</div>
<div id="show">
    data:<br>${requestScope.data}
</div>
<hr>
<div id=""show2>
    data:<br>
</div>

<form>
    账号: <input id="usr" type="text" name="userID"><br>
    密码： <input id="pwd" type="password" name="userPWD"><br>
</form>
<button value="login" onclick="signup()">注册</button>
</body>
<br>
<br>
<form>
    账号: <input id="usr1" type="text" name="userID"><br>
    密码： <input id="pwd1" type="password" name="userPWD"><br>
</form>
<button value="login" onclick="signup1()">注册</button>
</body>

<script>
    function signup(){
        var json=JSON.stringify({"userID":$("#usr").val(),"userPWD":$("#pwd").val()});
        alert(json);
        $.ajax({
            url:"/user/json",
            // dataType:"json",
            contentType:"application/json;charset=UTF-8",
            data:json,
            async:false,
            type:"POST",
            success:function(data){
                alert(data+"   "+data.userID+", "+data.userPWD);

            },
            erro:function(data){
                alert(data);
            }
        });
    }

    function signup1(){
        var json={"userID":$("#usr").val(),"userPWD":$("#pwd").val()};
        axios.post("/user/json",json).then(function(res){
           alert(res.userID," 1 ",res.userPWD)
        }).catch(erro=>{
            alert(erro);
        });
    }
    // $(function (){
    //     $("#ht button").click(function (){
    //         $.ajax({
    //             url:"/student/gcl",
    //             type:"get",
    //             dataType:"json",
    //             data:{userID:2018},
    //             async:true,
    //             success:function(ret){
    //                 for (let retKey in ret.data) {
    //                     $("#show").append(retKey);
    //                 }
    //             }
    //         })
    //     })
    // })
    function myclick(){
        $.ajax({
            url:"/student/gcl",
            type:"post",
            // dataType:"json",
            data:{userID:2018},
            async:false,
            success:function(ret){
                var d=eval(ret);
                console.log(ret);
                $("#show").text(d);
            },
            erro:function (msg){
                alert(msg);
            }
        })
    }

    function myclick2(){
        $.ajax({
            url:"/student/test",
            async: "false",
            type:"get",
            // dataType: "json",
            success:function(data){
                alert("success/n",data);
                $("#show2").text(data);
            }
        });
    }
</script>
</html>