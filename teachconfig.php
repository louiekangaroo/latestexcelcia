<?php
include_once('ECheader.php');
if(!(trim($usertype)=="admin" || trim($usertype)=="teacher")){
  siteRedirectWithAlert("Sorry you are not allowed to use this module! ".$usertype,"index.php");
}
// start of save user submitted data to table
if(isset($_POST["txttype"])){
    $capture_field_vals ="";

	//id processing
	$ctr = 0;
	$recID = implode(",", $_POST['id']);
	$elementID = 0;
	foreach (explode(',',$recID) as $value){
		$ArrayDataID[$ctr] = "\"".trim($value)."\"";
		$ctr++;
	}
	//end id processing
	//minutes processing
	$ctr = 0;
	$txtminutes = implode(",", $_POST['txtminutes']);
	$elementID = 0;
	foreach (explode(',',$txtminutes) as $value){
		$Arrayminutes[$ctr] = "\"".trim($value)."\"";
		$ctr++;
	}
	//end minutes processing
	//point processing
	$ctr = 0;
	$txtpoint = implode(",", $_POST['txtpoint']);
	$elementID = 0;
	foreach (explode(',',$txtpoint) as $value){
		$Arraypoint[$ctr] = "\"".trim($value)."\"";
		$ctr++;
	}	
	//end point processing
	//level processing
	$ctr = 0;
	$txtlevel = implode(",", $_POST['txtlevel']);
	$elementID = 0;
	foreach (explode(',',$txtlevel) as $value){
		$Arraylevel[$ctr] = "\"".trim($value)."\"";
		$ctr++;
	}	
	//end level processing
	$ctr = 0;
	$sql = "";
	$errCtr=0;
	foreach($_POST["txttype"] as $key => $text_field){
		//echo "txttype : $text_field ID : " ; // textfield is the txttype
		//echo $ArrayDataID[$ctr];     // this is the record ID
		//echo " </br>";
		$updatetype = $text_field;
		$updateid = $ArrayDataID[$ctr];
		$updateminutes = $Arrayminutes[$ctr];
		$updatepoint = $Arraypoint[$ctr];
		$updatelevel = $Arraylevel[$ctr];
		//txtminutes txtpoint txtlevel
		$sql = "update examquestion set type = '$updatetype', minutes=$updateminutes, point=$updatepoint, level=$updatelevel where id=$updateid; ";
		if(!ExecuteNoneQuery($sql)){
			$errCtr++;
			die("Database update error --> update examquestion table (user set type)...");
		}else{
			//DisplayAlert("Updating of Exam Selection completed");	
		}
		$ctr++;
    }
	if($errCtr==0){
		//DisplayAlert("Updating of Exam Selection completed!!!!");	
	}else {
		DisplayAlert("WARNING!!!! - FAILED to Save Changes!!!!");			
	}
}
// end of saving user submitted data to table
?>
<!-- start of detail header line --> 
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">List of Questions by topics</h1>
            <hr class="thin bg-grayLighter">
<!-- end of detail header line --> 
<!-- start of detail line codes below -->
            <?php
            $details = "";
            // Create connection
            require("controllers/connection.php");
            global $con;
            if (!$con) {
                die("Connection failed: " . mysqli_connect_error());
            }
//start of pagination
/*
			$tbnames =" studyunits s,examquestion e ";
			$filter = " where s.topicid=e.topicid; ";
*/
			$tbnames =" examquestion e ";
			$filter = "";
			$usersfilter = $filter;
			if(isset($_REQUEST['usersfilter'])){
				$usersfilter = $_REQUEST['usersfilter'];
				$_SESSION['sessionfilter'] = $usersfilter;
				$usersfilter = $_SESSION['sessionfilter'];
			}else{
				if(isset($_SESSION['sessionfilter'])){
					$usersfilter = $_SESSION['sessionfilter'];		
				}
			}
			if(isset($_SESSION['sessionfilter'])){
				$filter = " where concat(topicid,subjid,level,question,minutes,point,type) like '$usersfilter%' ";
				$filter .= " or concat(topicid,subjid,level,question,minutes,point,type) like '%$usersfilter%' ";	
			}
			$targetphp = "teachconfig.php";
			$pagination = mypagination($tbnames,$filter,$targetphp);	// set the pagination control			
			$vResponse = '0';
			require("controllers/connection.php");
			if(isset($_SESSION['start']) && isset($_SESSION['limit'])) {
				$start = $_SESSION['start'];
				$limit = $_SESSION['limit'];
			}else{
				$start = 1;
				$limit = 15;   // limit number of records per page 	also need to set this value on pagination function			
			}
			
