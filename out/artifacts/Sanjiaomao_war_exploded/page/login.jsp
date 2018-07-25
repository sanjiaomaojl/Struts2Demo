<%--
  Created by IntelliJ IDEA.
  User: 张京龙
  Date: 2018/6/25
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        html,body{
            height: 100%;
        }
        .container{
            width: 100%;
            height: 100%;
        }
        .top{
            height:75%;
            background-image: url("../images/index_bg.jpg");
            background-size: cover;
            background-position: center;
        }
        .bottom{
            height: 25%;
            background-color: white;
        }
        .middle{
            width: 70%;
            height: 100%;
            margin: 0 auto;
            position: relative;
        }
        .left{
            width: 250px;
            height: 150px;
            position: absolute;
            left: 200px;
            top: 100px;
            text-align: center;
            color: white;
        }
        .left h1{
            font-size: 50px;
            font-family: "KaiTi";
        }
        .left h3{
            font-size: 30px;
            font-family: "KaiTi";
            padding-top: 10px;
        }
        .right{
            width: 300px;
            height: 350px;
            right: 100px;
            top: 100px;
            position: absolute;
        }
        .table{
            line-height: 35px;
        }
        .table td span{
            font-size: 25px;
            font-weight: bold;
        }
        .table input[type = text],.table input[type = password]{
            width: 200px;
            height: 25px;
            border-radius: 5px;
            border-width: 0px;
        }
        .table input[type = button]{
            width: 200px;
            height: 30px;
            border-radius: 5px;
            border-width: 0px;
            background-color: black;
            color: orange;
            font-weight: bold;
        }
        .bottom_left{
            float: left;
            margin-left: 250px;
            margin-top: 80px;
            color: black;
            text-align: center;
        }
        .bottom_right{
            float: right;
            margin-top: 80px;
            color: black;
            text-align: center;
        }
        .bottom_ma{
            padding-left: 15px;
            float: right;
            margin-right: 150px;
            margin-top: 50px;
        }
    </style>
    <script type="text/javascript" src="../easyui/jquery.min.js"></script>
    <script>
        function checkInfo() {
            //获取当前输入框的文本
            var userName = $("#userName").val();
            var pwd = $("#pwd").val();
            if (userName.length>0 && pwd.length>0){
                document.forms[0].submit();
            } else {
                alert("账号密码不能为空！");
            }
        }
        $(function () {
            $("body").keydown(function (event) {
                var code = event.keyCode;
                if(code == 13){
                    $("#loginHome").click();
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="top">
        <div class="middle">
            <div class="left"><h1>三脚猫</h1><h3>全球最厉害的大佬</h3></div>
            <div class="right">
                <form action="loginAction" method="post">
                    <table class="table">
                        <tr>
                            <td><span>用户登录 </span>user login</td>
                        </tr>
                        <tr>
                            <td><input type="text" placeholder="请输入用户名" id="userName" name="userName"></td>
                        </tr>
                        <tr>
                            <td><input type="password" placeholder="请输入密码" id="pwd" name="pwd"></td>
                        </tr>
                        <tr height="30">

                        </tr>
                        <tr>
                            <td><input type="button" value="登录" onclick="checkInfo()" id="loginHome"></td>
                        </tr>
                        <tr>
                            <td><input type="button" value="注册"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
    <div class="bottom">
        <div class="bottom_left">[鲁ICP备19961111号]Copyright©济南大学泉城学院 张京龙制作  QQ:1026845550</div>
        <div class="bottom_ma"><img src="../images/index_ma.png" height="73" width="73"/></div>
        <div class="bottom_right">微信扫码关注二维码</div>
    </div>
</div>
</body>
</html>
