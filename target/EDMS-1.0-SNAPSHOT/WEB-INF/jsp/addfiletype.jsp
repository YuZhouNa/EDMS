<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>updatefiletype</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field" style="width: 400px;margin: 20px auto">
    <legend>添加文档类别</legend>
    <div class="layui-field-box" style="margin: 10px auto">
        <form class="layui-form"  lay-filter="example">
            <div class="layui-form-item">
                <label class="layui-form-label">文档类型</label>
                <div class="layui-input-block">
                    <input type="text" name="filetype" lay-verify="filetype" autocomplete="off" placeholder="请输入新的文档类型" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="filetype">添加</button>
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

        form.verify({
            filetype: function (value) {
                if (value.length === 0) {
                    return '文档类型不能为空';
                }
            }
        })

        //监听提交
        form.on('submit(filetype)', function(data){
            let loading = layer.load(0,{shade:false});
            $.post({
                url:"${pageContext.request.contextPath}/file/addFiletype",
                data:{
                    "filetype":$('input[name="filetype"]').val(),
                },
                success:function (data) {
                    if(data === "SUCCESS"){
                        layer.close(loading);

                        layer.open({
                            title: '信息'
                            ,content: '添加成功'
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
                                //修改成功后刷新父界面
                                window.parent.location.reload();
                                window.parent.parent.location.reload();
                            }
                        });


                    }
                }
            })
            //阻止默认提交
            return false;
        });
    });

</script>
</body>
</html>