<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field" style="width: 400px;margin: 20px auto">
    <legend>修改密码</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form" lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">密 码</label>
                <div class="layui-input-block">
                    <input type="password" name="pwd1" lay-verify="pwd1" autocomplete="off" placeholder="请输入当前密码"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="pwd2" lay-verify="pwd2" autocomplete="off" placeholder="请输入新密码"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">确认密码</label>
                <div class="layui-input-block">
                    <input type="password" name="pwd3" lay-verify="pwd3" autocomplete="off" placeholder="请再次确认密码"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="update">修改</button>
                </div>
            </div>
        </form>
    </div>
</fieldset>

<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script>

    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery;

        form.verify({
            pwd1: function (value) {
                if (value.length === 0) {
                    return '请输入密码';
                }
            }


            ,pwd2 : function(value) { // value：表单的值、item：表单的DOM对象

                if (value === $('input[name="pwd1"]').val()) {
                    return '新密码与旧密码一致，请重新输入';
                }

                if (!new RegExp(/^[\S]{6,12}$/).test(value)) {
                    return '密码必须6到12位，且不能出现空格';
                }

            }

            ,pwd3: function (value) {
                if (value != $('input[name="pwd2"]').val()) {
                    return '密码不一致，请再次确认';
                }
            }
        })


        //监听提交
        form.on('submit(update)', function (data) {

            console.log("?");
            $.post({
                url: "${pageContext.request.contextPath}/user/updatePassword",
                data: {
                    "username": '${sessionScope.USER_SESSION.username}',
                    "password1": $('input[name="pwd1"]').val(),
                    "password2": $('input[name="pwd3"]').val(),
                    "isadmin": '${sessionScope.USER_SESSION.isadmin}'
                },
                success: function (data) {
                    if (data === "SUCCESS") {
                        layer.open({
                            title: '信息'
                            ,content: '修改成功'
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
                                $(document).off('keydown', this.enterEsc);	//解除键盘关闭事件
                                // 获得frame索引
                                var index = parent.layer.getFrameIndex(window.name);
                                //关闭当前frame
                                parent.layer.close(index);
                            }
                        });

                    }else if(data ==="passwordError"){
                        layer.msg("密码错误！请重新输入");
                        form.reset();
                    }else {
                        layer.msg("未知错误1");
                    }
                },
                error:function () {
                    console.log("未知错误2");
                }
            })
            //阻止默认提交
            return false;
        });
    });

</script>
</body>
</html>