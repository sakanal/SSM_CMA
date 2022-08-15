var viewFormAction
window.onload=function(){
    messageTbodyVue.getStudents();
    searchDivVue.searchCollegeInfo();
    searchDivVue.searchMajorInfo();

    var viewForm=document.getElementById("viewForm");
    viewFormAction=viewForm.action
    // console.log(viewForm.action)
    // console.log($(this).attr("view-id"));
    // viewForm.action=viewForm.action+$(this).attr("view-id")
    // console.log(viewForm.action)
}
//提示气泡初始化相关
$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})

//学生信息初始展示相关
var messageTbodyVue=new Vue({
    el:"#messageTbody",
    data:{
        students:[],
    },
    methods:{
        /**
         * 获取所有学生信息和对应的分页信息
         */
        getStudents:function (){
            axios({
                method:"get",
                url:contextPath+"/student/getStudents",
                params:{
                    pageNo:"1"
                }
            }).then(function (result){
                messageTbodyVue.students=result.data.list;
                pageInfoVue.pageInfo=result.data;
            })
        }
    }
})

//分页相关
var pageInfoVue=new Vue({
    el:"#pageInfo",
    data:{
        pageInfo:[],
        searchFlag:false,
        total:"",
        pageNum:"",
    },
    methods:{
        /**
         * 通过点击分页条上的按键，跳转到指定页面
         * @param pageNo    页面号
         */
        pageChange:function (pageNo){
            axios({
                method:"get",
                url:contextPath+"/student/searchStudents",
                params:{
                    pageNo:pageNo,
                    stuId:searchDivVue.stuId,
                    stuName:searchDivVue.stuName,
                    stuClass:searchDivVue.stuClass,
                    stuCollege:searchDivVue.stuCollege,
                    stuMajor:searchDivVue.stuMajor
                }
            }).then(function (result){
                messageTbodyVue.students=result.data.list;
                pageInfoVue.pageInfo=result.data;
            })
        }
    },
    watch:{
        pageInfo:function (){
            // console.log(pageInfoVue.pageInfo)
            pageInfoVue.total=pageInfoVue.pageInfo.total;
            pageInfoVue.pageNum=pageInfoVue.pageInfo.pageNum;
        }
    }
})

//查询学生相关
var searchDivVue=new Vue({
    el:"#searchDiv",
    // el:"#studentAddModalVue",
    data:{
        collegeInfo:[],
        majorInfo:[],
        stuId:"",
        stuName:"",
        stuClass:"",
        stuCollege:"",
        stuMajor:"",
        searchFlag:false
    },
    methods:{
        searchCollegeInfo:function (){
            axios({
                method:"get",
                url:contextPath+"/college/getColleges",
            }).then(function (result){
                // console.log(result.data);
                searchDivVue.collegeInfo=result.data;
                studentAddModalVue.collegeInfo=result.data;
                studentUpdateModalVue.collegeInfo=result.data;
                // console.log(searchDivVue.collegeInfo[0].collegeName)
            })
        },
        searchMajorInfo:function (){
            axios({
                method:"get",
                url:contextPath+"/major/getMajors",
            }).then(function (result){
                // console.log(result);
                searchDivVue.majorInfo=result.data;
                // studentAddModalVue.majorInfo=result.data;
                // studentUpdateModalVue.majorInfo=result.data;
            })
        },
        searchMajorInfoByCollegeId:function (event){
            var collegeId=event.target.value;
            axios({
                method:"get",
                url:contextPath+"/major/getMajorsByCollegeId",
                params:{
                    collegeId:collegeId
                }
            }).then(function (result){
                // console.log(result);
                if (result.data!=""){
                    searchDivVue.majorInfo=result.data;
                    searchDivVue.stuMajor="";
                }
            })
        },
        searchStudents:function (event){
          axios({
              method:"get",
              url:contextPath+"/student/searchStudents",
              params:{
                  stuId:searchDivVue.stuId,
                  stuName:searchDivVue.stuName,
                  stuClass:searchDivVue.stuClass,
                  stuCollege:searchDivVue.stuCollege,
                  stuMajor:searchDivVue.stuMajor
              }
          }).then(function (result){
              // console.log(result)
              messageTbodyVue.students=result.data.list;
              pageInfoVue.pageInfo=result.data;
              pageInfoVue.searchFlag=true;
          })

        }
    },
    watch:{
        stuCollege:function (){
            // alert(searchDivVue.stuCollege)
            if (searchDivVue.stuCollege==""){
                searchDivVue.searchMajorInfo();
            }
        }
    }
})

