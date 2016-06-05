<?php
include_once('ECheader.php');
if(!(trim($usertype)=="admin" || trim($usertype)=="teacher")){
  siteRedirectWithAlert("Sorry you are not allowed to use this module! ".$usertype,"index.php");
}
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
			$filter = "  ";

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
/*			$sql = "SELECT
                      s.topicid,s.studyname,s.isparent,s.parentid,e.subjid,
                      e.question,e.minutes,e.point,e.level,e.type 
                    FROM studyunits s,examquestion e 
                    where s.topicid=e.topicid LIMIT $start, $limit;"; 
*/          // s.topicid,s.studyname,s.isparent,s.parentid,  
			// e.topicid,e.subjid,e.question,e.minutes,e.point,e.level,e.type
			$sql = "SELECT  *
                    FROM examquestion e 
                    order by topicid LIMIT $start, $limit ;"; 
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
				  $details .= "<tr bgcolor='$bgcolor'>
									<td>$studyname</td>
									<td>$question</td>
									<td>$minutes</td>
									<td>$point</td>
									<td>$level</td>
									<td> <!-- $type --> 
									<input name='txttype' type='text' id='txttype' value='6' size='3' maxlength='1' />
									</td>
							    </tr>";	
              }
            }
            else {
              echo 'No Items';// Some message, if the database is empty.
            }
            mysqli_free_result($result);// Clear the memory.
            ?>
<!-- end of detail line codes below -->
<!-- start html code to display the above detail -->
	<form id="form_1136888" class="appnitro"  method="post" action="#">
	  <label for="usersfilter"></label>
	  		<div align="center">Filter :
  <input name="usersfilter" type="text" id="usersfilter" size="80%" maxlength="100" />
	  		  <input type="submit" name="button" id="button" value="Submit" />
	  		  <br />
	  		  <?PHP echo $pagination; ?>
	  </div>
  		<table width='100%' border='1'>
          <tr>
            <th width='16%' scope='col'>TopicID &amp; <br /> Study Name</th>
            <th width='76%' scope='col'>Question</th>
            <th width='3%' scope='col'>Time</th>
            <th width='4%' scope='col'>Point(s)</th>
            <th width='2%' scope='col'>Lvl</th>
            <th width='2%' scope='col'>Type</th>
          </tr>
        	<?PHP echo $details ?>
        </table>
      	<?PHP echo $pagination; ?>
     </form>
<!-- 
    <form id="form1" name="form1" method="post" action="">
      <label for="txttype"></label>
      <input name="txttype" type="text" id="txttype" value="6" size="3" maxlength="1" />
    </form>
-->
<!-- end html code to display the above detail -->

<?php
include_once('ECfooter.php');
?>