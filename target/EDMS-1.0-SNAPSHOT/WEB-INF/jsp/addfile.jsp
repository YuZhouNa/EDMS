<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>上传文档</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<body>

<fieldset class="layui-elem-field layui-field-title">
    <legend>上传文档</legend>
</fieldset>

<form class="layui-form layui-form-pane" action="">

    <div class="layui-form-item">
        <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文档</button>


    </div>

    <div class="layui-form-item" style="width: 25%">
        <label class="layui-form-label" style="">文件类型：</label>
        <div class="layui-input-block">
            <select name="orgType" lay-filter="Type_filter" id="otype" lay-verify="required">
                <option value="">--请选择--</option>
            </select>
        </div>
    </div>



    <div class="layui-form-item layui-form-text">

        <label class="layui-form-label">请输入文档描述</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" class="layui-textarea" id="filedescribe"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <button type="button" class="layui-btn" id="test9">提交</button>
    </div>

</form>

<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script defer=true>


    layui.use(['upload','form','jquery'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,$ = layui.jquery
            ,upload = layui.upload;


        //下拉框选项
        $.ajax({
            url: '${pageContext.request.contextPath}/file/queryAllFiletypeList',
            success: function (data) {
                for (var i = 0; i <data.length ; i++) {
                    // $("#otype").append("<option value=\""+data[i].filetype+"\">"+data[i].fletype+"</option>");
                    $('#otype').append(new Option(data[i].filetype, data[i].filetype));// 下拉菜单里添加元素
                }
                layui.form.render("select");
            }
        })



        //文件上传方法
        upload.render({
            elem: '#test8'
            ,url: '${pageContext.request.contextPath}/file/addFile' //上传接口
            ,auto: false    //选择文件后不自动上传
            ,accept:'file'    //上传时校验的文件类型
            ,size:10240         //限制上传文件大小
            ,data:{
                uploadtime:new Date(),
                filedescribe: function(){
                    return $('#filedescribe').val();
                },
                uploaduser: "${sessionScope.USER_SESSION.name}",
                uploadusername: "${sessionScope.USER_SESSION.username}",
                filetype:function(){
                    let type = $("#otype").val();
                    return type;
                }
            }

            ,bindAction: '#test9'

            //上传成功后回调
            ,done: function(res, index, upload){
                if(res.msg === "EXIST"){
                    layer.msg("文档已存在，上传失败！");
                }else if (res.msg === "OVERSIZE"){
                    layer.msg("文档大小不允许超出10M，上传失败！");
                }else if(res.msg === "TYPEERROR") {
                    layer.msg("请选择文件类型！");
                }else {
                    alert("上传成功");
                    window.location.href="${pageContext.request.contextPath}/file/toAllFile";
                }

            }

            //上传失败
            ,error: function(index, upload){
                //当上传失败时，你可以生成一个“重新上传”的按钮，点击该按钮时，执行 upload() 方法即可实现重新上传
                alert("上传失败");
            }
            //,multiple: false 只能上传一个文件
        });



    });
</script>
</body>
</html>