//学生添加模态框相关
var studentAddModalVue=new Vue({
    el:"#studentAddModal",
    data:{
        collegeInfo:[],
        majorInfo:[],
        stuId:"",
            stuIdFlag:"0",
            stuIdCheckFlag:"0",
        stuClass:"",
            stuClassFlag:"0",
        stuName:"",
            stuNameFlag:"0",
        stuPassword:"",
            stuPasswordFlag:"0",
        stuPhone:"",
            stuPhoneFlag:"0",
        stuCollege:"",
        stuMajor:"",
        flagResult:false,
        checkResult:false,
    },
    methods:{
        searchMajorInfo:function (){
            axios({
                method:"get",
                url:contextPath+"/major/getMajors",
            }).then(function (result){
                // console.log(result);
                studentAddModalVue.majorInfo=result.data;
            })
        },
        searchMajorInfoByCollegeId:function (event){
            var collegeId=event.target.value;
            axios({
                method:"get",
                url:contextPath+"/major/getMajorsByCollegeId",
                params:{
                    collegeId:collegeId
                }
            }).then(function (result){
                // console.log(result);
                if (result.data!=""){
                    studentAddModalVue.majorInfo=result.data;
                }else{
                    studentAddModalVue.searchMajorInfo();
                    studentAddModalVue.stuCollege="";
                }
                studentAddModalVue.stuMajor="";
            })
        }
    },
    watch:{
        //前端校验判断+判断是否展示提示气泡
        stuId:function (value){
            $("#stuIdCheckAddToolTip").tooltip('hide')
            studentAddModalVue.stuIdFlag=validateFormStuId(value)
            if (studentAddModalVue.stuIdFlag==2) {
                $("#stuIdAddToolTip").tooltip('show')
            }
            if (studentAddModalVue.stuIdFlag==1) {
                $("#stuIdAddToolTip").tooltip('hide')
            }
        },
        stuClass:function (value){
            studentAddModalVue.stuClassFlag=validateFormStuClass(value)
            if (studentAddModalVue.stuClassFlag==2) {
                $("#stuClassAddToolTip").tooltip('show')
            }
            if (studentAddModalVue.stuClassFlag==1) {
                $("#stuClassAddToolTip").tooltip('hide')
            }
        },
        stuName:function (value){
            studentAddModalVue.stuNameFlag=validateFormStuName(value)
            if (studentAddModalVue.stuNameFlag==2) {
                $("#stuNameAddToolTip").tooltip('show')
            }
            if (studentAddModalVue.stuNameFlag==1) {
                $("#stuNameAddToolTip").tooltip('hide')
            }
        },
        stuPassword:function (value){
            studentAddModalVue.stuPasswordFlag=validateFormStuPassword(value)
            if (studentAddModalVue.stuPasswordFlag==2) {
                $("#stuPasswordAddToolTip").tooltip('show')
            }
            if (studentAddModalVue.stuPasswordFlag==1) {
                $("#stuPasswordAddToolTip").tooltip('hide')
            }
        },
        stuPhone:function (value){
            studentAddModalVue.stuPhoneFlag=validateFormStuPhone(value)
            if (studentAddModalVue.stuPhoneFlag==2) {
                $("#stuPhoneAddToolTip").tooltip('show')
            }
            if (studentAddModalVue.stuPhoneFlag==1) {
                $("#stuPhoneAddToolTip").tooltip('hide')
            }
        },
        //判断是否通过后端验证
        stuIdCheckFlag:function(){
            if (studentAddModalVue.stuIdCheckFlag==1){
                studentAddModalVue.checkResult=true
            }else{
                studentAddModalVue.checkResult=false
            }
        },
        stuMajor:function (value){
            if (studentAddModalVue.stuCollege==""){
                axios({
                    method:"get",
                    url:contextPath+"/college/getCollegeId",
                    params:{
                        majorId:studentAddModalVue.stuMajor,
                    }
                }).then(function (result){
                    if (result.data!=""){
                        studentAddModalVue.stuCollege=result.data.id;
                        studentAddModalVue.majorInfo=result.data.major;
                    }
                })
            }
        },
        stuCollege:function (value){
            if (studentAddModalVue.stuCollege==""){
                studentAddModalVue.searchMajorInfo();
                studentAddModalVue.stuMajor="";
            }
        }
    }
})

