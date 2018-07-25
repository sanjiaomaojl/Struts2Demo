<%--
  Created by IntelliJ IDEA.
  User: 张京龙
  Date: 2018/6/26
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>注册</title>
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
            background-color:#E6E6FA;
        }
        .meddle{
            width: 400px;
            height: 300px;
            background-color: rgba(0,0,0,0.5);
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -200px;
            margin-top: -200px;
            border-radius: 30px;
            color: white;
        }
        table{
            width: 100%;
            text-align: left;
            padding-top: 20px;
        }
        table input[type=text]{
            width: 200px;
            height: 25px;
            border-radius: 4px;
            border-width: 0;
        }
        table tr{
            height: 40px;
        }
        .savebtn{
            width: 80%;
            height: 30px;
            background-color:#FAFAD2;
            color: black;
            text-align: center;
            border-width: 0px;
            border-radius: 5px;
        }
        #tips0,#tips1,#tips2,#tips3,#tips4{
            color: red;
            width: 50px;
        }
    </style>
    <script src="../js/jquery.min.js"></script>
    <script>
        //全局变量用来标识
        var nameIsOk = false;
        var pwdIsOk = false;
        var codeIsOk = false;
        var code = "";
        var r_pwd = "";
        //检查用户是否存在
        function checkUser(input) {
            var name = input.value;
            $.post("checkUser",{userName:name},function (data) {
                if (data == 1){
                    $("#tips1").html("账号已经存在");
                    nameIsOk = false;
                }else {
                    $("#tips1").html("账号可以注册");
                    nameIsOk = true;
                }
            });
        }
        //判断密码位数
        function checkPwd1() {
            r_pwd = $("#regist_password").val().trim();
            if (r_pwd.length < 6) {
                $("#tips0").html("密码不能少于六位");
            }
         }
        //判断密码输入是否一致,且密码必须大于6位
        function checkPwd2() {
            var f_pwd = $("#final_password").val().trim();
            if (r_pwd.length >= 6 && r_pwd == f_pwd) {
                pwdIsOk = true;
            }else {
                $("#tips2").html("密码输入不一致");
                pwdIsOk = false;
            }
        }

        //验证码的发送和判断
        function sendCode(bt) {
            //定时器 1000ms一次
            var count = 10;
            bt.setAttribute("disabled","disabled");
            var time = setInterval(function () {
                bt.value = count+"s";
                count--;
                if(count < 0){
                    bt.removeAttribute("disabled");
                    clearInterval(time);
                    bt.value = "发送";
                }
            },1000);
            var tel = $("#tel").val().trim();
            code = codeRandom(6);
            alert(code);
            $.post("sendCode",{tel:tel,code:code},function (data) {
                if (data == 1){
                    $("#tips3").html("手机号已被注册");
                }else {
                    $("#tips4").html("验证码已发送");
                    if(count < 0){
                        $("#tips4").html("");
                    }
                }
            });


        }

        //生成随机验证码
        function codeRandom(num) {
            var code = "";
            for (var i = 0;i<num;i++){
                var n = parseInt(Math.random()*10000)%10;
                code += n;
            }
            return code;
        }
        //注册按钮的事件
        function regist() {
            var userName = $("#userName").val().trim();
            var pwd = $("#regist_password").val().trim();
            var tel = $("#tel").val().trim();
            var codeInput=$("#codeInput").val().trim();

            if(code == codeInput){
                codeIsOk = true;
            }else {
                $("#tips4").html("验证码有问题");
                codeIsOk = false;
            }

            if(nameIsOk == true && pwdIsOk == true && codeIsOk == true){
                $.post("addUser",{userName:userName,passWord:pwd,tel:tel},function(data){
                    if(data == 1){
                        alert("注册成功！");
                        window.location.href="login.jsp"
                    }else {
                        alert("注册失败");
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div class="meddle">
        <table>
            <tr>
                <td align="right">用户账号</td>
                <td>&nbsp;&nbsp;<input type="text" placeholder="请输入账号" onblur="checkUser(this)" id="userName"><span id="tips1"></span></td>
            </tr>
            <tr>
                <td align="right">用户密码</td>
                <td>&nbsp;&nbsp;<input type="password" placeholder="请输入密码" id="regist_password" onblur="checkPwd1()"><span id="tips0"></span></td>
            </tr>
            <tr>
                <td align="right">确认密码</td>
                <td>&nbsp;&nbsp;<input type="password" placeholder="请确认密码"  id="final_password" onblur="checkPwd2()"><span id="tips2"></span></td>
            </tr>
            <tr>
                <td align="right">手机号</td>
                <td>&nbsp;&nbsp;<input type="text" placeholder="请输入手机号" id="tel"><span id="tips3"></span></td>
            </tr>
            <tr>
                <td align="right">验证码</td>
                <td>&nbsp;&nbsp;<input type="text" style="width: 100px" placeholder="请输入验证码" id="codeInput">
                    <input type="button" value="发送" style="padding: 5px"  onclick="sendCode(this)"><span id="tips4"></span></td>
            </tr>
            <tr>
                <td align="center" colspan="2"><input type="button" value="注册" class="savebtn" onclick="regist()"></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
