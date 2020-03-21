<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>企业文档管理系统-首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layui.css">
</head>
<style type="text/css">
    a{
        cursor:pointer;
    }
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo" ><a href="" class="layui-logo">企业文档管理系统</a></div>
        <ul class="layui-nav layui-layout-right" style="margin-right: 20px">
            <li class="layui-nav-item">
                <a>
                    ${sessionScope.USER_SESSION.name}
                </<a>
                <dl class="layui-nav-child">
                    <dd><a class="child-view" data-src="${pageContext.request.contextPath}/user/toUserInfo">个人中心</a></dd>

                    <dd><a href="${pageContext.request.contextPath}/user/logout">退出登陆</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item"><a class="child-view" data-src="${pageContext.request.contextPath}/file/toMyIndex">首页</a></li>
                <li class="layui-nav-item"><a class="child-view" data-src="${pageContext.request.contextPath}/file/toAllFile">全部文档</a></li>

<%--                layui-nav-itemed--%>
                <li class="layui-nav-item">
                    <a>文档分类</a>
                    <dl class="layui-nav-child">
                        <div id="left">
<%--                           文档类型遍历--%>
                            <c:forEach var="type" items="${requestScope.get('list')}">
                                <dd>
                                    <a class='child-view' data-src='${pageContext.request.contextPath}/file/toTypefile/${type.getTypeid()}'>${type.getFiletype()}</a>
                                </dd>
                            </c:forEach>
                        </div>
                    </dl>
                </li>
                <li class="layui-nav-item"><a class="child-view" data-src="${pageContext.request.contextPath}/file/toMyFile">我的上传</a></li>
                <li class="layui-nav-item"><a class="child-view" data-src="${pageContext.request.contextPath}/file/toAddFile">文档上传</a></li>


                <li class="layui-nav-item" id="admin">
                    <a>管理员权限</a>
                    <dl class="layui-nav-child">
<%--                        未实现--%>
                        <dd><a class="child-view" data-src="${pageContext.request.contextPath}/file/toAllFiletype">文档分类管理</a></dd>
                        <dd><a class="child-view" data-src="${pageContext.request.contextPath}/user/toAllUser">用户管理</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>




    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="main_right">
            <iframe frameborder="0" scrolling="yes" style="width:95% ;margin-left: 20px;" src="${pageContext.request.contextPath}/file/toMyIndex" id="iframe">
            </iframe>
        </div>
    </div>




    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 作者：宇宙  ||  邮箱：forgetdyz@qq.com || WeChat：forgetdyz   ||   开开心心每一天
    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
<script defer=true>

    //JavaScript代码区域
    layui.use(['element','jquery'], function(){
        var element = layui.element
            ,$ =layui.jquery;

        //一些事件监听
        element.on('tab(demo)', function(data){
            console.log(data);
        });




        $(function(){
            //获取src值
            $(".child-view").on("click",function(){
                var address =$(this).attr("data-src");
                $("iframe").attr("src",address);
                $("#body-title").html("");
            });

            //以下代码是根据窗口高度在设置iframe的高度
            var frame = $("#iframe");
            var frameheight = $(window).height();
            frame.css("height","85%");

            let admin = ${sessionScope.USER_SESSION.isadmin};
            if (admin!=1){
                $("#admin").hide();
            }
        });
    });

</script>
</body>
</html>