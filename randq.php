<?PHP
   session_start();
   include_once("udf/udf.php");
   if(strlen(trim($_SESSION['usertype']))<1 ){
       siteRedirectWithAlert("You Must Login first!","login.php");
   }
   $usertype = strtolower($_SESSION['usertype']);
   $fname  = strtoupper($_SESSION['fname']);


	// open configuration file of teacher and load data to deter how many items to generate
	// getfieldvalue($table, $fieldname, $condition)

	// we need to set values for the $topicID, $studentID, $level(this is the day or week sub topic) and $testtype 
	// (this should be determine from the user choosen topic and test time) --> use session or coookie variable here!
	$topicID = "1";
	$testtype = "pre-test";
	$studentID = "1";
	$level = "1";

	//the testsessionid
	$testsessionid = $topicID.'-'.$testtype.'-'.$studentID;

	// we need php session variable for the $topicID, $testtype, $studentID  

	$itemseasy = getfieldvalue("topic_config", "itemseasy", "where topicid = '$topicID' and testtype = '$testtype'");
echo $itemseasy;
	$itemsmoderate = getfieldvalue("topic_config", "itemsmoderate", "where topicid = '$topicID' and testtype = '$testtype'");
echo $itemsmoderate;
	$itemsdifficult = getfieldvalue("topic_config", "itemsdifficult", "where topicid = '$topicID' and testtype = '$testtype'");
echo $itemsdifficult;
	//now after we got the above information then, its time to random select questions from our examquestion bank

	//generate unique test-session-id
	//use studentID(11) + test-type(10) + topicID(11)  
	// example 1-pre-test-1

	// #1 prior to generate test questionaire... our system should check if the exam history 
	//    does not exist then continue generating questions
	// #2 generate question using the topic_configuration to select how many question per topic, per level, per difficulty and save to buffer and display buffered question to student screen (display duration should be depending on total time; that is calculating total number of minutes to spend answering, and be able to auto submit data-form)
	// #3 dissallow student to have retake by means of checking if test-session-id exist from history

	if(strlen(getfieldvalue("testhistory", "testsessionid", "where testsessionid = '$testsessionid'"))<1){
		//generate question since the student does not yet taken this type of test-type
		//get the $topicID, $testtype, $studentID from php session variable
		
		 $sqleasy = "
		insert into testbuffer 
			(testsessionid,datetimecreated,testtype,topicid,subjid,level,question,a,b,c,d,
		    a_rational,b_rational,c_rational,d_rational,correct_ans,minutes,point,type)
			SELECT '$testsessionid',now(),'$testtype',topicid, subjid, level, question, a, b, c, d,
					a_rational, b_rational, c_rational, d_rational, correct_ans, minutes, point, type 
			FROM examquestion 
			where rand()*4 and topicid='$topicID' and level = '$level' and type ='easy' 
			order by md5(concat(id,current_timestamp)) limit $itemseasy;";
		
		 $sqlmoderate = "
		insert into testbuffer 
			(testsessionid,datetimecreated,testtype,topicid,subjid,level,question,a,b,c,d,
		    a_rational,b_rational,c_rational,d_rational,correct_ans,minutes,point,type)
			SELECT '$testsessionid',now(),'$testtype',topicid, subjid, level, question, a, b, c, d,
					a_rational, b_rational, c_rational, d_rational, correct_ans, minutes, point, type 
			FROM examquestion 
			where rand()*4 and topicid='$topicID' and level = '$level' and type ='moderate' 
			order by md5(concat(id,current_timestamp)) limit $itemsmoderate;";
		 
		 $sqldifficult = "
		insert into testbuffer 
			(testsessionid,datetimecreated,testtype,topicid,subjid,level,question,a,b,c,d,
		    a_rational,b_rational,c_rational,d_rational,correct_ans,minutes,point,type)
			SELECT '$testsessionid',now(),'$testtype',topicid, subjid, level, question, a, b, c, d,
					a_rational, b_rational, c_rational, d_rational, correct_ans, minutes, point, type 
			FROM examquestion 
			where rand()*4 and topicid='$topicID' and level = '$level' and type ='difficult' 
			order by md5(concat(id,current_timestamp)) limit $itemsdifficult;";	 
		
	// below is the actual execution of script which populate the testbuffer table	
		ExecuteNoneQuery($sqleasy);
		ExecuteNoneQuery($sqlmoderate);
		ExecuteNoneQuery($sqldifficult);
	// end of script to populate testbuffer

	//display the generated testbuffer question where testsessionid is = php session variable
	// start of php script to display all questions in a form window	

	// ..........
	// ..........
	// ..........

	//	end of php script that display all question

	// form action script should do;
	//	-checking of submitted answers
	//  -populate history table for this testsessionid
	//  -populate summary table to have record of exam-test details for this testsessionid	
	//  -erase the records from buffer table containing this testsessionid that is submitted to history table
	//  -redirect student screen to topic list to allow them continue with their task

	}else siteRedirectWithAlert("you already taken this type of test", "index.php");
 
?>