<?PHP
include_once('ECheader.php');
/*
if(!(trim($usertype)=="admin" || trim($usertype)=="teacher")){
  siteRedirectWithAlert("Sorry you are not allowed to use this module! ".$usertype,"index.php");

}
*/
?>
<!-- start of detail header line --> 
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">Grade Performance Report</h1>
            <hr class="thin bg-grayLighter">
<!-- end of detail header line --> 
<!-- start of detail line codes below -->
<?PHP
/* to display performance analysis for the current student user (currently logged in)
// use the session (studentID) variable to search the testhistory table (testsessionid = SessionStudentID)
//
// open studyunits and display one record at a time (where testsessionid = SessionStudentID)
//      search record (if any) at the testhistory and process the grade to display performance per testtype (1 - 5) 
//		
deter if current active user is student or teacher/admin
if student then 
	-assign the $_SESSION['studentID'] to search / display performance analysis
	$studentID = $_SESSION['studentID']

if teacher/admin then
	-display / prompt user to keyin value for $studentID

SELECT  t.topicid,t.subjid,s.studyname, 
		t.testtype,correct_ans,ansreceived,
		sum(correct_ans=ansreceived) 'c',sum(point)-sum(correct_ans=ansreceived) 'in' ,sum(correct_ans=ansreceived)/sum(point)*50+50 'grade'
FROM testhistory t, studyunits s
where t.subjid=s.id and t.testsessionid = '$studentID'  and t.testtype='0' -- change this testtype dynamic to process all columns
group by t.testsessionid,t.topicid,t.subjid;

*/
$studentID = '';
// deter the user type
if(trim($usertype)=="admin" || trim($usertype)=="teacher"){
  //display a form to require user the studentID to view grade report
  //(we must provide student masterlist)
  
  // make sure that the user had input a valid studentID
  // else prompt him for re input
  // redirect to index/mainpage
}else {  // the current user is a student
	$studentID = $_SESSION['studentID'];
}

//open studyunits and form the sql statement to populate user display




////////////////////////////////////////////////////////////////////
$details = "";
// Create connection
require("controllers/connection.php");
global $con;
if (!$con) {
	die("Connection failed: " . mysqli_connect_error());
}
$sql = "SELECT * FROM studyunits; -- order by topicid, studyname;"; 

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
		$isparent = $row['isparent'];
		$subjid = $row['id'];
		if($isparent){
			$maintopic = $row['studyname'];			
			$subtopic = '';
		}else{
			$maintopic = '';			
			$subtopic = $row['studyname'];		
		}
		//$studyname = trim(getfieldvalue(" studyunits ", "studyname", " where topicid='$topicid' and isparent='1'"));
		
		/*
		SELECT  -- t.topicid,t.subjid,s.studyname,
				-- t.testtype,correct_ans,ansreceived,
				sum(correct_ans=ansreceived) 'c',
				sum(point)-sum(correct_ans=ansreceived) 'in', 		
				round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) 'grade'
		FROM testhistory t, studyunits s
		where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='0' 
		group by t.testsessionid,t.topicid,t.subjid;
		*/

		// get data for PRE-TEST
		$testtype = 1; // 0-study/review only | 1 - pre-test | 2 - post-test 3..... 5-major exam  
		$PreTestC = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(correct_ans=ansreceived) IS NULL, ' ',sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	   $PreTestIN = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(point)-sum(correct_ans=ansreceived) IS NULL, ' ',sum(point)-sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	 $PreTestGrade = trim(getfieldvalue(" testhistory t, studyunits s ", "if(round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) IS NULL, ' ',round(sum(correct_ans=ansreceived)/sum(point)*50+50,2))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'")); 

		// get data for POST-TEST
		$testtype = 2; // 0-study/review only | 1 - pre-test | 2 - post-test 3..... 5-major exam  
		$PostTestC = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(correct_ans=ansreceived) IS NULL, ' ',sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	   $PostTestIN = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(point)-sum(correct_ans=ansreceived) IS NULL, ' ',sum(point)-sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	 $PostTestGrade = trim(getfieldvalue(" testhistory t, studyunits s ", "if(round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) IS NULL, ' ',round(sum(correct_ans=ansreceived)/sum(point)*50+50,2))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'")); 

		// get data for SHORT-QUIZ
		$testtype = 3; // 0-study/review only | 1 - pre-test | 2 - post-test 3..... 5-major exam  		
		$ShortQuizC = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(correct_ans=ansreceived) IS NULL, ' ',sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	   $ShortQuizIN = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(point)-sum(correct_ans=ansreceived) IS NULL, ' ',sum(point)-sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	 $ShortQuizGrade = trim(getfieldvalue(" testhistory t, studyunits s ", "if(round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) IS NULL, ' ',round(sum(correct_ans=ansreceived)/sum(point)*50+50,2))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'")); 
	 
		// get data for LONG-QUIZ
		$testtype = 4; // 0-study/review only | 1 - pre-test | 2 - post-test 3..... 5-major exam  		
		$LongQuizC = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(correct_ans=ansreceived) IS NULL, ' ',sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	   $LongQuizIN = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(point)-sum(correct_ans=ansreceived) IS NULL, ' ',sum(point)-sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	 $LongQuizGrade = trim(getfieldvalue(" testhistory t, studyunits s ", "if(round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) IS NULL, ' ',round(sum(correct_ans=ansreceived)/sum(point)*50+50,2))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'")); 


		// get data for MAJOR-EXAM
		$testtype = 5; // 0-study/review only | 1 - pre-test | 2 - post-test 3..... 5-major exam  		
		$MajorC = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(correct_ans=ansreceived) IS NULL, ' ',sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	   $MajorIN = trim(getfieldvalue(" testhistory t, studyunits s ", "if(sum(point)-sum(correct_ans=ansreceived) IS NULL, ' ',sum(point)-sum(correct_ans=ansreceived))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'"));
	 $MajorGrade = trim(getfieldvalue(" testhistory t, studyunits s ", "if(round(sum(correct_ans=ansreceived)/sum(point)*50+50,2) IS NULL, ' ',round(sum(correct_ans=ansreceived)/sum(point)*50+50,2))", " where t.subjid=s.id and t.testsessionid = '$studentID' and subjid = '$subjid' and t.testtype='$testtype'")); 
	 
		$bgcolor = "#3399FF";
		if($ctr%2){
			$bgcolor = "#CCFFFF";
		}
		$details .= "<tr bgcolor='$bgcolor'>
						<td>$maintopic</td>
						<td>$subtopic</td>
						<td>$PreTestC</td> <!-- C -->
						<td>$PreTestIN</td> <!-- IN -->
						<td>$PreTestGrade</td> <!-- Grade -->
						<!-- post test -->
						<td>$PostTestC</td> <!-- C -->
						<td>$PostTestIN</td> <!-- IN -->
						<td>$PostTestGrade</td> <!-- Grade -->
						<!-- short quiz -->
						<td>$ShortQuizC</td> <!-- C -->
						<td>$ShortQuizIN</td> <!-- IN -->
						<td>$ShortQuizGrade</td> <!-- Grade -->
						<!-- long quiz -->
						<td>$LongQuizC</td> <!-- C -->
						<td>$LongQuizIN</td> <!-- IN-->
						<td>$LongQuizGrade</td> <!-- Grade -->
						<!-- major exam -->
						<td>$MajorC</td> <!-- C -->
						<td>$MajorIN</td> <!-- IN -->
						<td>$MajorGrade</td> <!-- Grade -->
					  </tr>
		";
	} // end for
}
else {
$details =  "<tr bgcolor='$bgcolor'>
<td colspan='17'>No Items</td>
</tr>";// Some message, if the database is empty.
}
mysqli_free_result($result);// Clear the memory.
////////////////////////////////////////////////////////////////////




