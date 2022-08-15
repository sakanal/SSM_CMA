window.onload=function (){
    getTeachers();
    getCollegeInfo();
}
$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})

var searchDivVue=new Vue({
    el:"#searchDiv",
    data:{
        tchId:"",
        tchName:"",
        tchCollege:"",
        collegeInfo:[],
    },
    methods:{
        searchTeachers:function (){
            // console.log($("#searchForm").serialize())
            axios({
                method:"get",
                url:contextPath+"/teacher/searchTeachers",
                params: {
                    tchId:searchDivVue.tchId,
                    tchName:searchDivVue.tchName,
                    tchCollege:searchDivVue.tchCollege,
                },
            }).then(function (result){
                pageInfoVue.pageInfo=result.data
                messageTbodyVue.teachers=result.data.list
            })
        }
    }
})
var messageTbodyVue=new Vue({
    el: "#messageTbody",
    data:{
        teachers:[],
    },
    methods:{
    }
})
var pageInfoVue=new Vue({
    el:"#pageInfo",
    data:{
        pageInfo:[],
        total:"",
        pageNum:"",
    },
    methods:{
        pageChange:function (pageNo){
            axios({
                method:"get",
                url:contextPath+"/teacher/searchTeachers",
                params:{
                    pageNo:pageNo,
                    tchId:searchDivVue.tchId,
                    tchName:searchDivVue.tchName,
                    tchCollege:searchDivVue.tchCollege,
                }
            }).then(function (result){
                messageTbodyVue.teachers=result.data.list;
                pageInfoVue.pageInfo=result.data;
            })
        }
    },
    watch:{
        pageInfo:function (value){
            pageInfoVue.total=value.total
            pageInfoVue.pageNum=value.pageNum
        }
    }
})
var teacherAddModalVue=new Vue({
    el:"#teacherAddModal",
    data:{
        collegeInfo:[],
        tchId:"",
            tchIdFlag:"0",
            tchIdCheckFlag:"0",
        tchName:"",
            tchNameFlag:"0",
        tchPassword:"",
            tchPasswordFlag:"0",
        tchPhone:"",
            tchPhoneFlag:"0",
        tchEmail:"",
            tchEmailFlag:"0",
        tchCollege:"",
    },
    watch: {
        tchId:function (value){
            teacherAddModalVue.tchIdFlag=validateFormTchId(value);
            $("#tchIdCheckAddToolTip").tooltip("hide")
            if (teacherAddModalVue.tchIdFlag==2){
                $("#tchIdAddToolTip").tooltip("show")
            }
            if (teacherAddModalVue.tchIdFlag==1){
                $("#tchIdAddToolTip").tooltip("hide")
            }
        },
        tchName:function (value){
            teacherAddModalVue.tchNameFlag=validateFormTchName(value);
            if (teacherAddModalVue.tchNameFlag==2){
                $("#tchNameAddToolTip").tooltip("show")
            }
            if (teacherAddModalVue.tchNameFlag==1){
                $("#tchNameAddToolTip").tooltip("hide")
            }
        },
        tchPassword:function (value){
            teacherAddModalVue.tchPasswordFlag=validateFormTchPassword(value);
            if (teacherAddModalVue.tchPasswordFlag==2){
                $("#tchPasswordAddToolTip").tooltip("show")
            }
            if (teacherAddModalVue.tchPasswordFlag==1){
                $("#tchPasswordAddToolTip").tooltip("hide")
            }
        },
        tchPhone:function (value){
            teacherAddModalVue.tchPhoneFlag=validateFormTchPhone(value);
            if (teacherAddModalVue.tchPhoneFlag==2){
                $("#tchPhoneAddToolTip").tooltip("show")
            }
            if (teacherAddModalVue.tchPhoneFlag==1){
                $("#tchPhoneAddToolTip").tooltip("hide")
            }
        },
        tchEmail:function (value){
            teacherAddModalVue.tchEmailFlag=validateFormTchEmail(value);
            if (teacherAddModalVue.tchEmailFlag==2){
                $("#tchEmailAddToolTip").tooltip("show")
            }
            if (teacherAddModalVue.tchEmailFlag==1){
                $("#tchEmailAddToolTip").tooltip("hide")
            }
        },
    }
})
// var teacherUpdateModalVue=new Vue({
//     el: "#teacherUpdateModal",
//     methods:{
//         getTeacher:function (tchId){
//             alert(tchId)
//         }
//     }
// })
$("#teacherAddModalBtn").click(function (){
    $("#teacherAddModal").modal({
        backdrop:"static"
    })
})
$("#teacherAddSaveBtn").click(function (){
    var resultFlag=false
    // console.log($("#teacherAddForm").serialize())
    if (teacherAddModalVue.tchIdFlag=="1"){
        if (teacherAddModalVue.tchNameFlag=="1"){
            if (teacherAddModalVue.tchPasswordFlag=="1"){
                resultFlag=true
            }
        }
    }
    if (resultFlag===false || teacherAddModalVue.tchIdCheckFlag!="1"){
        if (teacherAddModalVue.tchIdFlag=="0"){
            alert("456")
            teacherAddModalVue.tchIdFlag="2";
            $("#tchIdAddToolTip").tooltip("show")
        }
        if (teacherAddModalVue.tchNameFlag=="0"){
            teacherAddModalVue.tchNameFlag="2";
            $("#tchNameAddToolTip").tooltip("show")
        }
        if (teacherAddModalVue.tchPasswordFlag=="0"){
            teacherAddModalVue.tchPasswordFlag="2";
            $("#tchPasswordAddToolTip").tooltip("show")
        }
        return false
    }
    $.ajax({
        url:contextPath+"/teacher/insertTeacher",
        method:"post",
        data:$("#teacherAddForm").serialize(),
        success:function (result){
            console.log(result)
            $("#teacherAddModal").modal("hide")
            pageInfoVue.pageChange(1);
        }
    })
})

