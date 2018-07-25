<%--
  Created by IntelliJ IDEA.
  User: 张京龙
  Date: 2018/6/28
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../easyui/themes/black/easyui.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../easyui/demo.css">
    <script type="text/javascript" src="../easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
    <script>
        function showWindow() {
            $('#w').window('open');
        }
        function add_client() {
            /*var cName = $("#cName").val().trim();
            var cAddr = $("#cAddr").val().trim();
            var manager = $("#manager").val().trim();
            var postcode = $("#postcode").val().trim();
            var tel = $("#tel").val().trim();
            var star = $("#star").val().trim();
            $.post("addClient",{"cName":cName,"cAddr":cAddr,"manager":manager,"postcode":postcode,"tel":tel,"star":star},function () {
                
            });*/
            $('#from').form('submit', {
                    url:"addClient",
                onSubmit: function(){
                    // do some check
                    // return false to prevent submit;
                },
                success:function(data){
                   if(data == 1){
                       alert("添加成功！");
                       $('#w').window('close');
                       //刷新当前页面
                       window.location.reload();
                    }else {
                        alert("添加失败")
                   }

                }
            });
        }
        function deletes() {
            //获取所有被选中的行
            var array= $('#table').datagrid('getSelections');
            var str = "";
            for (var i = 0;i<array.length;i++){
                str+=array[i].cId+",";
            }
            $.get("deleteClient",{"str":str},function (data) {
                if(data == 1){
                    alert("删除成功！");
                    window.location.reload();
                }else {
                    alert("删除失败！");
                }
            });
        }
        //查询数据的function
        function searchData() {
            $('#from2').form('submit', {
                url:"listAction",
                onSubmit: function(){
                    // do some check
                    // return false to prevent submit;
                },
                success:function(data){
                    var obj = JSON.parse(data);
                    $('#table').datagrid('loadData', obj);
                }
            });
        }
    </script>
    <style>
        #table0{
            width: 100%;
            color: white;
            line-height: 25px
        }
    </style>
</head>
<body>
    <table id="table" class="easyui-datagrid" title="三脚猫" style="width:100%;height:100%"
           data-options="rownumbers:true,singleSelect:false,url:'listAction',method:'get',toolbar:'#tb',footer:'#ft'">
        <thead>
        <tr>
            <th data-options="field:'ck',checkbox:true"></th>
            <th data-options="field:'cId',width:80,align:'center'">客服编号</th>
            <th data-options="field:'cName',width:100,align:'center'">客户名称</th>
            <th data-options="field:'cAddr',width:280,align:'center'">所在地</th>
            <th data-options="field:'manager',width:80,align:'center'">客户经理</th>
            <th data-options="field:'postcode',width:100,align:'center'">邮编</th>
            <th data-options="field:'tel',width:150,align:'center'">电话</th>
            <th data-options="field:'star',width:80,align:'center'">客服星级</th>
        </tr>
        </thead>
    </table>
    <%--搜索框--%>
    <div id="tb" style="padding:2px 5px;">
        <form method="post" id="from2">
            用户姓名 <input class="easyui-textbox" style="width:110px" name="username">
            用户经理<input class="easyui-textbox" style="width:110px" name="manager">
            电话<input class="easyui-textbox" style="width:110px" name="tel">
            星级:
            <select class="easyui-combobox" panelHeight="auto" style="width:100px" name="star">
                <option value="0">--请选择--</option>
                <option value="1">☆</option>
                <option value="2">☆☆</option>
                <option value="3">☆☆☆</option>
                <option value="4">☆☆☆☆</option>
                <option value="5">☆☆☆☆☆</option>
            </select>
            <a onclick="searchData()" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        </form>
    </div>
        <%--工具条--%>
    <div id="ft" style="padding:2px 5px;">
        <a onclick="showWindow()" class="easyui-linkbutton" iconCls="icon-add" plain="true"></a>
        <a onclick="deletes()"  href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"></a>
    </div>
    <%--窗口--%>
    <div id="w" class="easyui-window" title="Modal Window" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:300px;height:320px;padding:10px;">
        <form id="from" method="post">
            <table id="table0">
                <tr>
                    <td>姓名</td>
                    <td><input type="text" id="cName" name="cName"> </td>
                </tr>
                <tr>
                    <td>地址</td>
                    <td>
                        <textarea style="height: 70px" id="cAddr" name="cAddr"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>客服经理</td>
                    <td><input type="text" id="manager" name="manager"> </td>
                </tr>
                <tr>
                    <td>邮编</td>
                    <td><input type="email" id="postcode" name="postcode"> </td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td><input type="text" id="tel" name="tel"> </td>
                </tr>
                <tr>
                    <td>星级</td>
                    <td><input type="number" id="star" name="star"> </td>
                </tr>
                <tr height="30"></tr>
                <tr>
                    <td colspan="2">
                        <input type="button" value="提交" style="width: 100%;background-color: #fda400;color: white;border-width: 0;height: 30px;border-radius:5px" onclick="add_client()">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
