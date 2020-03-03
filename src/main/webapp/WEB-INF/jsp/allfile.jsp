<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>全部文档</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field layui-field-title">
    <legend>全部文档</legend>
</fieldset>
<table id="demo" lay-filter="test"></table>


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <a class="layui-btn layui-btn-xs" lay-event="download" >下载</a>
        <c:if test="${sessionScope.USER_SESSION.isadmin == 1}">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete" id="delete">删除</a>
        </c:if>

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
            , url: '${pageContext.request.contextPath}/file/queryAllFile'
            , cols: [[ //表头
                {field: 'fileid', title: 'ID',  sort: true}
                , {field: 'filename', title: '文档名称', sort: true}
                , {field: 'filetype', title: '文档类型', sort: true}
                , {field: 'filesize', title: '文档大小(kb)', sort: true}
                // , {field: 'filelocation', title: '保存路径', width: "10%" ,display:"none"}
                , {field: 'uploadtime', title: '上传时间', sort: true}
                , {field: 'uploaduser', title: '上传人', sort: true}
                , {field: 'downloadtimes', title: '下载次数', sort: true}
                , {field: 'filedescribe', title: '文档描述'}
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#toolbarDemo'}
            ]]
            , page: true //开启分页
            , limit: 10  //一页显示10条数据
            , limits: [3, 5, 7, 10]
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
                case 'download':

                    //跳转到下载链接
                    this.href = "${pageContext.request.contextPath}/file/download/" + encodeURIComponent(data.filename) + "/" + encodeURIComponent(data.uploaduser) + "/" + data.fileid;

                    break;
                case 'delete':

                    layer.confirm('确认是否删除', function (index) {
                        //向服务端发送删除指令
                        $.post({
                            url:"${pageContext.request.contextPath}/file/deletefile",
                            data:{
                                "fileid":data.fileid,
                            },
                            success:function (res) {
                                if(res==="success"){
                                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                                    layer.alert("删除成功");
                                }else {
                                    layer.alert("删除失败");
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