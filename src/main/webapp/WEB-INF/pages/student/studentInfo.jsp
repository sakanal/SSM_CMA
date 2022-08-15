<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/4/11
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/static/css/student/studentInfo.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="modal-header" style="border-bottom:none;padding:0.5rem 1rem">
            <h4 class="modal-title">${studentInfo.stuName}的详细信息</h4>
            <button type="button" class="close">
<%--                <span aria-hidden="true">/span>--%>
                <a href="${pageContext.request.contextPath}/student/studentList/${sessionScope.identity}" style="text-decoration: none">&times;</a>
            </button>
        </div>
        <div class="card-columns" style="width: 1250px">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">个人详细信息</h5>
                    <table class="table">
                        <tr>
                            <td>学号：</td>
                            <td>${studentInfo.stuId}</td>
                        </tr>
                        <tr>
                            <td>姓名：</td>
                            <td>${studentInfo.stuName}</td>
                        </tr>
                        <tr>
                            <td>性别：</td>
                            <td>${studentInfo.stuGender}</td>
                        </tr>
                        <tr>
                            <td>电话：</td>
                            <td>${studentInfo.stuPhone}</td>
                        </tr>
                        <tr>
                            <td>生日：</td>
                            <td>${studentInfo.stuBirthday}</td>
                        </tr>
                        <tr>
                            <td>地址：</td>
                            <td>${studentInfo.stuAddress}</td>
                        </tr>
                        <tr>
                            <td>邮箱：</td>
                            <td>${studentInfo.stuEmail}</td>
                        </tr>
                        <tr>
                            <td>班级：</td>
                            <td>${studentInfo.stuClass}</td>
                        </tr>
                        <tr>
                            <td>学院：</td>
                            <td>${studentInfo.stuCollege}</td>
                        </tr>
                        <tr>
                            <td>专业：</td>
                            <td>${studentInfo.stuMajor}</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">课堂表现</h5>
                    <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">签到情况</h5>
                    <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">作业完成情况</h5>
                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>
                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                </div>
            </div>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/popper.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/student/studentInfo.js"></script>
        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
        </script>
    </body>
</html>