//学生修改模态框相关
var studentUpdateModalVue=new Vue({
    el:"#studentUpdateModal",
    data:{
        student:[],
        collegeInfo:[],
        majorInfo:[],
            stuId:"",
            stuClass:"",
            stuName:"",
            stuPassword:"",
            stuPhone:"",
            stuCollege:"",
            stuMajor:"",

            stuIdFlag:"1",
            stuIdCheckFlag:"0",
            stuClassFlag:"0",
            stuNameFlag:"0",
            stuPasswordFlag:"0",
            stuPhoneFlag:"0",
        flagResult:false,
        checkResult:true,
    },
    methods:{
        searchMajorInfo:function (){
            axios({
                method:"get",
                url:contextPath+"/major/getMajors",
            }).then(function (result){
                // console.log(result);
                studentUpdateModalVue.majorInfo=result.data;
            })
        },
        searchMajorInfoByCollegeId:function (event){
            var collegeId=event.target.value;
            axios({
                method:"get",
                url:contextPath+"/major/getMajorsByCollegeId",
                params:{
                    collegeId:collegeId
                }
            }).then(function (result){
                // console.log(result);
                if (result.data!=""){
                    studentUpdateModalVue.majorInfo=result.data;
                }else{
                    studentUpdateModalVue.searchMajorInfo();
                    studentUpdateModalVue.stuCollege="";
                }
                studentUpdateModalVue.stuMajor="";
            })
        },
        getStudent:function (id){
            axios({
                method:"get",
                url:contextPath+"/student/getStudent/"+id,
            }).then(function (result){
                // console.log(result.data)
                studentUpdateModalVue.student=result.data;
                studentUpdateModalVue.stuId=result.data.stuId;
                studentUpdateModalVue.stuClass=result.data.stuClass;
                studentUpdateModalVue.stuName=result.data.stuName;
                studentUpdateModalVue.stuPassword=result.data.stuPassword;
                studentUpdateModalVue.stuPhone=result.data.stuPhone;
                if (result.data.stuCollege!=null)
                    studentUpdateModalVue.stuCollege=result.data.stuCollege;
                if (result.data.stuMajor!=null){
                    studentUpdateModalVue.stuMajor=result.data.stuMajor;
                }else {
                    studentUpdateModalVue.searchMajorInfo();
                }
                $("#studentUpdateModal input[name=stuGender]").val([studentUpdateModalVue.student.stuGender]);
                // $("#studentUpdateModal select[name=stuCollege]").val([studentUpdateModalVue.student.stuCollege]);
                // $("#studentUpdateModal select[name=stuMajor]").val([studentUpdateModalVue.student.stuMajor]);
            })
        }
    },
    watch:{
        stuId:function(){
            axios({
                method:"get",
                url:contextPath+"/major/getMajorsByCollegeId",
                params:{
                    collegeId:studentUpdateModalVue.stuCollege
                }
            }).then(function (result){
                // console.log(result);
                if (result.data!=""){
                    studentUpdateModalVue.majorInfo=result.data
                }
            })
        },
        //前端校验判断+判断是否展示提示气泡
        stuClass:function (value){
            studentUpdateModalVue.stuClassFlag=validateFormStuClass(value)
            if (studentUpdateModalVue.stuClassFlag==2) {
                $("#stuClassUpdateToolTip").tooltip('show')
            }
            if (studentUpdateModalVue.stuClassFlag==1) {
                $("#stuClassUpdateToolTip").tooltip('hide')
            }
        },
        stuName:function (value){
            studentUpdateModalVue.stuNameFlag=validateFormStuName(value)
            if (studentUpdateModalVue.stuNameFlag==2) {
                $("#stuNameUpdateToolTip").tooltip('show')
            }
            if (studentUpdateModalVue.stuNameFlag==1) {
                $("#stuNameUpdateToolTip").tooltip('hide')
            }
        },
        stuPassword:function (value){
            studentUpdateModalVue.stuPasswordFlag=validateFormStuPassword(value)
            if (studentUpdateModalVue.stuPasswordFlag==2) {
                $("#stuPasswordUpdateToolTip").tooltip('show')
            }
            if (studentUpdateModalVue.stuPasswordFlag==1) {
                $("#stuPasswordUpdateToolTip").tooltip('hide')
            }
        },
        stuPhone:function (value){
            studentUpdateModalVue.stuPhoneFlag=validateFormStuPhone(value)
            if (studentUpdateModalVue.stuPhoneFlag==2) {
                $("#stuPhoneUpdateToolTip").tooltip('show')
            }
            if (studentUpdateModalVue.stuPhoneFlag==1) {
                $("#stuPhoneUpdateToolTip").tooltip('hide')
            }
        },
        stuMajor:function (value){
            if (studentUpdateModalVue.stuCollege==""){
                axios({
                    method:"get",
                    url:contextPath+"/college/getCollegeId",
                    params:{
                        majorId:studentUpdateModalVue.stuMajor,
                    }
                }).then(function (result){
                    if (result.data!=""){
                        studentUpdateModalVue.stuCollege=result.data.id;
                        studentUpdateModalVue.majorInfo=result.data.major;
                    }
                })
            }
        },
        stuCollege:function (value){
            if (studentUpdateModalVue.stuCollege==""){
                studentUpdateModalVue.searchMajorInfo();
                studentUpdateModalVue.stuMajor="";
            }
        }
    }
})

