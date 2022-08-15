$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})
var loginFormVue=new Vue({
    el:"#loginForm",
    data:{
        radioCheck:"1",
        holder:"",
        id:"",
            idFlag:"0",
        password:"",
            passwordFlag:"0",
    },
    methods:{
        userLogin:function (event){
            var dataTable=document.getElementById("dataTable");
            var idFlag=validateFormId($("#dataTable input[name=id]").val());
            if (idFlag===true){
                loginFormVue.idFlag="1";
            }else{
                loginFormVue.idFlag="2";
            }
            // $("#dataTable input[name=id]").val()
            var passwordFlag=validateFormPassword($("#dataTable input[name=password]").val())
            if (passwordFlag===true){
                loginFormVue.passwordFlag="1";
            }else {
                loginFormVue.passwordFlag="2";
            }
            // $("#dataTable input[name=password]").val()
            var identity=$("#dataTable input[name=identity]").val()
            var identityFlag=false;
            if (identity=="1" || identity=="2" || identity=="3")
                identityFlag=true;
            // $("#dataTable input[name=identity]").val()
            if (idFlag==true && passwordFlag==true && identityFlag==true)
                dataTable.submit();
        },
        userRegister:function (event){
            var dataTabel = document.getElementById("registerForm");
            dataTabel.submit();
        }
    },
    watch:{
        radioCheck: function (value) {
            changeHolder(value);
        },
        id:function (value){
            var flag =validateFormId(value);
            if (flag===true){
                loginFormVue.idFlag="1";
            }else{
                loginFormVue.idFlag="2";
            }
        },
        password:function (value){
            var flag=validateFormPassword(value);
            if (flag===true){
                loginFormVue.passwordFlag="1";
            }else {
                loginFormVue.passwordFlag="2";
            }
        },
    }
})
function validateFormId(value){
    var regstuId=/^[0-9]{6,16}$/;
    return regstuId.test(value);

}
function validateFormPassword(value){
    var regstuPassword=	/^[a-zA-Z0-9_-]{6,18}$/;
    return  regstuPassword.test(value)
}