// end of pagination
			$sql = "SELECT  *
                    FROM examquestion e $filter
                    order by topicid LIMIT $start, $limit ;"; 
					
			//die ($sql.' - using filter - '.$filter );
					
            // display only s.topicid, s.studyname,e.question,e.minutes,e.point,e.level,etype
			
			//die($sql);
			
            $result = mysqli_query($con, $sql);
            if ($result) {
              //variable to contain concatenated detail information for html output
              $details = "";
              $ctr=0;
			  $tmpstudyname = "";
			  $ctr = 0;
              foreach ($result as $row) {
				  $ctr++;
				  $topicid = $row['topicid'];
				  $studyname = trim(getfieldvalue(" studyunits ", "studyname", " where topicid='$topicid'  and isparent='1'"));
				  if(strlen($studyname)<1){
				  	$studyname = "<font color='red'> Error in Studyname </font>";
				  }
				  /*
				  if(!($tmpstudyname == $row['studyname'])) {
				  	$tmpstudyname = $row['studyname'];
					$showstudyname = $row['studyname'];
					$topicid = "(". $row['topicid'] .")-";
				  }else {
					$showstudyname = "";
					$topicid = "";  
				  };
				  */
				  $bgcolor = "#3399FF";
				  if($ctr%2){
					  $bgcolor = "#CCFFFF";
				  }
				  // s.topicid,s.studyname,s.isparent,s.parentid,  
				  //$studyname = ""; //$showstudyname;
				  $isparent = ""; //$row['isparent'];
				  $parentid = ""; //$row['parentid'];
				  $subjid = ""; //$row['subjid'];
				  $question = $row['question'];
				  $minutes = $row['minutes'];
				  $point = $row['point'];
				  $level = $row['level'];
				  $type = $row['type'];
				  $id = $row['id'];
				  //'1 pre-test\n 2 post-test\n 3 short quiz\n 4 long quiz\n 5 major exam\n 6 All'
				  $details .= "<tr bgcolor='$bgcolor'>
									<td>$studyname</td>
									<td>$question<div align='right'><a href='#'>EDIT/SHOW ANSWER</a></div></td>
									<td align='center'>
										<input name='txtminutes[]' type='text' id='txtminutes' value='$minutes' size='2' width='2' maxlength='2' required />
									</td>
									<td align='center'>
										<input name='txtpoint[]' type='text' id='txtpoint' value='$point' size='2' width='2' maxlength='2' required />
									</td>
									<td align='center'>
										<input name='txtlevel[]' type='text' id='txtlevel' value='$level' size='2' width='2' maxlength='2' required />
									</td>
									<td align='center'> 
										<input type='hidden' name='id[]' id='id' value=' $id ' />
										<input name='txttype[]' type='text' id='txttype' value='$type' size='2' width='2' maxlength='1' required />
									</td>
							    </tr>";	
              }
            }
            else {
              $details =  "<tr bgcolor='$bgcolor'>
			  				<td colspan='6'>No Items</td>
						   </tr>";// Some message, if the database is empty.
            }
            mysqli_free_result($result);// Clear the memory.
            ?>
<!-- end of detail line codes below -->
<!-- start html code to display the above detail -->
	<form id="form_1136888" class="appnitro"  method="POST" action="#">
  		<table width='100%' border='1' cellpadding='3' cellspacing='3'>
        <tr><td colspan="6">    
            <div align="center">
	  		  Filter :
  <input name="usersfilter" type="text" id="usersfilter" size="80%" maxlength="100" value ='<?PHP echo $usersfilter; ?>' />BLANK for ALL
	  		  <!-- <input type="submit" name="button3" id="button3" value="Save" /> -->
              <?PHP echo $pagination; ?>
            </div>
		</td></tr>
          <tr>
            <th width='16%' scope='col'>TopicID &amp; <br /> Study Name</th>
            <th width='76%' scope='col'>Question</th>
            <th width='3%' scope='col'>Time</th>
            <th width='4%' scope='col'>Point(s)</th>
            <th width='2%' scope='col'>Lvl</th>
            <th width='2%' scope='col'>Type</th>
          </tr>
        	<?PHP echo $details ?>
        <tr><td colspan="6">    
            <div align="center">
              <?PHP echo $pagination; ?>
              <input type="submit" name="button2" id="button2" value="Save Changes" />
              <!-- <a href="##" onclick="window.print()">Printer Friendly</a> -->
              <a href="printteachconfig.php" target="printthis">Printer Friendly</a>
            </div>
		</td></tr>
        </table>
     </form>
<!-- end html code to display the above detail -->

<?php
include_once('ECfooter.php');
?>