var studentDeleteModalVue =new Vue({
    el:"#studentDeleteModal",
    data:{
        stuId:"",
    },
    methods:{},
    watch:{}
})

//启动模态框
$("#studentAddModalBtn").click(function (){
    studentAddModalVue.searchMajorInfo();
    $("#studentAddModal form")[0].reset();
    clearForm();
    $("#studentAddModal").modal({
        backdrop:"static"
    });
});
$(document).on("click",".studentUpdateModelBtn",function (){
    studentUpdateModalVue.getStudent($(this).attr("update-id"));
    // searchDivVue.searchMajorInfo();
    $("#studentUpdateModal").modal({
        backdrop:"static"
    });
})
$(document).on("click",".studentDeleteModelBtn",function (){
    studentDeleteModalVue.stuId=$(this).attr("delete-id");
    $("#studentDeleteModal").modal({
        backdrop:"static"
    })
})
$(document).on("click","#viewStudent",function (){
    var viewForm=document.getElementById("viewForm");
    // console.log(viewForm.action)
    // console.log($(this).attr("view-id"));
    viewForm.action=viewFormAction+$(this).attr("view-id")
    viewForm.submit()
    // console.log(viewForm.action)
})
//前端验证结尾+ajax添加学生
$("#studentAddSaveBtn").click(function (){
    //确认是否通过所有前端验证
    if(studentAddModalVue.stuIdFlag==1)
        if (studentAddModalVue.stuNameFlag==1)
            // if (studentAddModalVue.stuClassFlag==1)
                if (studentAddModalVue.stuPasswordFlag==1)
                    // if (studentAddModalVue.stuPhoneFlag==1)
                        studentAddModalVue.flagResult=true;
    //判断是否通过前端+后端验证
    if (studentAddModalVue.checkResult!=true||studentAddModalVue.flagResult!=true){
        if (studentAddModalVue.stuId==""){
            studentAddModalVue.stuIdFlag=2;
            $("#stuIdAddToolTip").tooltip('show')
        }
        if(studentAddModalVue.stuName==""){
            studentAddModalVue.stuNameFlag=2;
            $("#stuNameAddToolTip").tooltip('show')
        }
        if(studentAddModalVue.stuPassword==""){
            studentAddModalVue.stuPasswordFlag=2;
            $("#stuPasswordAddToolTip").tooltip('show')
        }
        return false;
    }
    $.ajax({
        url:contextPath+"/student/insertStudent",
        type:"post",
        data:$("#studentAddModal form").serialize(),
        success:function (result){
            // alert(result)
            // alert("学生添加成功！！")
            if (result){
                $("#studentAddModal").modal('hide');
                $("#studentResultModal").modal('show');
                pageInfoVue.pageChange(pageInfoVue.pageNum)
            }else {
                alert("User Info error , please check your message")
            }
        }
    })
});
//前端验证结尾+ajax修改学生
$("#StudentUpdateSaveBtn").click(function (){
    //确认是否通过所有前端验证
    if(studentUpdateModalVue.stuIdFlag==1)
        if (studentUpdateModalVue.stuNameFlag==1)
            // if (studentAddModalVue.stuClassFlag==1)
                if (studentUpdateModalVue.stuPasswordFlag==1)
                    // if (studentAddModalVue.stuPhoneFlag==1)
                    studentUpdateModalVue.flagResult=true;
    //判断是否通过前端+后端验证
    if (studentUpdateModalVue.checkResult!=true||studentUpdateModalVue.flagResult!=true){
        if (studentUpdateModalVue.stuId==""){
            studentUpdateModalVue.stuIdFlag=2;
            $("#stuIdUpdateToolTip").tooltip('show')
        }
        if(studentUpdateModalVue.stuName==""){
            studentUpdateModalVue.stuNameFlag=2;
            $("#stuNameUpdateToolTip").tooltip('show')
        }
        if(studentUpdateModalVue.stuPassword==""){
            studentUpdateModalVue.stuPasswordFlag=2;
            $("#stuPasswordUpdateToolTip").tooltip('show')
        }
        return false;
    }
    $.ajax({
        url:contextPath+"/student/updateStudent/"+studentUpdateModalVue.stuId,
        type:"post",
        data:$("#studentUpdateModal form").serialize(),
        success:function (result){
            if (result==true){
                $("#studentUpdateModal").modal('hide');
                $("#studentResultModal").modal('show');
                pageInfoVue.pageChange(pageInfoVue.pageNum)
            }else{
                alert("修改失败")
            }
        },
        error:function (){
            alert($("#studentUpdateModal form").serialize())
        }
    })
});
//ajax删除单个学生
$("#studentDeleteSaveBtn").click(function (){
    $.ajax({
        url:contextPath+"/student/deleteStudent/"+studentDeleteModalVue.stuId,
        type:"post",
        data:$("#studentDeleteModal form").serialize(),
        success:function (result){
            // alert(result)
            if (result!=0){
                $("#studentDeleteModal").modal('hide');
                if (pageInfoVue.total%8==1){
                    pageInfoVue.pageChange(pageInfoVue.pageNum-1)
                }
                pageInfoVue.pageChange(pageInfoVue.pageNum)
            }
        }
    })
})

