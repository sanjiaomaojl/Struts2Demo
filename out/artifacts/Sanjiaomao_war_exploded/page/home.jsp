<%--
  Created by IntelliJ IDEA.
  User: 张京龙
  Date: 2018/6/26
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主界面</title>
    <link rel="stylesheet" type="text/css" href="../easyui/themes/black/easyui.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../easyui/demo.css">
    <script type="text/javascript" src="../easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
    <style>

        *{
            margin: 0;
            padding: 0;
        }
        html,body{
            height: 100%;
            width: 100%;
        }
        .left{
            width: 200px;
            height: 100%;
            float: left;
            background-color:#1e292d;
        }
        .info{
            width: 100%;
            height: 180px;
            text-align: center;
        }
        .info span{
            width: 100%;
            height: auto;
            display: block;
            margin-top: 20px;
            color: #fda400;
            font-size: 16px;
        }
        .info img{
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            width: 75px;
            height: 75px;
            margin-top: 15px;
        }
        .userName{
            color: white;
            font-size: 14px;
        }

        .right{
            width:calc(100% - 200px);
            height: 100%;
            float: right;
            background-color: beige;
        }
        .top{
            width: 100%;
            height: 100px;
        }
        .nav{
            width: 100%;
            height: 50px;
            background-color:#334048;
        }
        .nav ul
        {
            list-style-type:none;
            margin-left: 20px;
            padding-top: 12px;
        }
        .nav li
        {
            display:inline;
        }
        .nav a:link,a:visited
        {
            color:white;
            padding:15px;
            text-decoration:none;
        }
        .nav a:hover,a:active
        {
            background-color: #627179;
        }

        .bottom{
            width: 100%;
            height: 50px;
            background-color:#fda400
        }
        .main{
            width: 100%;
            height: calc(100% - 120px);
            background-color: #666666;
            background-image: url("../images/none-box.png");
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>
    <script>
        function addTables(title){
            //判断是否已经有选项卡了
            if($('#tt').tabs("exists",title)){
                $("#tt").tabs("select",title);
            }else {
                $('#tt').tabs('add',{
                    title:title,
                    content:"<iframe src='list.jsp' width='100%' height='100%' frameborder='0'></iframe>",
                    closable:true,
                });
            }
        }
    </script>
</head>
<body>
<div class="left">
    <div class="info">
        <span>客户关系管理平台</span>

        <img src="../images/photo.jpg" alt="用户头像">
        <div class="userName" id="userInfo">管理员：</div>
    </div>
</div>

<div class="right">
    <div class="top">
        <div class="nav">
            <ul>
                <li onclick="addTables('客户管理')"><a href="#">客户管理</a></li>
                <li onclick="addTables('拜访记录')"><a href="#">拜访记录</a></li>
                <li onclick="addTables('客户订单')"><a href="#">客户订单</a></li>
            </ul>
        </div>
        <div class="bottom"></div>
    </div>

    <div class="main">
        <div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
            <div title="Tab1" style="padding:20px;display:none;">
                tab1
            </div>
        </div>
    </div>
</div>
</body>
</html>
