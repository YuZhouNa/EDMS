<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>allfile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field layui-field-title">
    <legend>欢迎使用企业文档管理系统</legend>
</fieldset>
<div style="padding: 15px;">
    <h1 class="layui-field-title"></h1>
</div>

<div class="layui-carousel" id="test10">
    <div carousel-item="">
        <div><img src="${pageContext.request.contextPath}/statics/img/a1.jpg" style="width: auto;height: 100%"></div>
        <div><img src="${pageContext.request.contextPath}/statics/img/b1.jpg" style="width: auto;height: 100%"></div>
        <div><img src="${pageContext.request.contextPath}/statics/img/c1.jpg" style="width: auto;height: 100%"></div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script>
    layui.use(['carousel', 'form'], function() {
        var carousel = layui.carousel
            , form = layui.form;
        carousel.render({
            elem: '#test10'
            , width: '1000'
            , height: '80%'
            , interval: 5000
        });
    })

</script>
</body>
</html>