// $(document).on("click",".teacherUpdateModelBtn",function (){
//     teacherUpdateModalVue.getTeacher($(this).attr("update-id"));
//     $("#teacherUpdateModal").modal({
//         backdrop:"static"
//     });
// })

function getTeachers(){
    $.ajax({
        url:contextPath+"/teacher/getTeachers",
        type:"get",
        success:function (result){
            messageTbodyVue.teachers=result.list;
            pageInfoVue.pageInfo=result;
            // pageInfoVue.total=result.total;
            // pageInfoVue.pageNum=result.pageNum;
        }
    })
}
function getCollegeInfo(){
    $.ajax({
        url:contextPath+"/college/getColleges",
        type: "get",
        success:function (result){
            // console.log(result)
            searchDivVue.collegeInfo=result;
            teacherAddModalVue.collegeInfo=result;
        }
    })
}
function checkTeacherId(){
    if (teacherAddModalVue.tchId=="" || teacherAddModalVue.tchIdFlag==2){
        return false;
    }
    $.ajax({
        url:contextPath+"/system/checkId",
        type:"post",
        data:{"id":teacherAddModalVue.tchId,"identity":"2"},
        success:function (result){
            if (result==false){
                teacherAddModalVue.tchIdCheckFlag="2";
                teacherAddModalVue.tchIdFlag="2";
                $("#tchIdCheckAddToolTip").tooltip("show")
            }else if (result==true){
                teacherAddModalVue.tchIdCheckFlag="1";
                $("#tchIdCheckAddToolTip").tooltip("hide")
            }
            // console.log(result)
        }
    })
}


function validateFormTchId(value){
    var regTchId=/^[0-9]{6,16}$/;
    if(!regTchId.test(value)){
        return 2
    }
    return 1
}
function validateFormTchName(value){
    var regTchName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
    if(!regTchName.test(value)){
        return 2
    }
    return 1
}
function validateFormTchPassword(value){
    var regTchPassword=	/^[a-zA-Z0-9_-]{6,18}$/;
    if(!regTchPassword.test(value)){
        return 2
    }
    return 1
}
function validateFormTchPhone(value){
    var regTchPhone=/^[0-9]{11}$/;
    if(!regTchPhone.test(value)){
        return 2
    }
    return 1
}
function validateFormTchEmail(value){
    var regTchEamil=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if (!regTchEamil.test(value)){
        return 2
    }
    return 1
}