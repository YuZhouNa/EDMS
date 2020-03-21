<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>用户管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field layui-field-title">
    <legend>用户管理</legend>
</fieldset>

<div style="margin-right: 200px;float:left;">
    <div class="layui-timeline-title" style="font-size: 20px;font-family:华文细黑;">普通用户列表：</div>
    <table id="usertable" lay-filter="test"></table>
</div>
<div style="float:left;">
    <div class="layui-timeline-title" style="font-size: 20px;font-family: 华文细黑;">管理员列表：</div>
    <table id="admintable" lay-filter="test"></table>
</div>




<script type="text/html" id="toolbarUser">
    <div class="layui-btn-container">

        <c:choose>
            <c:when test="${sessionScope.USER_SESSION.username == 'admin'}"><!-- 如果 -->
                <a class="layui-btn layui-btn-xs" lay-event="admin" >升为管理员</a>
            </c:when>
            <c:otherwise> <!-- 否则 -->
                <a class="layui-btn layui-btn-xs layui-btn-disabled">升为管理员</a>
            </c:otherwise>
        </c:choose>

        <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="delete" id="delete">删除用户</a>

    </div>
</script>



<script type="text/html" id="toolbarAdmin">
    <div class="layui-btn-container">
        <c:choose>
            <c:when test="${sessionScope.USER_SESSION.username == 'admin'}"><!-- 如果 -->
                <a class="layui-btn layui-btn-xs" lay-event="admin" >取消管理员</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs"  lay-event="delete" id="delete">删除用户</a>
            </c:when>
            <c:otherwise> <!-- 否则 -->
                <a class="layui-btn layui-btn-xs layui-btn-disabled" >取消管理员</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-disabled">删除用户</a>
            </c:otherwise>
        </c:choose>
    </div>
</script>


<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script  defer=true>
    layui.use(['table', 'layer', 'jquery','laytpl'], function () {
        var table = layui.table
            , layer = layui.layer
            , $ = layui.jquery
            , laytpl = layui.laytpl;

        //第一个实例
        table.render({
            elem: '#usertable'
            ,width:500
            ,url: '${pageContext.request.contextPath}/user/queryAllUser/0'
            ,cols: [[ //表头
                {field: 'username', title: '账 号',  sort: true}
                , {field: 'name', title: '昵 称', sort: true}
                , {field: 'isadmin',minWidth: 0,width:1,style:'display:none;'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#toolbarUser'}
            ]]
            ,done: function (res,index) {
                $("[data-field='isadmin']").css('display','none');
            }
            , page: true //开启分页
            , limit: 5  //一页显示10条数据
            , limits: [3, 5, 10]
            , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                var result;
                if (this.page.curr) {
                    result = res.data.slice(this.limit * (this.page.curr - 1), this.limit * this.page.curr);
                } else {
                    result = res.data.slice(0, this.limit);
                }
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": result //解析数据列表
                };
            }
            , even: true
        });


        //管理员表格
        table.render({
            elem: '#admintable'
            ,width:500
            ,url: '${pageContext.request.contextPath}/user/queryAllUser/1'
            ,cols: [[ //表头
                {field: 'username', title: '账 号',  sort: true}
                , {field: 'name', title: '昵 称', sort: true}
                , {field: 'isadmin',minWidth: 0,width:1,style:'display:none;'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#toolbarAdmin'}
            ]]
            ,done: function () {
                $("[data-field='isadmin']").css('display','none');
            }
            , page: true //开启分页
            , limit: 5  //一页显示10条数据
            , limits: [3, 5, 10]
            , parseData: function (res) { //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                var result;
                if (this.page.curr) {
                    result = res.data.slice(this.limit * (this.page.curr - 1), this.limit * this.page.curr);
                } else {
                    result = res.data.slice(0, this.limit);
                }
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": result //解析数据列表
                };
            }
            , even: true
        });


        //监听事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            switch (obj.event) {
                case 'admin':
                    $.post({
                        url:"${pageContext.request.contextPath}/user/updateUserIsadmin",
                        data:{
                            "username":data.username,
                            "isadmin":data.isadmin,
                        },
                        success:function (res) {
                            if(res==="upgrade"){
                                window.location.reload();
                                layer.alert("升为管理员成功！");
                            }else if(res==="downgrade"){
                                window.location.reload();
                                layer.alert("取消管理员成功！");
                            }else if(res==="sessionError"){
                                layer.alert("超级管理员无法取消！")
                            }else{
                                layer.alert("未知错误，删除失败！");
                            }

                        }
                    });

                    break;
                case 'delete':
                    layer.confirm('确认是否删除', function (index) {
                        //向服务端发送删除指令
                        $.post({
                            url:"${pageContext.request.contextPath}/user/deleteUser",
                            data:{
                                "username":data.username,
                            },
                            success:function (res) {
                                if(res==="success"){
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                    layer.alert("删除成功！");
                                }else if(res==="sessionError"){
                                    layer.alert("不能删除自己，删除失败！");
                                }else {
                                    layer.alert("未知错误，删除失败！");
                                }
                            }
                        })
                    });
                    break;
            };
        });

    });
</script>
</body>
</html>