function clearForm(){
    studentAddModalVue.stuId="";
    studentAddModalVue.stuIdFlag=0;
    studentAddModalVue.stuIdCheckFlag=0;
    studentAddModalVue.stuClass="";
    studentAddModalVue.stuClassFlag=0;
    studentAddModalVue.stuName="";
    studentAddModalVue.stuNameFlag=0;
    studentAddModalVue.stuPassword="";
    studentAddModalVue.stuPasswordFlag=0;
    studentAddModalVue.stuPhone="";
    studentAddModalVue.stuPhoneFlag=0;
    studentAddModalVue.flagResult=false;
    studentAddModalVue.checkResult=false;
}
//实际前端校验id，name，class，password，phone
function validateFormStuId(value){
    var regstuId=/^[0-9]{6,16}$/;
    if(!regstuId.test(value)){
        return 2
    }
    return 1
}
function validateFormStuClass(value){
    var regstuClass=/^[0-9]{1,8}$/;
    if(!regstuClass.test(value)){
        return 2
    }
    return 1
}
function validateFormStuName(value){
    var regstuName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
    if(!regstuName.test(value)){
        return 2
    }
    return 1
}
function validateFormStuPassword(value){
    var regstuPassword=	/^[a-zA-Z0-9_-]{6,18}$/;
    if(!regstuPassword.test(value)){
        return 2
    }
    return 1
}
function validateFormStuPhone(value){
    var regstuPhone=/^[0-9]{11}$/;
    if(!regstuPhone.test(value)){
        return 2
    }
    return 1
}

