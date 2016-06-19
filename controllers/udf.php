<?php

// This file contains helper functions
// ===============================
// Function that strips input from 
// HTML, PHP tags and slashes
// ===============================
function cleanMe($input){
   $input = strip_tags($input);
   $input = stripslashes($input);
   $input = str_replace("'", ' ', $input);
   $input = str_replace('"', ' ', $input);   
   return $input;
}


function ValidUser(){
	$good = false;
	if(isset($_SESSION['Utype']) && ($_SESSION['Utype']=='s' || $_SESSION['Utype']=='st') || $_SESSION['Utype']=='a'){
		$good =  true;
	}
	return $good;
}

/*
			if(chkannouncements()){
				$announcements = $_SESSION['announcements'];
*/
function chkannouncements(){
	$x = false;
	$_SESSION['announcements']='';
	$announcements = '';
	//include('./controllers/connection.php');
	$UserQuery = "select * from announcement_tbl where date(afdate) <= date(now()) and date(atdate) >= date(now());";
	
	//die($UserQuery);
	
	$UserResult = mysqli_query($connection,$UserQuery);
	$UserNum = mysqli_num_rows($UserResult);
	
	mysqli_close($connection);
	if(mysqli_num_rows($UserResult)){
		$i=0;
		while ($row = mysqli_fetch_array($UserResult)){		
				$announcements		.=	'<li>'.stripslashes($row['adetails']) . '</li><br />';
				$i++;
				$x = true;
		}
	}
	$_SESSION['announcements'] = $announcements;
	//die($announcements);
	return $x;
}

function ChkUserLogin($vUserID,$vUserPassword){
	$vuid = trim($vUserID);
	$vupwd	= trim($vUserPassword);
	$vfound = false;
	$i=0;
	include('./controllers/connection.php');

	$_SESSION['studentID']	='';
	$_SESSION['address']	='';
	$_SESSION['contactno']	='';
	$_SESSION['emailadd']	='';
	$_SESSION['fname']		='';
	$_SESSION['id']			='';
	$_SESSION['lname']		='';
	$_SESSION['mname']		='';
	$_SESSION['password']	='';
	$_SESSION['status']		='';
	$_SESSION['username']	='';
	$_SESSION['usertype']	='';


	$_SESSION['wholename'] 			= '';
	//<meta http-equiv='refresh' content='10; URL=main.html'>

	$UserQuery = 'NO QUERY';
	
	$UserQuery = "SELECT * FROM personalinfo t where username='$vuid' and password = '$vupwd' and status='1';";

	//die($UserQuery);
	
	$UserResult = mysqli_query($con,$UserQuery);
	$UserNum = mysqli_num_rows($UserResult);
	
	mysqli_close($con);
	if(mysqli_num_rows($UserResult)){
		$i=0;
		while ($row = mysqli_fetch_array($UserResult)){		

				$_SESSION['studentID']  =stripslashes($row['id']);
				$_SESSION['address']	=stripslashes($row['address']);
				$_SESSION['contactno']	=stripslashes($row['contactno']);
				$_SESSION['emailadd']	=stripslashes($row['emailadd']);
				$_SESSION['fname']		=stripslashes($row['fname']);
				$_SESSION['id']			=stripslashes($row['id']);
				$_SESSION['lname']		=stripslashes($row['lname']);
				$_SESSION['mname']		=stripslashes($row['mname']);
				$_SESSION['password']	=stripslashes($row['password']);
				$_SESSION['status']		=stripslashes($row['status']);	
				$_SESSION['username']	=stripslashes($row['username']);
				$_SESSION['usertype']	=stripslashes($row['usertype']);

				$_SESSION['wholename']		= 	trim($_SESSION['lname']) . ', '.trim($_SESSION['fname']). ' '.trim($_SESSION['mname']);	
				$vfound = true;
				++$i; 
		}
		
	}
	if($i>0) {
		$vfound = true;
		SaveLog($vuid.'/'.$_SESSION['wholename'],"Good Login");
	}
return $vfound;
} // END OF chkuserlogin

