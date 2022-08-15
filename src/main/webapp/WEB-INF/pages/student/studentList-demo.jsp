<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/3/27
  Time: 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <head>
        <title>学生列表</title>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/static/css/student/studentList.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="container">
            <!--标题-->
            <div class="row">
                <div class="col-12">
                    <h2>学生信息列表</h2>
                </div>
            </div>
            <!--辅助功能-->
            <div class="row">
                <div class="col-2">
                    <button class="btn btn-primary btn-sm">新增</button>
                    <button class="btn btn-danger btn-sm">删除</button>
                </div>
                <div class="col-10">
                    <form id="searchForm" class="">
                        学号:<input class="" type="text">
                        班级:<input class="" type="text">
                        学院:<input class="" type="text">
                        专业:<input class="" type="text">
                        <input type="submit" value="搜索" style="width: 50px">
                    </form>
                </div>
            </div>
            <!--结果列表-->
            <div id="messageTbody" class="row" style="min-height: 550px">
                <div class="col-12">
                    <table id="messageTable" class="table table-hover">
                        <thead class="thead-light">
                        <tr>
                            <th>学号</th>
                            <th>班级</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>电话</th>
                            <th>学院</th>
                            <th>专业</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="student in students">
                            <td v-text="student.stuId"></td>
                            <td v-text="student.stuClass"></td>
                            <td v-text="student.stuName"></td>
                            <td v-text="student.stuGender"></td>
                            <td v-text="student.stuPhone"></td>
                            <td v-text="student.stuCollege"></td>
                            <td v-text="student.stuMajor"></td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <svg class="bi bi-brush" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M15.213 1.018a.572.572 0 0 1 .756.05.57.57 0 0 1 .057.746C15.085 3.082 12.044 7.107 9.6 9.55c-.71.71-1.42 1.243-1.952 1.596-.508.339-1.167.234-1.599-.197-.416-.416-.53-1.047-.212-1.543.346-.542.887-1.273 1.642-1.977 2.521-2.35 6.476-5.44 7.734-6.411z"/>
                                        <path d="M7 12a2 2 0 0 1-2 2c-1 0-2 0-3.5-.5s.5-1 1-1.5 1.395-2 2.5-2a2 2 0 0 1 2 2z"/>
                                    </svg>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <svg class="bi bi-power" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M5.578 4.437a5 5 0 1 0 4.922.044l.5-.866a6 6 0 1 1-5.908-.053l.486.875z"/>
                                        <path fill-rule="evenodd" d="M7.5 8V1h1v7h-1z"/>
                                    </svg>
                                    删除
                                </button>
                            </td>
                        </tr>
                        <c:forEach items="${pageInfo.list}" var="student">
                            <tr>
                                <td>${student.stuId}</td>
                                <td>${student.stuClass}</td>
                                <td>${student.stuName}</td>
                                <td>${student.stuGender}</td>
                                <td>${student.stuPhone}</td>
                                <td>${student.stuCollege}</td>
                                <td>${student.stuMajor}</td>
                                <td>
                                    <button class="btn btn-primary btn-sm">
                                        <svg class="bi bi-brush" width="1em" height="1em" viewBox="0 0 16 16"
                                             fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M15.213 1.018a.572.572 0 0 1 .756.05.57.57 0 0 1 .057.746C15.085 3.082 12.044 7.107 9.6 9.55c-.71.71-1.42 1.243-1.952 1.596-.508.339-1.167.234-1.599-.197-.416-.416-.53-1.047-.212-1.543.346-.542.887-1.273 1.642-1.977 2.521-2.35 6.476-5.44 7.734-6.411z"/>
                                            <path d="M7 12a2 2 0 0 1-2 2c-1 0-2 0-3.5-.5s.5-1 1-1.5 1.395-2 2.5-2a2 2 0 0 1 2 2z"/>
                                        </svg>
                                        编辑
                                    </button>
                                    <button class="btn btn-danger btn-sm">
                                        <svg class="bi bi-power" width="1em" height="1em" viewBox="0 0 16 16"
                                             fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd"
                                                  d="M5.578 4.437a5 5 0 1 0 4.922.044l.5-.866a6 6 0 1 1-5.908-.053l.486.875z"/>
                                            <path fill-rule="evenodd" d="M7.5 8V1h1v7h-1z"/>
                                        </svg>
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--分页信息-->
            <div id="pageInfo" class="row">
                <!--分页文字信息-->
                <div class="col-8">
                    当前第${pageInfo.pageNum}页，共${pageInfo.pages}页，总共${pageInfo.total}条数据
                </div>
                <!--分页条信息-->
                <div class="col-4">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link disabled" aria-disabled="true"
                                                     href="${pageContext.request.contextPath}/student/studentList?pageNo=1">首页</a>
                            </li>
                            <c:if test="${pageInfo.pageNum!=1}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/student/studentList?pageNo=${pageInfo.pageNum-1}"
                                       aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                                <li class="page-item ${pageNum==pageInfo.pageNum?"active":""}"><a class="page-link"
                                                                                                  href="${pageContext.request.contextPath}/student/studentList?pageNo=${pageNum}">${pageNum}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${pageInfo.pageNum!=pageInfo.pages}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/student/studentList?pageNo=${pageInfo.nextPage}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </c:if>
                            <li class="page-item"><a class="page-link"
                                                     href="${pageContext.request.contextPath}/student/studentList?pageNo=${pageInfo.pages}">末页</a>
                            </li>

                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/student/studentList.js" defer></script>
    </body>
</html>
