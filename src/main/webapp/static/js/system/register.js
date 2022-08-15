$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})
var registerFormVue=new Vue({
    el:"#registerForm",
    data:{
        radioCheck:"1",
        holder:"",
        id:"",
        idFlag:"0",
        idCheckFlag:"0",
        name:"",
        nameFlag:"0",
        password:"",
        passwordFlag:"0",
        checkPassword:"",
        checkPasswordFlag:"0",
    },
    methods:{
        userRegister:function (event){
            var dataTable=document.getElementById("dataTable");
            console.log(registerFormVue.id)
            console.log(registerFormVue.idFlag)
            console.log(registerFormVue.idCheckFlag)
            console.log(registerFormVue.name)
            console.log(registerFormVue.nameFlag)
            console.log(registerFormVue.password)
            console.log(registerFormVue.passwordFlag)
            console.log(registerFormVue.checkPasswordFlag)
            console.log(registerFormVue.radioCheck)
            if (registerFormVue.id!="" && registerFormVue.idFlag=="1" && registerFormVue.idCheckFlag=="1"){
                if (registerFormVue.name!="" && registerFormVue.nameFlag=="1"){
                    if (registerFormVue.password!="" && registerFormVue.passwordFlag=="1" && registerFormVue.checkPasswordFlag=="1"){
                        if (registerFormVue.radioCheck=="1" || registerFormVue.radioCheck=="2"){
                            dataTable.submit();
                        }
                    }
                }
            }
            // var idFlag=validateFormId($("#dataTable input[name=id]").val())
            // var passwordFlag=validateFormPassword($("#dataTable input[name=password]").val())
            // var identity=$("#dataTable input[name=identity]").val()
            // var identityFlag=false;
            // if (identity=="1" || identity=="2")
            //     identityFlag=true;
            // if (idFlag==true && passwordFlag==true && identityFlag==true){}
                // dataTable.submit();
        }
    },
    watch:{
        radioCheck: function (value) {
            changeHolder(value);
            if (registerFormVue.id!=""){
                checkId()
            }
        },
        id:function (value){
            registerFormVue.idFlag=validateFormId(value)
        },
        name: function (value){
            registerFormVue.nameFlag=validateFormName(value)
        },
        password: function (value){
            registerFormVue.passwordFlag=validateFormPassword(value)
            if (registerFormVue.checkPassword!=""){
                if(value!=registerFormVue.checkPassword){
                    registerFormVue.checkPasswordFlag='2'
                }else {
                    registerFormVue.checkPasswordFlag='1'
                }
            }
        },
        checkPassword: function (value){
            if (value!=registerFormVue.password){
                // console.log(false)
                registerFormVue.checkPasswordFlag='2'
            }else{
                // console.log(true)
                registerFormVue.checkPasswordFlag='1'
            }
        }
    }
})
function validateFormId(value){
    var regstuId=/^[0-9]{6,16}$/;
    if(!regstuId.test(value)){
        return 2
    }
    return 1
}
function validateFormName(value){
    var regstuName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
    if(!regstuName.test(value)){
        return 2
    }
    return 1
}
function validateFormPassword(value){
    var regstuPassword=	/^[a-zA-Z0-9_-]{6,18}$/;
    if(!regstuPassword.test(value)){
        return 2
    }
    return 1
}

//后端验证id
function checkId(){
    if (registerFormVue.id==""){
        return false;
    }
    $.ajax({
        url:contextPath+"/system/checkId",
        type: "post",
        data:{"id":registerFormVue.id,"identity":registerFormVue.radioCheck},
        success:function (result){
            // console.log(result)
            if (result==true){
                registerFormVue.idFlag=1;
                registerFormVue.idCheckFlag=1;
                $("#idCheckToolTip").tooltip('hide');
            }else {
                registerFormVue.idFlag=2;
                registerFormVue.idCheckFlag=2;
                $("#idCheckToolTip").tooltip('show')
            }
        }
    })
}