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
    <legend>欢迎注册</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form"  lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">账 号</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="username" autocomplete="off" placeholder="请输入账号" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">昵 称</label>
                <div class="layui-input-block">
                    <input type="text" name="name" lay-verify="name" autocomplete="off" placeholder="请输入昵称" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">密 码</label>
                <div class="layui-input-block">
                    <input type="password" lay-verify="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">确认密码</label>
                <div class="layui-input-block">
                    <input type="password" lay-verify="pwd" name="pwd" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="register">注册</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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




        //自定义验证规则
        form.verify({
            username:[
                /^[a-zA-Z0-9_-]{4,16}$/
                ,'账号必须在4到16位（字母，数字，下划线，减号）'
            ]

            ,password: [
                /^[\S]{6,12}$/
                ,'密码必须6到12位，且不能出现空格'
            ]

            ,pwd: function (value) {
                if (value != $('input[name="password"]').val()) {
                    return '密码不一致，请再次确认';
                }
            }

        });


        //监听提交
        form.on('submit(register)', function(data){
            $.post({
                url:"${pageContext.request.contextPath}/user/register",
                data:{
                    "username":$('input[name="username"]').val(),
                    "name":$('input[name="name"]').val(),
                    "password":$('input[name="password"]').val(),
                },
                success:function (data) {
                    if(data==="SUCCESS"){

                        layer.open({
                            title: '信息'
                            ,content: '注册成功'
                            ,btn: ['确认']
                            ,icon:6
                            ,success: function(layero, index){
                                this.enterEsc = function(event){
                                    if(event.keyCode === 13){
                                        layer.close(index);
                                        return false; //阻止系统默认回车事件
                                    }
                                };
                                $(document).on('keydown', this.enterEsc);	//监听键盘事件，关闭层


                            }
                            ,end: function(){
                                window.location.href="${pageContext.request.contextPath}/user/logout";
                                $(document).off('keydown', this.enterEsc);	//解除键盘关闭事件
                                // 获得frame索引
                                var index = parent.layer.getFrameIndex(window.name);

                            }
                        });



                    }else if(data ==="USERNAME_EXIST"){
                        layer.msg("账号已存在");
                    }else if(data ==="NAME_EXIST"){
                        layer.msg("昵称已存在");
                    }else {
                        alert("未知错误");
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>
