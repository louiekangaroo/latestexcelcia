<?php
session_start();
include_once("./udf/udf.php");

/* session variables */
    $_SESSION['address']    ='';
    $_SESSION['contactno']  ='';
    $_SESSION['emailadd']   ='';
    $_SESSION['fname']      ='';
    $_SESSION['id']         ='';
    $_SESSION['lname']      ='';
    $_SESSION['mname']      ='';
    $_SESSION['password']   ='';
    $_SESSION['status']     ='';
    $_SESSION['username']   ='';
    $_SESSION['usertype']   ='';
/* end of session variables */

$pw='';
$id='';
if(isset($_POST['user_login']) && isset($_POST['user_password']) ){
    $id = $_POST['user_login'];
    $pw = $_POST['user_password'];
    if(ChkUserLogin($id, $pw)) {
        siteRedirectWithAlert("Welcome back " . $_SESSION['wholename'],"index.php");
    }else{
        session_destroy();
        DisplayAlert("invalid login....");
    }
} else {
    
}

?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="Team PELA">

    <link rel='shortcut icon' type='image/x-icon' href='../favicon.ico' />

    <title>CIA</title>

    <link href="build/css/metro.css" rel="stylesheet">
    <link href="build/css/metro-icons.css" rel="stylesheet">
    <link href="build/css/metro-responsive.css" rel="stylesheet">

    <script src="build/js/jquery-1.12.3.js"></script>
    <script src="build/js/metro.js"></script>
 
    <style>
        .login-form {
            width: 25rem;
            height: 18.75rem;
            position: fixed;
            top: 50%;
            margin-top: -9.375rem;
            left: 50%;
            margin-left: -12.5rem;
            background-color: #ffffff;
            opacity: 0;
            -webkit-transform: scale(.8);
            transform: scale(.8);
        }
    </style>

    <script>
        $(function(){
            var form = $(".login-form");

            form.css({
                opacity: 1,
                "-webkit-transform": "scale(1)",
                "transform": "scale(1)",
                "-webkit-transition": ".5s",
                "transition": ".5s"
            });

            $(".btnCancel").click(function() {
                $("#user_login").val("");
                $("#user_password").val("");
            });
        });
    </script>
</head>
<body class="bg-lightBlue">
    <div class="login-form padding20 block-shadow">
        <form action="#" method="post">
            <h1 class="text-light">Login</h1>
            <hr class="thin"/>
            <br />
            <div class="input-control text full-size" data-role="input">
                <input type="text" name="user_login" id="user_login" placeholder="Username" required="">
                <button class="button helper-button clear"><span class="mif-cross"></span></button>
            </div>
            <br />
            <br />
            <div class="input-control password full-size" data-role="input">
                <input type="password" name="user_password" id="user_password" placeholder="Password" required="">
                <button class="button helper-button reveal"><span class="mif-looks"></span></button>
            </div>
            <br />
            <br />
            <div class="form-actions">
                <button type="submit" class="button primary">Login</button>
                <button type="button" class="btnCancel button link">Cancel</button>
            </div>
        </form>
    </div>
</body>
</html>