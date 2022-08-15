<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/3/28
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>注册</title>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="container-fluid row" style="height: 750px">
            <div class="col-4 offset-4  align-self-center">
                <div id="registerForm" class="">
                    <form id="dataTable" action="${pageContext.request.contextPath}/system/register" method="post">
                        <div class="form-group mb-3">
                            <label for="id">ID</label>
                            <input type="text" class="form-control" id="id" name="id" v-model="id" v-bind:class="{'':idFlag=='0','is-valid':idFlag=='1','is-invalid':idFlag=='2'}" :placeholder="holder" data-toggle="tooltip" data-placement="right" title="请输入6-16位数字" onblur="checkId()">
                            <p id="idCheckToolTip" data-toggle="tooltip" data-placement="bottom" title="ID重复"></p>
                        </div>
                        <div class="form-group mb-3">
                            <label for="name">姓名</label>
                            <input type="text" class="form-control" id="name" name="name" v-model="name" v-bind:class="{'':nameFlag=='0','is-valid':nameFlag=='1','is-invalid':nameFlag=='2'}" placeholder="请输入姓名" data-toggle="tooltip" data-placement="right" title="请输入2-5位中文或者6-16位英文和数字的组合">
                        </div>
                        <div class="form-group mb-3">
                            <label for="password">密码</label>
                            <input type="password" class="form-control" id="password" name="password" v-model="password" v-bind:class="{'':passwordFlag=='0','is-valid':passwordFlag=='1','is-invalid':passwordFlag=='2'}" placeholder="请输入密码"  data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合">
                        </div>
                        <div class="form-group mb-3">
                            <label for="checkPassword">确认密码</label>
                            <input type="password" class="form-control" id="checkPassword" v-model="checkPassword" v-bind:class="{'':checkPasswordFlag=='0','is-valid':checkPasswordFlag=='1','is-invalid':checkPasswordFlag=='2'}"  placeholder="请再次输入密码"  data-toggle="tooltip" data-placement="right" title="请输入再次输入相同的密码">
                        </div>
                        <div class="form-group mb-3">
                            <div class="row offset-1">
                                <div class="form-check form-check-inline col-3">
                                    <input class="form-check-input" type="radio" name="identity" id="1" value="1" v-model="radioCheck">
                                    <label class="form-check-label" for="1">学生</label>
                                </div>
                                <div class="form-check form-check-inline col-3">
                                    <input class="form-check-input" type="radio" name="identity" id="2" value="2" v-model="radioCheck">
                                    <label class="form-check-label" for="2">教师</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg btn-block" @click.prevent="userRegister">注册</button>
                    </form>
                </div>
            </div>
        </div>





        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/popper.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/system/register.js"></script>
        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
            var message="${requestScope.message}"
            function changeHolder(value){
                if (value==1)
                    registerFormVue.holder="学生ID"
                if(value==2)
                    registerFormVue.holder="教师ID"
            }
            window.onload=function (){
                registerFormVue.holder="学生ID"
                // if(message!=null && message!=""){
                //     $("#resultModal").modal('show')
                // }
            }
        </script>
    </body>
</html>
