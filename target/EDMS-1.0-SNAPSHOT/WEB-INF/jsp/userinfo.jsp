<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>个人信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field" style="width: 330px;margin: 20px auto">
    <legend>个人中心</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form"  lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">账 号：</label>
                <label class="layui-form-label" style="text-align: center">${sessionScope.USER_SESSION.username}</label>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">昵 称：</label>
                <label class="layui-form-label" style="text-align: center">${sessionScope.USER_SESSION.name}</label>
            </div>

            <div class="layui-form-item">

                <div class="layui-input-block">
                    <button type="button" class="layui-btn layui-btn-normal" lay-filter="name" id="name" style="margin-left: -55px">修改昵称</button>
                    <button type="submit" lay-submit class="layui-btn"  lay-filter="updatepwd" id="updatepwd">修改密码</button>
                </div>
            </div>
        </form>
    </div>
</fieldset>

<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script>

    layui.use(['form', 'layer','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,$ =layui.jquery;

        form.on('submit(updatepwd)',function(data){
            layer.open({
                type:2,
                area:['500px','400px'],
                offset: '100px',
                title:'修改密码',
                fixed:false,
                resize:false,
                moveOut:true,
                shadeClose:true,
                content:'${pageContext.request.contextPath}/user/toUpdatePassword'
            });
            return false;
        });

        $(document).on('click','#name',function(){
            layer.open({
                type:2,
                area:['500px','400px'],
                offset: '100px',
                title:'修改昵称',
                fixed:false,
                resize:false,
                moveOut:true,
                shadeClose:true,
                content:'${pageContext.request.contextPath}/user/toUpdateName'
            });
        });
    });


</script>
</body>
</html>