$vsql ="SELECT  t.topicid,t.subjid,s.studyname, 
				t.testtype,correct_ans,ansreceived,
				sum(correct_ans=ansreceived) 'c',sum(point)-sum(correct_ans=ansreceived) 'in' ,sum(correct_ans=ansreceived)/sum(point)*50+50 'grade'
		FROM testhistory t, studyunits s
		where t.subjid=s.id and t.testsessionid = '$studentID'  and t.testtype='0' -- change this testtype dynamic to process all columns
		group by t.testsessionid,t.topicid,t.subjid;
		";

//die ($vsql);
	
?>
    <table width='120%' border='1'>
      <tr>
        <td width='20%'>&nbsp;</td>
        <td width='40%'>&nbsp;</td>
        <td colspan='3'><div align='center'>Pre-Test</div></td>
        <td colspan='3'><div align='center'>Post-Test</div></td>
        <td colspan='3'><div align='center'>Short-Quiz</div></td>
        <td colspan='3'><div align='center'>Long-Quiz</div></td>
        <td colspan='3'><div align='center'>Major Exam</div></td>
      </tr>
      <tr>
        <td width='20%'>Topics</td>
        <td width='40%'>Sub Topics</td>
        <td width='2%'><div align='center'>C</div></td>
        <td width='2%'><div align='center'>IN</div></td>
        <td width='4%'><div align='center'>Grade</div></td>
        <td width='2%'><div align='center'>C</div></td>
        <td width='2%'><div align='center'>IN</div></td>
        <td width='4%'><div align='center'>Grade</div></td>
        <td width='2%'><div align='center'>C</div></td>
        <td width='2%'><div align='center'>IN</div></td>
        <td width='4%'><div align='center'>Grade</div></td>
        <td width='2%'><div align='center'>C</div></td>
        <td width='2%'><div align='center'>IN</div></td>
        <td width='4%'><div align='center'>Grade</div></td>
        <td width='2%'><div align='center'>C</div></td>
        <td width='2%'><div align='center'>IN</div></td>
        <td width='4%'><div align='center'>Grade</div></td>
      </tr>
      <?PHP echo $details; ?>
    </table>
<!-- end of detail line codes below -->
<!-- start html code to display the above detail -->

<!-- end html code to display the above detail -->
<?PHP 
include_once('ECfooter.php');
?>