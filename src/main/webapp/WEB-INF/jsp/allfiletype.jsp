<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>文档类型</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field layui-field-title">
    <legend>文档分类管理</legend>
</fieldset>
<table id="demo" lay-filter="test"></table>

<script type="text/html" id="toolbarTop">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addfiletype">添加文档类型</button>
    </div>
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <a class="layui-btn layui-btn-xs" lay-event="update" >修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete" id="delete">删除</a>
    </div>
</script>


<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script>
    layui.use(['table', 'layer', 'jquery','laytpl'], function () {
        var table = layui.table
            , layer = layui.layer
            , $ = layui.jquery
            , laytpl = layui.laytpl;

        //第一个实例
        table.render({
            elem: '#demo'
            , url: '${pageContext.request.contextPath}/file/queryAllFiletype'
            ,toolbar: '#toolbarTop'
            ,defaultToolbar:false
            ,width:500
            , cols: [[ //表头
                {field: 'typeid', title: 'ID',width:'20%'}
                , {field: 'filetype', title: '文档类型',width:'40%'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#toolbarDemo',width:'40%'}
            ]]
            , even: true
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            // var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'addfiletype':
                    layer.open({
                        type:2,
                        area:['500px','300px'],
                        offset: '100px',
                        title:'添加文档类型',
                        fixed:false,
                        resize:false,
                        moveOut:true,
                        shadeClose:true,
                        content:'${pageContext.request.contextPath}/file/toAddfiletype'
                    });



                    break;
            };
        });

        //监听行工具栏事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type:2,
                        area:['500px','300px'],
                        offset: '100px',
                        title:'修改文档类型',
                        fixed:false,
                        resize:false,
                        moveOut:true,
                        shadeClose:true,
                        content:'${pageContext.request.contextPath}/file/toUpdatefiletype/'+data.typeid
                    });


                    break;
                case 'delete':
                    layer.confirm('删除操作将清空该类型所有文件，是否确认删除？', function (index) {
                        //向服务端发送删除指令
                        $.post({
                            url:"${pageContext.request.contextPath}/file/deletefiletype",
                            data:{
                                "typeid":data.typeid,
                            },
                            success:function (res) {
                                if(res==="success"){
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存

                                    layer.alert("删除成功", {icon: 6}, function () {
                                        //修改成功后刷新父界面
                                        window.parent.location.reload();
                                    });

                                }else {
                                    layer.msg("删除失败");
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