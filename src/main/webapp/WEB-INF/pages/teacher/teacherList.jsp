<%@ taglib prefix="v-bind" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sakanal
  Date: 2022/4/2
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>教师信息列表</title>
        <link href="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/static/css/teacher/teacherList.css" rel="stylesheet"/>
    </head>
    <body>

        <div class="container-fluid">
            <!--标题-->
            <div class="row">
                <div class="col-12">
                    <h2>教师信息列表</h2>
                </div>
            </div>
            <!--辅助(查询)功能-->
            <div class="row">
                <div class="col-1">
                    <button class="btn btn-primary btn-sm" style="height: 38px" id="teacherAddModalBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"/>
                        </svg>
                        新增
                    </button>
                </div>
                <!--搜索-->
                <div id="searchDiv" class="col-11">
                    <form id="searchForm" class="form" action="#" onsubmit="return false">
                        <div class="row">
                            <div class="col-2">
                                <input class="form-control" type="text" name="tchId" placeholder="教师号" v-model="tchId">
                            </div>
                            <div class="col-2">
                                <input class="form-control" type="text" name="tchName" placeholder="姓名" v-model="tchName">
                            </div>
                            <div class="col-2">
                                <select class="custom-select" name="tchCollege" v-model="tchCollege">
                                    <option selected value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                            <button class="btn btn-primary btn-sm"  @click.prevent="searchTeachers()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                </svg>
                                搜索
                            </button>
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
                            <th>教师号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>电话</th>
                            <th>生日</th>
                            <th>邮箱</th>
                            <th>学院</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="teacher in teachers">
                            <td v-text="teacher.tchId"></td>
                            <td v-text="teacher.tchName"></td>
                            <td v-text="teacher.tchGender"></td>
                            <td v-text="teacher.tchPhone"></td>
                            <td v-text="teacher.tchBirthday"></td>
                            <td v-text="teacher.tchEmail"></td>
                            <td v-text="teacher.tchCollege"></td>
                            <td>
                                <button class="btn btn-primary btn-sm teacherUpdateModelBtn" :update-id="teacher.tchId">
                                    <svg class="bi bi-brush" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M15.213 1.018a.572.572 0 0 1 .756.05.57.57 0 0 1 .057.746C15.085 3.082 12.044 7.107 9.6 9.55c-.71.71-1.42 1.243-1.952 1.596-.508.339-1.167.234-1.599-.197-.416-.416-.53-1.047-.212-1.543.346-.542.887-1.273 1.642-1.977 2.521-2.35 6.476-5.44 7.734-6.411z"/>
                                        <path d="M7 12a2 2 0 0 1-2 2c-1 0-2 0-3.5-.5s.5-1 1-1.5 1.395-2 2.5-2a2 2 0 0 1 2 2z"/>
                                    </svg>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm teacherDeleteModelBtn" :delete-id="teacher.tchId">
                                    <svg class="bi bi-power" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M5.578 4.437a5 5 0 1 0 4.922.044l.5-.866a6 6 0 1 1-5.908-.053l.486.875z"/>
                                        <path fill-rule="evenodd" d="M7.5 8V1h1v7h-1z"/>
                                    </svg>
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
                <div class="col-5" v-if="pageInfo.pages!=1">
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

        <!--教师添加模块-->
        <div class="modal fade" id="teacherAddModal" tabindex="-1" role="dialog" aria-labelledby="teacherAddModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="teacherAddModalTitle">添加教师</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="teacherAddForm" class="form-horizontal">
                            <div class="form-group row">
                                <label for="tchIdAdd" class="col-2 col-form-label">ID<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9 " v-bind:class="{'':tchIdFlag=='0','is-valid':tchIdFlag=='1','is-invalid':tchIdFlag=='2'}" name="tchId" id="tchIdAdd" onblur="checkTeacherId()" v-model="tchId" placeholder="请输入学号">
                                <p id="tchIdCheckAddToolTip" data-toggle="tooltip" data-placement="right" title="教师号重复"></p>
                                <p id="tchIdAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-16位数字"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchNameAdd" class="col-2 col-form-label">姓名<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchNameFlag=='0','is-valid':tchNameFlag=='1','is-invalid':tchNameFlag=='2'}" name="tchName" id="tchNameAdd" v-model="tchName" placeholder="请输入姓名">
                                <p id="tchNameAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入2-5位中文或者6-16位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchPasswordAdd" class="col-2 col-form-label">密码<span style="color: red">*</span></label>
                                <input type="password" class="form-control col-9" v-bind:class="{'':tchPasswordFlag=='0','is-valid':tchPasswordFlag=='1','is-invalid':tchPasswordFlag=='2'}"  name="tchPassword" id="tchPasswordAdd" v-model="tchPassword" placeholder="请输入密码">
                                <p id="tchPasswordAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-2 pt-0">性别</label>
                                <div class="form-check form-check-inline col-4">
                                    <input class="form-check-input" type="radio" name="tchGender" id="tchGenderMAdd" value="男" checked>
                                    <label class="form-check-label" for="tchGenderMAdd">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tchGender" id="tchGenderWAdd" value="女">
                                    <label class="form-check-label" for="tchGenderWAdd">女</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="tchPhoneAdd" class="col-2 col-form-label">电话</label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchPhoneFlag=='0','is-valid':tchPhoneFlag=='1','is-invalid':tchPhoneFlag=='2'}"  name="tchPhone" id="tchPhoneAdd" v-model="tchPhone" placeholder="请输入电话">
                                <p id="tchPhoneAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchEmailAdd" class="col-2 col-form-label">邮箱</label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchEmailFlag=='0','is-valid':tchEmailFlag=='1','is-invalid':tchEmailFlag=='2'}"  name="tchEmail" id="tchEmailAdd" v-model="tchEmail" placeholder="请输入电子邮箱">
                                <p id="tchEmailAddToolTip" data-toggle="tooltip" data-placement="right" title="请输入准确的邮箱格式"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchCollegeAdd" class="col-2 col-form-label">学院</label>
                                <select class="custom-select col-9" name="tchCollege" id="tchCollegeAdd" v-model="tchCollege" v-model="tchCollege">
                                    <option selected value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="teacherAddSaveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <!--教师修改模态框-->
        <!--
        <div class="modal fade" id="teacherUpdateModal" tabindex="-1" role="dialog" aria-labelledby="teacherUpdateModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="teacherUpdateModalTitle">修改教师信息</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <input type="hidden" name="_method" value="put">
                            <div class="form-group row">
                                <label for="tchUpdateId" class="col-2 col-form-label">学号</label>
                                <p type="text" readonly class="form-control-plaintext col-9"  name="tchId" id="tchUpdateId" v-text="tchId">
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdateName" class="col-2 col-form-label">姓名<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchNameFlag=='0','is-valid':tchNameFlag=='1','is-invalid':tchNameFlag=='2'}" name="tchName" id="tchUpdateName" v-model="tchName" placeholder="请输入姓名">
                                <p id="tchNameUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入2-5位中文或者6-16位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdatePassword" class="col-2 col-form-label">密码<span style="color: red">*</span></label>
                                <input type="password" class="form-control col-9" v-bind:class="{'':tchPasswordFlag=='0','is-valid':tchPasswordFlag=='1','is-invalid':tchPasswordFlag=='2'}"  name="tchPassword" id="tchUpdatePassword" v-model="tchPassword" placeholder="请输入密码">
                                <p id="tchPasswordUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入6-18位英文和数字的组合"></p>
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-2 pt-0">性别</label>
                                <div class="form-check form-check-inline col-4">
                                    <input class="form-check-input" type="radio" name="tchGender" id="tchUpdateGenderM" value="男">
                                    <label class="form-check-label" for="tchUpdateGenderM">男</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tchGender" id="tchUpdateGenderW" value="女">
                                    <label class="form-check-label" for="tchUpdateGenderW">女</label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdatePhone" class="col-2 col-form-label">电话<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchPhoneFlag=='0','is-valid':tchPhoneFlag=='1','is-invalid':tchPhoneFlag=='2'}"  name="tchPhone" id="tchUpdatePhone" v-model="tchPhone" placeholder="请输入电话">
                                <p id="tchPhoneUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdateBirthday" class="col-2 col-form-label">出生日期<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchBirthdayFlag=='0','is-valid':tchBirthdayFlag=='1','is-invalid':tchBirthdayFlag=='2'}"  name="tchBirthday" id="tchUpdateBirthday" v-model="tchBirthday">
                                <p id="tchBirthdayUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdateEmail" class="col-2 col-form-label">邮箱<span style="color: red">*</span></label>
                                <input type="text" class="form-control col-9" v-bind:class="{'':tchEmailFlag=='0','is-valid':tchEmailFlag=='1','is-invalid':tchEmailFlag=='2'}"  name="tchEmail" id="tchUpdateEmail" v-model="tchEmail" placeholder="请输入电话">
                                <p id="tchEmailUpdateToolTip" data-toggle="tooltip" data-placement="right" title="请输入11位电话号码"></p>
                            </div>
                            <div class="form-group row">
                                <label for="tchUpdateCollege" class="col-2 col-form-label">学院</label>
                                <select class="custom-select col-9" name="tchCollege" id="tchUpdateCollege"  @change="searchMajorInfoByCollegeId($event)" v-model="tchCollege">
                                    <option value="">学院</option>
                                    <option v-for="college in collegeInfo" :value="college.id">
                                        {{college.collegeName}}
                                    </option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="TeacherUpdateSaveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>
        -->

        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.6.0.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/axois.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/popper.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap-4.6.0/bootstrap.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/teacher/teacherList.js"></script>
        <script type="text/javascript">
            var contextPath="${pageContext.request.contextPath}"
            $(document).on("click",".teacherUpdateModelBtn",function (){
                alert("功能尚未完成")
            })
            $(document).on("click",".teacherDeleteModelBtn",function (){
                alert("功能尚未完成")
            })
        </script>
    </body>
</html>
