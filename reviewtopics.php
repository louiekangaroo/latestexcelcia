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
      <!--CSS------------------------------------------>
      <link href="build/css/metro.css" rel="stylesheet">
      <link href="build/css/metro-icons.css" rel="stylesheet">
      <link href="build/css/metro-responsive.css" rel="stylesheet">
      <link href="styles/main.css" rel="stylesheet">
      <link href="styles/index.css" rel="stylesheet">
      <!--JAVASCRIPTS------------------------------------------>
      <script src="build/js/jquery-1.12.3.js"></script>
      <script src="build/js/metro.js"></script>
      <style>
         html, body {
         height: 100%;
         }
         body {
         }
         .page-content {
         padding-top: 3.125rem;
         min-height: 100%;
         height: 100%;
         }
         .table .input-control.checkbox {
         line-height: 1;
         min-height: 0;
         height: auto;
         }
         @media screen and (max-width: 800px){
         #cell-sidebar {
         flex-basis: 52px;
         }
         #cell-content {
         flex-basis: calc(100% - 52px);
         }
         }
      </style>
   </head>
   <body>
      <div class="app-bar fixed-top darcula" data-role="appbar">
         <a class="app-bar-element branding">CIA</a>
         <span class="app-bar-divider"></span>
         <ul class="app-bar-menu">
            <!--<li><a href="index.php">Home</a></li>-->
         </ul>
      </div>
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">Session Type</h1>
            <hr class="thin bg-grayLighter">
            <?PHP 
               session_start();
               include_once("./udf/udf.php");
               if(strlen(trim($_SESSION['usertype']))<1 ){
                   siteRedirectWithAlert("You Must Login first!","login.php");
               }
               
                // Create connection
               require("controllers/connection.php");
               global $con;
               
               if (!$con) {
                die("Connection failed: " . mysqli_connect_error());
               }
               
               $sql = "CALL getReviewtopic()";
               
               $result = mysqli_query($con, $sql);
               
               echo '<form name="revform" method="post" action="studyunits.php"><div class="coolTable" ><table><tr><td></td></tr>';
               foreach ($result as $row){
                
               
               echo '<tr>';
               echo '<label class="input-control radio" >';
                echo '<input type="radio" name="rdtopic" value="'.$row['id'].'" id="rdio">';
                echo '<span class="check"></span>';
                echo '<span class="caption">'.$row["topicname"].'</span>';
                echo '</label>';
                    echo '</tr>';
                   echo '<br>';
                }
               echo '</table></div>';
               echo '<button id="btnStartSession" id="submit" class="button primary btn">Submit</button></form>';
                
               ?>
         </div>
      </div>
   </body>
</html>
