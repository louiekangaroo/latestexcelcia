<?php
	session_start();
	include_once("controllers/udf.php");
	include_once("menuinterface.php");
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
/*			
			//$pagination = mypagination($tbnames,$filter,$targetphp);	// set the pagination control			
			$vResponse = '0';
			require("controllers/connection.php");
			if(isset($_SESSION['start']) && isset($_SESSION['limit'])) {
				$start = $_SESSION['start'];
				$limit = $_SESSION['limit'];
			}else{
				$start = 1;
				$limit = 15;   // limit number of records per page 	also need to set this value on pagination function			
			}	
*/
// end of pagination
			$start = 0;
			$limit = 0;
			$sql = "SELECT  *
                    FROM examquestion e 
                    order by topicid LIMIT $start, $limit ;"; 
            // display only s.topicid, s.studyname,e.question,e.minutes,e.point,e.level,etype


			$sql = "SELECT  *
                    FROM examquestion e $filter
                    order by topicid"; 
			
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
				  $bgcolor = ""; 	

/*
				  $bgcolor = "#3399FF";
				  if($ctr%2){
					  $bgcolor = "#CCFFFF";
				  }
*/
				  $isparent = ""; //$row['isparent'];
				  $parentid = ""; //$row['parentid'];
				  $subjid = ""; //$row['subjid'];
				  $question = $row['question'];
				  $minutes = $row['minutes'];
				  $point = $row['point'];
				  $level = $row['level'];
				  $type = $row['type'];
				  $id = $row['id'];
				  $details .= "<tr bgcolor='$bgcolor'>
									<td>$studyname</td>
									<td>$question</td>
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
              echo 'No Items';// Some message, if the database is empty.
            }
            mysqli_free_result($result);// Clear the memory.
            ?>
<!-- end of detail line codes below -->
<!-- start html code to display the above detail -->
	<form id="form_1136888" class="appnitro"  method="POST" action="#">
	  <label for="usersfilter"></label>
	  		<div align="left">
	  		  
 <!--	  		  Filter :
  <input name="usersfilter" type="text" id="usersfilter" size="80%" maxlength="100" /> 
  <br />
	  		  <input type="submit" name="button3" id="button3" value="Save" />
	  		  <br />
	  		  <?PHP // echo $pagination; ?>
 --> 
	  </div>
  		<table width='95%' border='1' cellpadding='3' cellspacing='3'>
        <tr><td colspan="6">    
            <div align="right">
              <?PHP //echo $pagination; ?>
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
            <div align="right">
              <?PHP // echo $pagination; ?>
              <!-- <input type="submit" name="button2" id="button2" value="Save Changes" /> -->
              <a href="##" onclick="window.print()">Print Now</a>
              <a href="##" onClick="window.close()">Close This</a>
            </div>
		</td></tr>
        </table>
     </form>
<!-- end html code to display the above detail -->

<?php
include_once('ECfooter.php');
?>