///////////////////start of pagination//////////////////////////////////////////////////////////////////////
function mypagination($tblnames,$filter,$targetphp){
	//$lastmenu = $_SESSION['vMnu'];
	include('./controllers/connection.php');					// include your code to connect to DB.
	$adjacents = 5; 											// How many adjacent pages should be shown on each side?
	$total_pages = 0;
	$query = "SELECT COUNT(*) as num FROM $tblnames " . $filter ;
	//die ($query);
	$UserResult	= mysqli_query($con,$query);
	$UserNum	= mysqli_num_rows($UserResult);
	mysqli_close($con); 									//close the connection from database;
	if(mysqli_num_rows($UserResult)){
		$i=0;
		while($row = mysqli_fetch_array($UserResult)){
			$total_pages = stripslashes($row["num"]);
			
		}
	}
	/* Setup vars for query. */
	$targetpage = $targetphp; 						//your file name  (the name of this file) - if left blank this directs to the same file(php)
	$limit = 20;
	/*
	if(isset($_REQUEST['limit'])){					//set this as form object 
		$limit = $_REQUEST['limit'];
	}else {
		$limit = $_SESSION['limit'];	
	}
	
	if(!$limit>0) $limit = 5; 
	*/
	
	if(!isset($_SESSION['limit'])) {			
		$_SESSION['limit'] =$limit;
	}

	$_SESSION['limit'] = $limit; 			//how many items to show per page
	
	if(isset($_GET['page'])){
		$page = $_GET['page'];
	}else {
		$page = 1;
	}
	
	if($page) 
		$start = ($page - 1) * $limit; 		//first item to display on this page
	else
		$start = 0;							//if no page var is given, set start to 0
	$_SESSION['start']=$start;
	/* Setup page vars for display. */
	if ($page == 0) $page = 1;				//if no page var is given, default to 1.
	$prev = $page - 1;						//previous page is page - 1
	$next = $page + 1;						//next page is page + 1
	$lastpage = ceil($total_pages/$limit);	//lastpage is = total pages / items per page, rounded up.
	$lpm1 = $lastpage - 1;					//last page minus 1
	$pagination = "";
	
	if($lastpage >= 1)
	{	
		$pagination .= "<div class=\"pagination\">";
		//previous button
		if ($page > 1) 
			$pagination.= "[<a href=\"$targetpage?page=$prev\">previous</a>]";
		else
			$pagination.= "[<span class=\"disabled\">previous</span>]";	
		//pages	
		if ($lastpage < 7 + ($adjacents * 2))	//not enough pages to bother breaking it up
		{	
			for ($counter = 1; $counter <= $lastpage; $counter++)
			{
				if ($counter == $page)
					$pagination.= "<span class=\"current\"> ($counter) </span>";
				else
					$pagination.= " <a href=\"$targetpage?page=$counter\"> $counter </a> ";					
			}
		}
		elseif($lastpage > 5 + ($adjacents * 2))	//enough pages to hide some
		{
			//close to beginning; only hide later pages
			if($page < 1 + ($adjacents * 2))		
			{
				for ($counter = 1; $counter < 4 + ($adjacents * 2); $counter++)
				{
					if ($counter == $page)
						$pagination.= "<span class=\"current\"> ($counter) </span>";
					else
						$pagination.= " <a href=\"$targetpage?page=$counter\">$counter</a> ";					
				}
				$pagination.= "...";
				$pagination.= "<a href=\"$targetpage?page=$lpm1\"> $lpm1 </a>";
				$pagination.= "<a href=\"$targetpage?page=$lastpage\"> $lastpage </a>";		
			}
			//in middle; hide some front and some back
			elseif($lastpage - ($adjacents * 2) > $page && $page > ($adjacents * 2))
			{
				$pagination.= "<a href=\"$targetpage?page=1\">1</a>";
				$pagination.= "<a href=\"$targetpage?page=2\">2</a>";
				$pagination.= "...";
				for ($counter = $page - $adjacents; $counter <= $page + $adjacents; $counter++)
				{
					if ($counter == $page)
						$pagination.= "<span class=\"current\">($counter)</span>";
					else
						$pagination.= " <a href=\"$targetpage?page=$counter\">$counter</a> ";					
				}
				$pagination.= "...";
				$pagination.= "<a href=\"$targetpage?page=$lpm1\"> $lpm1 </a>";
				$pagination.= "<a href=\"$targetpage?page=$lastpage\"> $lastpage </a>";		
			}
			//close to end; only hide early pages
			else
			{
				$pagination.= "<a href=\"$targetpage?page=1\">1</a>";
				$pagination.= "<a href=\"$targetpage?page=2\">2</a>";
				$pagination.= "...";
				for ($counter = $lastpage - (2 + ($adjacents * 2)); $counter <= $lastpage; $counter++)
				{
					if ($counter == $page)
						$pagination.= "<span class=\"current\"> ($counter) </span>";
					else
						$pagination.= "<a href=\"$targetpage?page=$counter\"> $counter </a>";					
				}
			}
		}
		//next button
		if ($page < $counter - 1) 
			$pagination.= "&nbsp;[<a href=\"$targetpage?page=$next\">next</a>]";
		else
			$pagination.= "&nbsp;<span class=\"disabled\">[next]</span>";
		$pagination.= "&nbsp;<!-- <a href='?opt=9'>Add New</a> --></div>\n";		
	}
return $pagination;
}
/////////////////////end of pagination////////////////////////////////////////////////////////////////////

