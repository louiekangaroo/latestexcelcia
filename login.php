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

    <title>ECLearning</title>

    <link href="build/css/metro.css" rel="stylesheet">
    <link href="build/css/metro-icons.css" rel="stylesheet">
    <link href="build/css/metro-responsive.css" rel="stylesheet">
    <link href="styles/main.css" rel="stylesheet">
    <link href="styles/login.css" rel="stylesheet">

    <script src="build/js/jquery-1.12.3.js"></script>
    <script src="build/js/metro.js"></script>
    
     <style>
      
    </style>
</head>
<body style="margin: 0 0 0 0">
    <form action="#" method="post">
        <div class="login-form">
            <div><input type="text" name="user_login" id="user_login" placeholder="Username" class="textBox" required=""></div>
            <div><input type="password" name="user_password" id="user_password" placeholder="Password" class="textBox" required=""></div>
            <div class="form-actions">
                <button type="button" class="btnForgotPassword button link">Forgot your password?</button>
                <button type="submit" class="button primary">Sign In</button>
            </div>
        </div>
    </div>
    </form>
</body>
</html>