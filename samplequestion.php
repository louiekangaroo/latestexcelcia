<?php

   include_once("udf/udf.php");

	$topicID = "1";
	$testtype = "pre-test";
	$studentID = "1";
	$level = "1";

	//the testsessionid
	$testsessionid = $topicID.'-'.$testtype.'-'.$studentID;

	// we need php session variable for the $topicID, $testtype, $studentID  

	$itemseasy = getfieldvalue("topic_config", "itemseasy", "where topicid = '$topicID' and testtype = '$testtype'");
    //echo $itemseasy;
	$itemsmoderate = getfieldvalue("topic_config", "itemsmoderate", "where topicid = '$topicID' and testtype = '$testtype'");
    //echo $itemsmoderate;
	$itemsdifficult = getfieldvalue("topic_config", "itemsdifficult", "where topicid = '$topicID' and testtype = '$testtype'");
    //echo $itemsdifficult;

    $sqlscript = "call generateQuestions(1,1,'2,3','$testtype',$itemseasy,$itemsmoderate,$itemsdifficult)";
    ExecuteNoneQuery($sqlscript);

?>



<?php

require('./controllers/connection.php');
global $con;
 session_start();
    if(!isset($a))
    {
        $a=0;
        //unset($_SESSION['score']);
    }
 
    if(isset($_POST['next'])) {
        $a=$_POST['a'];
 
    }
 //$sql = "select * from examquestion eq inner join studentsession ss on eq.id = ss.questionid" ;
//`generateQuestions`(IN studid INT,IN `topid` INT,IN `subid` VARCHAR(50),IN _type VARCHAR(50),IN toteasy INT,IN totmed INT,IN totdiff INT)
 $sql= "call getQuestion('".$a."',1,1,'2,3')";//"SELECT * FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid ORDER BY ss.id LIMIT 1 OFFSET $a";
 $result = $con->query($sql);

    //$sql1="SELECT * FROM questionpart2 ORDER by qid LIMIT 1 OFFSET $a";
    //$result=mysql_query($sql1);
    $num = $result->num_rows;
    echo "<form method='post' action=''>";
 
 
    if($result) {
     while ($row = mysqli_fetch_array($result))
     //while($row = $result->fetch_assoc()) 
    {
 
    $qid = $row["id"];
    $questions = $row["question"];
    $opt1 = $row["a"];
    $opt2 = $row["b"];
    $opt3 = $row["c"];
    $opt4 = $row["d"];
    $min = $row["minutes"];
    $answer = $row["correct_ans"];

    echo   "<h3>" .$questions. "</h3>";
	echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-A' value='". $opt1."' />";
    echo   "<label for='question-1-answers-A'>". $opt1. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-B' value='". $opt2."' />";
    echo   "<label for='question-1-answers-B'>". $opt2. "</label>";
    echo   "</div>";               
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-C' value='". $opt3."' />";
    echo   "<label for='question-1-answers-C'>" . $opt3. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-D' value='". $opt4."' />";
    echo   "<label for='question-1-answers-D'>" . $opt4. "</label>";
    echo   "</div>";
    echo   "</li>"; 
    echo   "</li>";
    echo   "</ol>";
    
	echo   "</div>";
    echo   "<input type='hidden' name='question_id' value''.$qid.''/>";
    echo   "<input type='hidden' name='rightanswer[' . $qid . ']' value='' . $answer . '' /> <br>";
    echo   "<input type='submit' name='next' value='next'><br><br>";
    }
 
 
    $b=$a+1;
    echo "<input type='hidden' value='$b' name='a'>";
    echo "<input type='hidden' value='count' name='count'>";
 
    echo "</form>";
    }
 ?>

<?php
  include ('./controllers/connection.php');
  global $con;
   
  $myQuery = "SELECT SUM(eq.minutes) AS MIN FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid WHERE ss.studentid = 1 AND eq.topicid = 1 AND FIND_IN_SET(eq.SUBJID, '2,3')";
 $result = $con->query($myQuery);
 $num = $result->num_rows;
  while ($row = mysqli_fetch_array($result)) {
    $setTime = $row['MIN'] * 60;
  }

$timestamp = time();
$diff = $setTime * 60; //<-Time of countdown in seconds.  ie. 3600 = 1 hr. or 86400 = 1 day.
//MODIFICATION BELOW THIS LINE IS NOT REQUIRED.
$hld_diff = $diff;
if(isset($_SESSION['ts'])) {
	$slice = ($timestamp - $_SESSION['ts']);	
	$diff = $diff - $slice;
}

if(!isset($_SESSION['ts']) || $diff > $hld_diff || $diff < 0) {
	$diff = $hld_diff;
	$_SESSION['ts'] = $timestamp;
}

//Below is demonstration of output.  Seconds could be passed to Javascript.
$diff; //$diff holds seconds less than 3600 (1 hour);

$hours = floor($diff / 3600) . ' : ';
$diff = $diff % 3600;
$minutes = floor($diff / 60) . ' : ';
$diff = $diff % 60;
$seconds = $diff;


?>

<div id="strclock">Clock Here!</div>
<script type="text/javascript">
 var hour = <?php echo floor($hours); ?>;
 var min = <?php echo floor($minutes); ?>;
 var sec = <?php echo floor($seconds); ?>

function countdown() {
 if(sec <= 0 && min > 0) {
  sec = 59;
  min -= 1;
 }
 else if(min <= 0 && sec <= 0) {
  min = 0;
  sec = 0;
 }
 else {
  sec -= 1;
 }
 
 if(min <= 0 && hour > 0) {
  min = 59;
  hour -= 1;
 }
    
 var pat = /^[0-9]{1}$/;
 sec = (pat.test(sec) == true) ? '0'+sec : sec;
 min = (pat.test(min) == true) ? '0'+min : min;
 hour = (pat.test(hour) == true) ? '0'+hour : hour;
 
 document.getElementById('strclock').innerHTML = "Total time of session - " + hour+":"+min+":"+sec;
 setTimeout("countdown()",1000);
 }
 countdown();
</script>

<?php
 
    if(isset($_POST['answer']))
    {
        //$_SESSION['question_id'] = array();
        //$id = $_POST['question_id'];
  
        $_SESSION['score'] = (!$_SESSION['score']) ? 0 : $_SESSION['score'];
 
        foreach($_POST['answer'] as $qid => $answer)
         if($_POST['correct_ans'][$qid] == $answer) {
 
        $_SESSION['score']++;
 
        }
        echo " Score is " . $_SESSION['score'];
        }
 
 
?>
 

