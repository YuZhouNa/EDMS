<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改昵称</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field" style="width: 400px;margin: 20px auto">
    <legend>修改昵称</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form" lay-filter="example">

            <div class="layui-form-item">
                <label class="layui-form-label">新昵称</label>
                <div class="layui-input-block">
                    <input  name="name" lay-verify="name" autocomplete="off" placeholder="请输入新昵称"
                           class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="update">修改</button>
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
            name: function (value) {
                if (value === '${sessionScope.USER_SESSION.name}') {
                    return '请输入一个新的昵称！';
                }
            }
        })

        //监听提交
        form.on('submit(update)', function (data) {

            $.post({
                url: "${pageContext.request.contextPath}/user/updateName",
                data: {
                    <%--"oldnmae": '${sessionScope.USER_SESSION.name}',--%>
                    "username": '${sessionScope.USER_SESSION.username}',
                    "isadmin": '${sessionScope.USER_SESSION.isadmin}',
                    "name": $('input[name="name"]').val(),
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
                                window.parent.location.reload();
                            }
                        });

                    }else if(data ==="NAME_EXIST"){
                        layer.msg("昵称已存在！请重新输入");
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