function SaveLog($fullname,$logdesc){
	include('./controllers/connection.php');

	$connection1 	= mysqli_connect("$host" , "$username" , "$password", $db_name) 
			  or die ("Can't connect to MySQL <meta http-equiv='refresh' content='10; URL=index.php?mnu=11111'>");
	$tb='userlogs';
    $sqlcmd = "insert into " . $tb . " (loguserid, logdate, logdesc) values ('". $fullname ."',now(),'" .$logdesc."');";
	
    $results = mysqli_query($connection1, $sqlcmd) or die ("Could not execute query : $sqlcmd . " . mysqli_error());
    mysqli_close($connection1);	
    if ($results)
    {
        //echo "Saved user's Search log.... <br/>";
    }

    return 0;	
} 

function siteRedirectWithAlert($alert, $pageUrl){
    echo("<script LANGUAGE='javascript'>alert('". $alert ."');</script>"); 
	if (strlen(trim($pageUrl))) {
    	echo("<script LANGUAGE='javascript'>window.location.replace(\"". $pageUrl ."\");</script>");
	}
}

function siteRedirect($pageUrl){
    echo("<script LANGUAGE='javascript'>window.location.replace(\"". $pageUrl ."\");</script>");
}

function DisplayAlert($alert){
    echo("<script LANGUAGE='javascript'>alert('". $alert ."');</script>"); 
}

function ExecuteNoneQuery($vSQLcmd){
	$feedback = false;
	include('./controllers/connection.php');
	$con1 = mysqli_connect($host,$username,$password,$db_name) or die ("cannot connect to server");
	$results = mysqli_query($con1, $vSQLcmd) or die ("</br></br></br>[UDF module] Could not execute query :</br> $vSQLcmd . " . mysqli_error());
    if ($results){
		mysqli_close($con1);
		//DisplayAlert("Database update success...");
		$feedback = true;
    }else{
		//DisplayAlert("Database Update Failed...");		
		$feedback = false;
	}
	//echo $vSQLcmd;
    return $feedback;
}

function getfieldvalue($table, $fieldname, $condition){
	$retvalue = "";
	$host="localhost"; //hostname
	$username="root";//username
	$password=""; //database password
	$db_name="excelcia";//database name

	//connect to database
	$con1 = mysqli_connect($host,$username,$password,$db_name) or die ("cannot connect to server");
	
	if(!$con1) {
		echo "connection error";
	}
	$UserQuery = "SELECT $fieldname FROM $table $condition;";
	
	// die ($UserQuery);
	// echo $UserQuery;

	$UserResult = mysqli_query($con1,$UserQuery);
	$UserNum = mysqli_num_rows($UserResult);
	
	mysqli_close($con1);
	if(mysqli_num_rows($UserResult)){
		$i=0;
		while($row = mysqli_fetch_array($UserResult)){
			$retvalue = stripslashes($row[$fieldname]);
		}
	}
	mysqli_free_result($UserResult);	
	return $retvalue;
}

?>	