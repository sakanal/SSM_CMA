<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/3/26
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>课堂管理助手</title>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
    </head>
    <body>
        <!--页眉-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-2">
            <a class="navbar-brand" href="#">课堂管理助手</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse " id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${sessionScope.userInfo.name}
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="min-width:8rem;">
                            <a class="dropdown-item" href="#">个人中心</a>
                            <a id="updatePassword" class="dropdown-item" href="#">修改密码</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/system/logout">退出</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">帮助</a>
                    </li>
                </ul>
            </div>
        </nav>
<%--        <div class="border mb-2" style="height: 40px;line-height: 50px; font-family: Verdana, 微软雅黑,黑体,'Lucida Console',serif">--%>

<%--        </div>--%>

        <!--导航菜单-->
        <div class="d-flex">
            <div id="navMenu" class="card mx-4" style="width: 12rem;height: 520px">
                <div class="card-header">[ 导航菜单 ]</div>
                <div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item" v-if="${sessionScope.identity}!=3">
                            <a href="https://www.runoob.com" target="iframe">教学内容</a>
                        </li>
                        <li class="list-group-item" v-if="${sessionScope.identity}!=1">
                            <a href="${pageContext.request.contextPath}/student/studentList/${sessionScope.identity}" target="iframe">学生管理</a>
                        </li>
                        <li class="list-group-item" v-if="${sessionScope.identity}==3">
                            <a href="${pageContext.request.contextPath}/teacher/teacherList/${sessionScope.identity}" target="iframe">教师管理</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/success" target="iframe">success</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/lose" target="iframe">lose</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="iframe_div" style="height: 722px;width: 1250px;">
                <iframe id="iframe" name="iframe" src="${pageContext.request.contextPath}/success" scrolling="auto" frameborder="0" width="100%" height="100%" title="iframe"></iframe>
            </div>
        </div>


        <div class="modal fade" id="updatePasswordModal" tabindex="-1" role="dialog" aria-labelledby="updatePaswordModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updatePasswordModalTitle">修改密码</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <input type="hidden" name="_method" value="put">
                            <input type="hidden" name="id" value="${sessionScope.userInfo.id}">
                            <input type="hidden" name="identity" value="${sessionScope.identity}">
                            <div class="form-group row">
                                <label for="password" class="col-2 col-form-label">原密码</label>
                                <input type="password" class="form-control col-9" id="password" v-model="password" placeholder="请输入原密码" v-bind:class="{'':passwordFlag==0,'is-valid':passwordFlag==1,'is-invalid':passwordFlag==2}" onblur="checkPassword()">
                                <p id="passwordUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                                <p id="passwordCheckUpdateToolTip" data-toggle="tooltip" data-placement="right" title="密码输入错误"></p>
                            </div>
                            <div class="form-group row">
                                <label for="newPassword" class="col-2 col-form-label">新密码</label>
                                <input type="password" class="form-control col-9" name="password" id="newPassword" v-model="newPassword" placeholder="请输入新密码" v-bind:class="{'':newPasswordFlag==0,'is-valid':newPasswordFlag==1,'is-invalid':newPasswordFlag==2}">
                                <p id="newPasswordUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label for="checkNewPassword" class="col-2 col-form-label">确认密码</label>
                                <input type="password" class="form-control col-9" id="checkNewPassword" v-model="checkNewPassword" placeholder="请确认新密码" v-bind:class="{'':checkNewPasswordFlag==0,'is-valid':checkNewPasswordFlag==1,'is-invalid':checkNewPasswordFlag==2}">
                                <p id="checkNewPasswordUpdateToolTip" data-toggle="tooltip" data-placement="right" title="与新密码保持一致"></p>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="passwordUpdateSaveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/popper.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/system/main.js"></script>
        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
        </script>
    </body>
</html>
