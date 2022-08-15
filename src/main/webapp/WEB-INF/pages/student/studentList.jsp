<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/3/27
  Time: 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
    <head>
        <title>学生列表</title>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/static/css/student/studentList.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="container-fluid">
            <!--标题-->
            <div class="row">
                <div class="col-12">
                    <h2>学生信息列表</h2>
                </div>
            </div>
            <!--辅助(查询)功能-->
            <div class="row">
                <div class="col-1">
                    <button class="btn btn-primary btn-sm" style="height: 38px" id="studentAddModalBtn">
<%--                        <img src="${pageContext.request.contextPath}/static/images/plus-lg.svg">--%>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"></path>
                        </svg>
                        新增
                    </button>
<%--                    <button class="btn btn-danger btn-sm">删除</button>--%>
                </div>
                <div id="searchDiv" class="col-11">
                    <form id="searchForm" class="form" action="##" onsubmit="return false">
                        <div class="row">
                            <div class="col-2">
                                <input class="form-control" type="text" name="stuId" placeholder="学号" v-model="stuId">
                            </div>
                            <div class="col-2">
                                <input class="form-control" type="text" name="stuName" placeholder="姓名" v-model="stuName">
                            </div>
                            <div class="col-2">
                                <input class="form-control" type="text" name="stuClass" placeholder="班级" v-model="stuClass">
                            </div>
                            <div class="col-2">
                                <select class="custom-select" name="stuCollege" @change="searchMajorInfoByCollegeId($event)" v-model="stuCollege">
                                    <option selected value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                            <div class="col-2">
                                <select class="custom-select" name="stuMajor" v-model="stuMajor">
                                    <option selected value="">专业</option>
                                    <option v-for="major in majorInfo" :value="major.id">
                                        {{major.majorName}}
                                    </option>
                                </select>
                            </div>
                            <button class="btn btn-primary btn-sm"  @click="searchStudents()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                                </svg>
<%--                                <img src="${pageContext.request.contextPath}/static/images/search.svg">--%>
                                搜索
                            </button>
<%--                            <input class="btn btn-primary btn-sm" type="submit" value="搜索" style="width: 50px">--%>
                        </div>
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
                                    <button class="btn btn-primary btn-sm" :view-id="student.stuId" id="viewStudent">
                                        <svg class="bi bi-eye-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"></path>
                                            <path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"></path>
                                        </svg>
<%--                                        <img src="${pageContext.request.contextPath}/static/images/eye-fill.svg">--%>
                                        查看
                                    </button>
                                    <button class="btn btn-primary btn-sm studentUpdateModelBtn" :update-id="student.stuId">
<%--                                        <img src="${pageContext.request.contextPath}/static/images/brush-fill.svg">--%>
                                        <svg class="bi bi-brush" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M15.213 1.018a.572.572 0 0 1 .756.05.57.57 0 0 1 .057.746C15.085 3.082 12.044 7.107 9.6 9.55c-.71.71-1.42 1.243-1.952 1.596-.508.339-1.167.234-1.599-.197-.416-.416-.53-1.047-.212-1.543.346-.542.887-1.273 1.642-1.977 2.521-2.35 6.476-5.44 7.734-6.411z"></path>
                                            <path d="M7 12a2 2 0 0 1-2 2c-1 0-2 0-3.5-.5s.5-1 1-1.5 1.395-2 2.5-2a2 2 0 0 1 2 2z"></path>
                                        </svg>
                                        编辑
                                    </button>
                                    <button class="btn btn-danger btn-sm studentDeleteModelBtn" :delete-id="student.stuId">
                                        <svg class="bi bi-power" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M5.578 4.437a5 5 0 1 0 4.922.044l.5-.866a6 6 0 1 1-5.908-.053l.486.875z"></path>
                                            <path fill-rule="evenodd" d="M7.5 8V1h1v7h-1z"></path>
                                        </svg>
