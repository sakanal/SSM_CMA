$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})
var navMenuVue=new Vue({
    el:"#navMenu"
})
var updatePasswordModalVue=new Vue({
    el:"#updatePasswordModal",
    data:{
        password:"",
            passwordFlag:"0",
            checkPasswordFlag:false,
        newPassword:"",
            newPasswordFlag:"0",
        checkNewPassword:"",
            checkNewPasswordFlag:"0",
    },
    watch:{
        password:function (value){
            updatePasswordModalVue.passwordFlag=validateFormPassword(value);
        },
        passwordFlag:function (value){
            if (value===2){
                $("#passwordUpdateToolTip").tooltip('show');
                $("#passwordCheckUpdateToolTip").tooltip('hide');
            }else if(value===1){
                $("#passwordUpdateToolTip").tooltip('hide')
            }
        },
        newPassword:function (value){
            updatePasswordModalVue.newPasswordFlag=validateFormPassword(value);
            if (updatePasswordModalVue.checkNewPassword!==""){
                if (updatePasswordModalVue.checkNewPassword!==updatePasswordModalVue.newPassword){
                    updatePasswordModalVue.checkNewPasswordFlag="2";
                }else {
                    updatePasswordModalVue.checkNewPasswordFlag="1";
                }
            }
        },
        newPasswordFlag:function (value){
            if (value===2){
                $("#newPasswordUpdateToolTip").tooltip('show')
            }else if(value===1){
                $("#newPasswordUpdateToolTip").tooltip('hide')
            }
        },
        checkNewPassword:function (value){
            updatePasswordModalVue.checkNewPasswordFlag=validateFormPassword(value);
            if (updatePasswordModalVue.newPassword!==""){
                if (updatePasswordModalVue.checkNewPassword!==updatePasswordModalVue.newPassword){
                    updatePasswordModalVue.checkNewPasswordFlag="2";
                }else {
                    updatePasswordModalVue.checkNewPasswordFlag="1";
                }
            }
        },
        checkNewPasswordFlag:function (value){
            if (value===2){
                $("#checkNewPasswordUpdateToolTip").tooltip('show')
            }else if(value===1){
                $("#checkNewPasswordUpdateToolTip").tooltip('hide')
            }
        },
    }
})
$("#updatePassword").click(function (){
    $("#updatePasswordModal").modal('show');
})
$("#passwordUpdateSaveBtn").click(function (){
    if (updatePasswordModalVue.passwordFlag=="1"){
        if (updatePasswordModalVue.checkPasswordFlag==true){
            if (updatePasswordModalVue.newPasswordFlag=="1"){
                if (updatePasswordModalVue.checkNewPasswordFlag=="1"){
                    // console.log($("#updatePasswordModal form").serialize())
                    $.ajax({
                        url: contextPath+"/system/updatePassword",
                        data:$("#updatePasswordModal form").serialize(),
                        type: "post",
                        success:function (result){
                            console.log(result)
                            $("#updatePasswordModal").modal('hide');
                        }
                    })
                }
            }
        }
    }
})
function checkPassword(){
    // alert($("#updatePasswordModal input[name=id]").val())
    if (updatePasswordModalVue.passwordFlag===1){
        $.ajax({
            url:contextPath+"/system/checkPassword/",
            type:"post",
            data:{
                id:$("#updatePasswordModal input[name=id]").val(),
                identity:$("#updatePasswordModal input[name=identity]").val(),
                password:updatePasswordModalVue.password,
            },
            success:function (result){
                // console.log(result)
                if (result===false){
                    updatePasswordModalVue.passwordFlag="2";
                    updatePasswordModalVue.checkPasswordFlag=false;
                    $("#passwordUpdateToolTip").tooltip('hide');
                    $("#passwordCheckUpdateToolTip").tooltip('show');
                }else{
                    updatePasswordModalVue.passwordFlag="1";
                    updatePasswordModalVue.checkPasswordFlag=true;
                    $("#passwordCheckUpdateToolTip").tooltip('hide');
                }
            }
        })
    }
}
function validateFormPassword(value){
    var regstuPassword=	/^[a-zA-Z0-9_-]{6,18}$/;
    if(!regstuPassword.test(value)){
        return 2
    }
    return 1
}