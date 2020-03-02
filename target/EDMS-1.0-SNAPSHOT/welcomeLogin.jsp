<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>企业文档管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field" style="width: 500px;margin: 150px auto">
    <legend>请登录</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form"  id="myform" lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="username" autocomplete="off" placeholder="请输入用户名" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码框</label>
                <div class="layui-input-block">
                    <input type="password" lay-verify="pass" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">是否管理员</label>
                <div class="layui-input-block">
                    <input type="radio" name="isadmin" value="0" title="普通用户" checked="">
                    <input type="radio" name="isadmin" value="1" title="管理员">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="login">登陆</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    <button type="button" class="layui-btn layui-btn-normal" lay-filter="register" id="register" onclick="window.location.href='${pageContext.request.contextPath}/user/toregister'">注册</button>
                </div>
            </div>
        </form>
    </div>
</fieldset>


<script src="./statics/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,$ =layui.jquery;




        //自定义验证规则
        form.verify({
            username:[
                /^[a-zA-Z0-9_-]{4,16}$/
                ,'账号必须在4到16位（字母，数字，下划线，减号）'
            ]

            ,pass: [
                /^[\S]{6,12}$/
                ,'密码必须6到12位，且不能出现空格'
            ]
            // ,content: function(value){
            //     layedit.sync(editIndex);
            // }
        });


        //监听提交
        form.on('submit(login)', function(data){
            $.post({
                url:"${pageContext.request.contextPath}/user/checkUser",
                data:{
                    "username":$('input[name="username"]').val(),
                    "password":$('input[name="password"]').val(),
                    // "isadmin":$('input[type=radio][name=isadmin]:checked').val()
                    "isadmin":$('input[name="isadmin"]:checked').val(),
                },
                success:function (data) {
                    if($("#password").val()==="" || $("#username").val()===""){
                        layer.msg("用户名或密码不能为空")
                    }else if(data==="success"){
                        window.location.href="${pageContext.request.contextPath}/user/toIndex"
                    }else if(data ==="passwordError"){
                        layer.msg("密码错误")
                    }else if(data ==="userNotFound"){
                        layer.msg("用户不存在")
                    }else {
                        layer.msg("未知错误")
                    }
                }
            })
            return false;
        });

    });

</script>
</body>
</html>