<%--                                        <img src="${pageContext.request.contextPath}/static/images/power.svg">--%>
                                        删除
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--分页信息-->
            <div id="pageInfo" class="row">
                <!--分页文字信息-->
                <div class="col-7">
                    当前第{{pageInfo.pageNum}}页，共{{pageInfo.pages}}页，总共{{pageInfo.total}}条数据
                </div>
                <!--分页条信息-->
                <div class="col-5" v-if="pageInfo.pages!=1 && pageInfo.pages!=0 ">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="" @click.prevent="pageChange(1)">首页</a></li>
                            <li v-if="!pageInfo.isFirstPage" class="page-item">
                                <a class="page-link" href="" aria-label="Previous" @click.prevent="pageChange(pageInfo.pageNum-1)">
                                    <span aria-hidden="true">&laquo;</span>
                                    <span class="sr-only">Previous</span>
                                </a>
                            </li>
                            <div v-for="pages in pageInfo.navigatepageNums">
                                <li class="page-item" v-bind:class="[pages==pageInfo.pageNum?'active':'']">
                                    <a class="page-link" href="" @click.prevent="pageChange(pages)" style="border-radius: 0rem">{{pages}}</a>
                                </li>
                            </div>
                            <li v-if="!pageInfo.isLastPage" class="page-item">
                                <a class="page-link" href="" aria-label="Next" @click.prevent="pageChange(pageInfo.nextPage)">
                                    <span aria-hidden="true">&raquo;</span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </li>
                            <li class="page-item"><a class="page-link" href="" @click.prevent="pageChange(pageInfo.pages)">末页</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <!-- 添加学生模态框 -->
        <div class="modal fade" id="studentAddModal" tabindex="-1" role="dialog" aria-labelledby="studentAddModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="studentAddModalTitle">添加学生</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group row">
                                <label for="stuAddId" class="col-2 col-form-label">学号<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9 " v-bind:class="{'':stuIdFlag=='0','is-valid':stuIdFlag=='1','is-invalid':stuIdFlag=='2'}" name="stuId" id="stuAddId" v-model="stuId" onblur="checkStudentId()" placeholder="请输入学号">
                                <p id="stuIdCheckAddToolTip" data-toggle="tooltip" data-placement="right" title="学号重复"></p>
                                <p id="stuIdAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-16位数字"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddClass" class="col-2 col-form-label">班级</label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuClassFlag=='0','is-valid':stuClassFlag=='1','is-invalid':stuClassFlag=='2'}"  name="stuClass" id="stuAddClass" v-model="stuClass" placeholder="请输入班级">
                                <p id="stuClassAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入1-8位数字"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddName" class="col-2 col-form-label">姓名<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuNameFlag=='0','is-valid':stuNameFlag=='1','is-invalid':stuNameFlag=='2'}" name="stuName" id="stuAddName" v-model="stuName" placeholder="请输入姓名">
                                <p id="stuNameAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入2-5位中文或者6-16位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddPassword" class="col-2 col-form-label">密码<span style="color: red">*</span></label>
                                <input type="password" class="form-control col-9" v-bind:class="{'':stuPasswordFlag=='0','is-valid':stuPasswordFlag=='1','is-invalid':stuPasswordFlag=='2'}"  name="stuPassword" id="stuAddPassword" v-model="stuPassword" placeholder="请输入密码">
                                <p id="stuPasswordAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-2 pt-0">性别</label>
                                <div class="form-check form-check-inline col-4">
                                    <input class="form-check-input" type="radio" name="stuGender" id="stuAddGenderM" value="男" checked>
                                    <label class="form-check-label" for="stuAddGenderM">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stuGender" id="stuAddGenderW" value="女">
                                    <label class="form-check-label" for="stuAddGenderW">女</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddPhone" class="col-2 col-form-label">电话</label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuPhoneFlag=='0','is-valid':stuPhoneFlag=='1','is-invalid':stuPhoneFlag=='2'}"  name="stuPhone" id="stuAddPhone" v-model="stuPhone" placeholder="请输入电话">
                                <p id="stuPhoneAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddCollege" class="col-2 col-form-label">学院</label>
                                <select class="custom-select col-9" name="stuCollege" id="stuAddCollege" v-model="stuCollege" @change="searchMajorInfoByCollegeId($event)" v-model="stuCollege">
                                    <option selected value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                            <div class="form-group row">
                                <label for="stuAddMajor" class="col-2 col-form-label">专业</label>
                                <select class="custom-select col-9" name="stuMajor" id="stuAddMajor" v-model="stuMajor">
                                    <option selected value="">专业</option>
                                    <option v-for="major in majorInfo" :value="major.id">
                                        {{major.majorName}}
                                    </option>
                                </select>
                            </div>
