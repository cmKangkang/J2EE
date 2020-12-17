$(function(){
    $(".btn #log-in").click(function(){
        $.ajax({
            url:"/user/login",
            type:"POST",
            async:true,
            dataType:"json",
            data:JSON.stringify({"userID":$(".acc").val(),"userPWD":$(".pas").val()}),
            success:function(data){}
        });
    })
});