<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/3/26
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
  <head>
      <title>登录</title>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
      <link href="${pageContext.request.contextPath}/static/css/system/login.css" rel="stylesheet"/>
  </head>
  <body >
      <div class="container-fluid row" style="height: 750px">
          <div class="col-4 offset-4  align-self-center">
              <div id="loginForm" class="">
                  <form id="dataTable" action="${pageContext.request.contextPath}/system/login" method="post">
                      <div>
                          <div class="form-group mb-3">
                              <label for="id" class="form-label">用户ID</label>
                              <input type="text" class="form-control" v-model="id" id="id" name="id" :placeholder="holder" value="${requestScope.id}" v-bind:class="{'':idFlag==0,'is-valid':idFlag==1,'is-invalid':idFlag==2}">
                          </div>
                          <div class="form-group mb-3">
                              <label for="password" class="form-label">密码</label>
                              <input type="password" class="form-control" v-model="password" id="password" name="password" placeholder="密码" value="${requestScope.password}" v-bind:class="{'':passwordFlag==0,'is-valid':passwordFlag==1,'is-invalid':passwordFlag==2}">
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
                                  <div class="form-check form-check-inline col-3">
                                      <input class="form-check-input" type="radio" name="identity" id="3" value="3" v-model="radioCheck">
                                      <label class="form-check-label" for="3">管理员</label>
                                  </div>
                              </div>
                          </div>
                          <div class="form-group row-fluid">
                              <input type="submit" id="login" value="登录" class="btn btn-primary col-4" @click.prevent="userLogin">
                              <input type="button" id="register" value="注册" class="btn btn-success col-4 offset-3" @click.prevent="userRegister">
<%--                              <a href="${pageContext.request.contextPath}/system/goRegister">去注册</a>--%>
                          </div>
                      </div>
                  </form>
                  <form action="${pageContext.request.contextPath}/system/goRegister" id="registerForm"></form>
              </div>
          </div>
      </div>

      <!-- 错误提示信息 -->
      <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalTitle" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="errorModalTitle">错误信息</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      ${errorMessage}
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-primary" data-dismiss="modal">确认</button>
                  </div>
              </div>
          </div>
      </div>
      <!-- 结果提示信息 -->
      <div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalTitle" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="resultModalTitle">提示信息</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      ${message}
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-primary" data-dismiss="modal">确认</button>
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
      <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/system/login.js"></script>
      <script type="text/javascript">
          var contextPath="${pageContext.request.contextPath}";
          var id="${requestScope.id}";
          var message="${requestScope.message}";
          var errorMessage="${requestScope.errorMessage}";
          function changeHolder(value){
              if (value==1)
                  loginFormVue.holder="学生ID"
              if(value==2)
                  loginFormVue.holder="教师ID"
              if (value==3)
                  loginFormVue.holder="管理员ID"
          }
          window.onload=function (){
              loginFormVue.holder="学生ID"
              if(errorMessage!=null && errorMessage!=""){
                  if (id!=null && id!=""){
                      loginFormVue.id=id;
                  }
                  $("#errorModal").modal('show')
              }
              if(message!=null && message!=""){
                  $("#resultModal").modal('show');
              }
          }
      </script>
  </body>
</html>
