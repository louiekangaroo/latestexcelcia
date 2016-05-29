<!DOCTYPE html>
<html ng-app="myNewUser">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="Team PELA">

    <link rel='shortcut icon' type='image/x-icon' href='../favicon.ico' />

    <title>CIA</title>

    <link href="build/css/bootstrap.min.css" rel="stylesheet">
    <link href="build/css/metro.css" rel="stylesheet">
    <link href="build/css/metro-icons.css" rel="stylesheet">
    <link href="build/css/metro-responsive.css" rel="stylesheet">
    <link href="styles/index.css" rel="stylesheet">

    <script src="build/js/jquery-1.12.3.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/usermanagement.js"></script>
    <script src="js/newusermanagement.js"></script>
    <script src="build/js/metro.js"></script>
    <script>
    window.onbeforeunload = function() {
        return "You are leaving the page";
    };
    </script>

</head>
<body class="bg-white"  ng-controller="myNewUserCtrl">
<div class="container-fluid">
<div class="main-content-popup clear-float">
    <h1 class="welcome-to-title lblUser">Add New User</b></h1>
    <hr class="thin bg-grayLighter">
    <div style="margin-top:30px;">
        <div class="defBox input-control text">
            <label class="labelForm">Username:</label>
            <input type="text" class="txtUsername">
        </div>
        <div class="defBox input-control password">
            <label class="labelForm">Password:</label>
            <input type="password" class="txtPasword">
        </div>
    </div>
    <div style="margin-top:30px;">
        <div class="defBox input-control text">
            <label class="labelForm">First Name:</label>
            <input type="text" class="txtFirstname">
        </div>
        <div class="defBox input-control text">
            <label class="labelForm">Middle Name:</label>
            <input type="text" class="txtMiddlename">
        </div>
         <div class="defBox input-control text">
            <label class="labelForm">Last Name:</label>
            <input type="text" class="txtLastname">
        </div>
    </div>
    <div style="margin-top:30px;">
        <div class="defBox input-control text">
            <label class="labelForm">Address:</label>
            <textarea class="txtAddress"></textarea>
        </div>
    </div>
    <div style="margin-top:80px;">
        <div class="defBox input-control text">
            <label class="labelForm">Contact Number:</label>
            <input type="text" class="txtContactNumber">
        </div>
        <div class="defBox input-control text">
            <label class="labelForm">Email Address:</label>
            <input type="text" class="txtEmailAdd">
        </div>
    </div>
    <div style="margin-top:30px;">
        <div class="defBox input-control select">
            <label class="labelForm">User Type:</label>
            <select class="drpUserType">
                <option>Admin</option>
                <option>Teacher</option>
                <option>Student</option>
            </select>
        </div>
        <div class="defBox input-control select">
            <label class="labelForm">Status:</label>
            <select class="drpStatus">
                <option>Active</option>
                <option>Inactive</option>
            </select>
        </div>
    </div>
     <hr class="thin bg-grayLighter">
     <div style="float:right;">
        <button class="button primary btnSave"><span class="mif-floppy-disk"></span> Save</button>
        <button class="button btnCancel"><span class="mif-cancel"></span> Cancel</button>
     </div>
</div>
</div>
 </body>
</html>