<%--                            <button type="submit" class="btn btn-primary btn-lg btn-block">注册</button>--%>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="studentAddSaveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <!--学生修改模态框-->
        <div class="modal fade" id="studentUpdateModal" tabindex="-1" role="dialog" aria-labelledby="studentUpdateModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="studentUpdateModalTitle">修改学生信息</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <input type="hidden" name="_method" value="put">
                            <div class="form-group row">
                                <label for="stuUpdateId" class="col-2 col-form-label">学号</label>
                                <p type="text" readonly class="form-control-plaintext col-9"  name="stuId" id="stuUpdateId" v-text="stuId">
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdateClass" class="col-2 col-form-label">班级<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuClassFlag=='0','is-valid':stuClassFlag=='1','is-invalid':stuClassFlag=='2'}"  name="stuClass" id="stuUpdateClass" v-model="stuClass" placeholder="请输入班级">
                                <p id="stuClassUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入1-8位数字"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdateName" class="col-2 col-form-label">姓名<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuNameFlag=='0','is-valid':stuNameFlag=='1','is-invalid':stuNameFlag=='2'}" name="stuName" id="stuUpdateName" v-model="stuName" placeholder="请输入姓名">
                                <p id="stuNameUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入2-5位中文或者6-16位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdatePassword" class="col-2 col-form-label">密码<span style="color: red">*</span></label>
                                <input type="password" class="form-control col-9" v-bind:class="{'':stuPasswordFlag=='0','is-valid':stuPasswordFlag=='1','is-invalid':stuPasswordFlag=='2'}"  name="stuPassword" id="stuUpdatePassword" v-model="stuPassword" placeholder="请输入密码">
                                <p id="stuPasswordUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-2 pt-0">性别</label>
                                <div class="form-check form-check-inline col-4">
                                    <input class="form-check-input" type="radio" name="stuGender" id="stuUpdateGenderM" value="男">
                                    <label class="form-check-label" for="stuUpdateGenderM">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stuGender" id="stuUpdateGenderW" value="女">
                                    <label class="form-check-label" for="stuUpdateGenderW">女</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdatePhone" class="col-2 col-form-label">电话<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':stuPhoneFlag=='0','is-valid':stuPhoneFlag=='1','is-invalid':stuPhoneFlag=='2'}"  name="stuPhone" id="stuUpdatePhone" v-model="stuPhone" placeholder="请输入电话">
                                <p id="stuPhoneUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdateCollege" class="col-2 col-form-label">学院</label>
                                <select class="custom-select col-9" name="stuCollege" id="stuUpdateCollege"  @change="searchMajorInfoByCollegeId($event)" v-model="stuCollege">
                                    <option value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                            <div class="form-group row">
                                <label for="stuUpdateMajor" class="col-2 col-form-label">专业</label>
                                <select class="custom-select col-9" name="stuMajor" id="stuUpdateMajor" v-model="stuMajor">
                                    <option value="">专业</option>
                                    <option v-for="major in majorInfo" :value="major.id">
                                        {{major.majorName}}
                                    </option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="StudentUpdateSaveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <!--操作成功模态框-->
        <div class="modal fade" id="studentResultModal" tabindex="-1" role="dialog" aria-labelledby="studentResultModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="studentResultModalTitle">结果</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        操作成功！
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">确认</button>
                    </div>
                </div>
            </div>
        </div>
        <!--学生删除模态框-->
        <div class="modal fade" id="studentDeleteModal" tabindex="-1" role="dialog" aria-labelledby="studentDeleteModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="studentDeleteModalTitle">删除确认</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        是否删除学号为:{{stuId}}的学生
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-danger" id="studentDeleteSaveBtn">删除</button>
                        <form><input type="hidden" name="_method" value="delete"></form>
                    </div>
                </div>
            </div>
        </div>
        <!--学生查看表单-->
        <form id="viewForm" action="${pageContext.request.contextPath}/student/student/" method="get"></form>

        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/popper.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/student/studentList.js"></script>
        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
        </script>
    </body>
</html>
