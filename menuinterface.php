<?PHP
	if(strlen(trim($_SESSION['usertype']))<1 ){
       siteRedirectWithAlert("You Must Login first!","login.php");
   }
   $usertype = strtolower($_SESSION['usertype']);
   $fname  = strtoupper($_SESSION['fname']);
   
   $displaymenu = "<li><a href='#'>Profile</a></li> ";
   if($usertype=='admin') {
       $displaymenu .= "                   
                   <li>
                       <a href='#' class='dropdown-toggle'>CIA Management</a>
                       <ul class='d-menu' data-role='dropdown'>
                           <li><a href='usermanagement.php'>User Accounts</a></li>
                           <li class='divider'></li>
                           <li><a href='#'>Question Bank</a></li>
                       </ul>
                   </li>
                   <li>
                       <a href='#' class='dropdown-toggle'>Report Management</a>
                       <ul class='d-menu' data-role='dropdown'>
                           <li><a href='#'>User Activity Logs</a></li>
                           <li class='divider'></li>
                           <li><a href='#'>Exam Results</a></li>
                       </ul>
                   </li>";
   }
   if($usertype=='teacher') {
       $displaymenu .= "
                   <li><a href='#'>Manage Study Materials</a></li>    
                   <li><a href='#'>View Students Performance Report</a></li>";    
   }
   if($usertype=='student') {
       $displaymenu .= "
                   <!-- <li><a href='#'>Review/Download Materials</a></li> -->   
                   <li><a href='selectsession.php'>Select Session</a></li>";    
   }
   $displaymenu .= "<li><a href='#'>Help, Info and Support</a></li>";
 ?>