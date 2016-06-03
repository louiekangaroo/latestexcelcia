<?PHP 
   session_start();
   include_once("./udf/udf.php");
   include_once("menuinterface.php");
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
            <li><a href="index.php">Home</a></li>
            <!-- start of dynamic menu -->
            <?PHP echo $displaymenu; ?>
            <!-- end of dynamic menu -->
         </ul>
         <div class="app-bar-element place-right">
            <span class="dropdown-toggle"><span class="mif-cog"></span> Hi, <?PHP echo $usertype . ' ' . $fname ?></span>
            <div class="app-bar-drop-container padding10 place-right no-margin-top block-shadow fg-dark" data-role="dropdown" data-no-close="true" style="width: 220px">
               <h2 class="text-light">Quick settings</h2>
               <ul class="unstyled-list fg-dark">
                  <li><a href="" class="fg-white1 fg-hover-yellow">Profile</a></li>
                  <li><a href="controllers/logout.php" class="fg-white3 fg-hover-yellow">Logout</a></li>
               </ul>
            </div>
         </div>
      </div>
   </body>
</html>