/**
 * 后端验证id,发送ajox请求到StudentController中的checkStudentIdWithJson方法中
 * 检查在数据库中是否存在相同的学生ID
 * 返回结果为true代表检查成功，数据库中不存在重复的学生id，
 *      令flag=1表示已经经过后端校验且通过
 *      最后令id=stuIdCheckAddToolTip的提示冒泡隐藏
 * 否则代表检查失败，数据库中存在重复学生id
 *      令flag=2表示未通过校验，
 *      最后令id=stuIdCheckAddToolTip的提示冒泡显示，id=stuIdAddToolTip的提示冒泡隐藏
 */
function checkStudentId(){
    if (studentAddModalVue.stuId=="" || studentAddModalVue.stuIdFlag==2){
        return false;
    }
    $.ajax({
        // url:contextPath+"/student/checkStudentId",
        url:contextPath+"/system/checkId",
        type: "post",
        data:{"id":studentAddModalVue.stuId,"identity":"1"},
        success:function (result){
            if (result==true){
                studentAddModalVue.stuIdCheckFlag=1
                //不能加上，不然后端校验成功的话会强制确认前端校验成功
                // studentAddModalVue.stuIdFlag=1
                $("#stuIdCheckAddToolTip").tooltip('hide')
            }else{
                studentAddModalVue.stuIdCheckFlag=2
                studentAddModalVue.stuIdFlag=2
                $("#stuIdCheckAddToolTip").tooltip('show')
                $("#stuIdAddToolTip").tooltip('hide')
            }
            // console.log(result);
        }
    })
}













// function searchStudents(event) {
//     $.ajax({
//         //几个参数需要注意一下
//         type: "get",//方法类型
//         dataType: "json",//预期服务器返回的数据类型
//         url: contextPath + "/student/searchStudents",//url
//         data: $('#searchForm').serialize(),
//         success: function (result) {
//             console.log(result);//打印服务端返回的数据(调试用)
//             // if (result.resultCode == 200) {
//             //     alert("SUCCESS");
//             // }
//             messageTbodyVue.students=result.list
//         },
//         error: function () {
//             alert("异常！");
//         }
//     });
// }
// $(function (){
//     $.ajax({
//         url:contextPath+"/student/getStudents",
//         data:"pageNo=1",
//         type:"get",
//         success:function (result){
//             build_Student_table(result);
//         },
//         error:function (){
//             console.log("失败")
//         }
//     });
// });
// function build_Student_table(result){
//     var Students=result.list;
//     $.each(Students,function (index,item){
//         var StudentIdTd=$("<td></td>").append(item.stuId);
//         var StudentClassTd=$("<td></td>").append(item.stuClass);
//         var StudentNameTd=$("<td></td>").append(item.stuName);
//         var StudentGenderTd=$("<td></td>").append(item.stuGender);
//         var StudentPhoneTd=$("<td></td>").append(item.stuPhone);
//         var StudentCollegeTd=$("<td></td>").append(item.stuCollege);
//         var StudentMajorTd=$("<td></td>").append(item.stuMajor);
//         $("<tr></tr>").append(StudentIdTd).append(StudentClassTd).append(StudentNameTd).append(StudentGenderTd).append(StudentPhoneTd).append(StudentCollegeTd).append(StudentMajorTd).appendTo("#messageTable tbody");
//     });
// };
// function build_page_nav(result){};