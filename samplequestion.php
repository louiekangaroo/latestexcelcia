<?PHP
include_once('ECheader.php');


//echo $_POST['topicid'];
$selID =  (isset($_POST['selID']))?$_POST['selID']:NULL;
echo $selID;
$subjID ='';
$topicID=$_POST['topicid'];
if (!$_COOKIE["topicid"]){
setcookie("topicid", $topicID);
}
    if(!empty($_POST['chkstudy'])) {
        foreach($_POST['chkstudy'] as $check) {
                //echoes the value set in the HTML form for each checked checkbox.
                             //so, if I were to check 1, 3, and 5 it would echo value 1, value 3, value 5.
                             //in your case, it would echo whatever $row['Report ID'] is equivalent to.
           $subjID .= $check . ",";

        }
        $subjID =  substr($subjID, 0, -1);
        if (!$_COOKIE["subjid"]){
        setcookie("subjid", $subjID);
        }

    }
?>
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">Review Question that requires answer</h1>
            <hr class="thin bg-grayLighter">
            <!-- -->
            <?php
   //session_start();
   include_once("./controllers/udf.php");
   include_once("menuinterface.php");
 //$nid = $_GET['nid'];
 //$alt = $_GET['alt'];
  $subjID ='';


   // $subjID = $_POST['chkstudy'];
	//$testtype = "pre-test";
	$studentID = '1';
 
    //echo $topicID;
    $c_topicid = $_COOKIE["topicid"];
    $c_subjid = $_COOKIE["subjid"];
    //echo $subjID;
    //echo $sessiontype;
	
	//the testsessionid
	//$testsessionid = $topicID.'-'.$testtype.'-'.$studentID;
	// we need php session variable for the $topicID, $testtype, $studentID  
    //$sessiontype = $_POST['session'];
    $itemseasy = getfieldvalue("topic_config", "itemseasy", "where testtype = '$c_topicid'");
    //echo $itemseasy;
	$itemsmoderate = getfieldvalue("topic_config", "itemsmoderate", "where testtype = '$c_topicid'");
    //echo $itemsmoderate;
	$itemsdifficult = getfieldvalue("topic_config", "itemsdifficult", "where testtype = '$c_topicid'");
    //echo $itemsdifficult;
    $totalitems = $itemsdifficult + $itemseasy + $itemsmoderate;

    $sqlscript = "call generateQuestions('1','$c_topicid','$c_subjid','$c_topicid',$itemseasy,$itemsmoderate,$itemsdifficult,0,'$c_topicid',$totalitems)";
    //we need to supply the student id and session id, please supply it if you can
    ExecuteNoneQuery($sqlscript);   
    
?>



<?php
require('./controllers/connection.php');
global $con;
    if(!isset($a))
    {
        $a=0;
        //unset($_SESSION['score']);
    }
 
if(isset($_POST['next'])) {
        $a=$_POST['a'];
    
}
if(isset($_POST['sbmit'])) {
        $a=$_POST['a'];
    
}
 //$sql = "select * from examquestion eq inner join studentsession ss on eq.id = ss.questionid" ;
//`generateQuestions`(IN studid INT,IN `topid` INT,IN `subid` VARCHAR(50),IN _type VARCHAR(50),IN toteasy INT,IN totmed INT,IN totdiff INT)
//"SELECT * FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid ORDER BY ss.id LIMIT 1 OFFSET $a";
if(isset($_POST['qtopic'])) {
        $topicID = $_POST['qtopic'];
    
}


 $sql= "call getQuestion('".$a."','1','$c_topicid','$c_subjid')";
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
    $topicID2 = $row["topicid"];
    $opt1 = $row["a"];
    $opt2 = $row["b"];
    $opt3 = $row["c"];
    $opt4 = $row["d"];
    $min = $row["minutes"];
    $answer = $row["correct_ans"];
    $rational_a = $row["a_rational"];
    $rational_b = $row["b_rational"];
    $rational_c = $row["c_rational"];
    $rational_d = $row["d_rational"];
    echo   "<h3>" .($a + 1).'. '.$questions. "</h3>";
	echo   "<div>";
   // echo   "<input type='radio' name='question_answers' id='question-1-answers-A' value='a' '".if(isset($_POST['question_answers']) && $_POST['question_answers'] == 'a') echo 'checked="checked"'; ."'/>";
   // echo   '<input type="radio" name="question_answers" id="question-1-answers-A" value="a.(isset($_POST['question_answers']) && $_POST['question_answers'] == 'a')?'checked="checked"':"")./>';
    echo '<input type="radio" id="question-1-answers-A" name="question_answers" value="a"';
    if(isset($_POST['question_answers']) && $_POST['question_answers'] == 'a') { 
      echo ' checked="checked"'; 
    } 
    echo ' >'; 
    echo   "<label for='question-1-answers-A'>". $opt1. "</label>";
    echo   "</div>";
    echo   "<div>";
    //echo   "<input type='radio' name='question_answers' id='question-1-answers-B' value='b' />";
    echo   '<input type="radio" id="question-1-answers-B" name="question_answers" value="b"';
    if(isset($_POST['question_answers']) && $_POST['question_answers'] == 'b') { 
      echo ' checked="checked"'; 
    } 
    echo ' >'; 
    echo   "<label for='question-1-answers-B'>". $opt2. "</label>";
    echo   "</div>";               
    echo   "<div>";
    //echo   "<input type='radio' name='question_answers' id='question-1-answers-C' value='c' />";
    echo   '<input type="radio" id="question-1-answers-C" name="question_answers" value="c"';
    if(isset($_POST['question_answers']) && $_POST['question_answers'] == 'c') { 
      echo ' checked="checked"'; 
    } 
    echo ' >'; 
    echo   "<label for='question-1-answers-C'>" . $opt3. "</label>";
    echo   "</div>";
    echo   "<div>";
    //echo   "<input type='radio' name='question_answers' id='question-1-answers-D' value='d' />";
    echo   '<input type="radio" id="question-1-answers-D" name="question_answers" value="d"';
    if(isset($_POST['question_answers']) && $_POST['question_answers'] == 'd') { 
      echo ' checked="checked"'; 
    } 
    echo ' >'; 
    echo   "<label for='question-1-answers-D'>" . $opt4. "</label>";
    echo   "</div>";
    echo   "</li>"; 
    echo   "</li>";
    echo   "</ol>";
    
	echo   "</div>";
    echo   "<input type='hidden' name='question_id' value''.$qid.''/>";
    echo   "<input type='hidden' name='qtopic' value''.$topicID2.''/>";
    echo   "<input type='hidden' name='rightanswer[' . $qid . ']' value='' . $answer . '' /> <br>";
    echo   "<input type='submit' name='sbmit' value='submit answer'>    ";
    echo   "<input type='submit' name='next' value='next question'><br><br>";
    
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
  $myQuery = "SELECT SUM(eq.minutes) AS MIN FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid WHERE ss.studentid = 1 AND eq.topicid = '$c_topicid' AND FIND_IN_SET(eq.SUBJID, '$c_subjid')";
 $result = $con->query($myQuery);
 $num = $result->num_rows;
  while ($row = mysqli_fetch_array($result)) {
    $setTime = $row['MIN'] * 60;
  }
$timestamp = time();
$diff = $setTime; //<-Time of countdown in seconds.  ie. 3600 = 1 hr. or 86400 = 1 day.
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



<?php
    
    if(isset($_POST['question_answers']))
    {
        //$_SESSION['question_id'] = array();
        //$id = $_POST['question_id'];
  
       /// $_SESSION['score'] = (!$_SESSION['score']) ? 0 : $_SESSION['score'];
 
        ///foreach($_POST['question_answers'] as $qid => $answer)
         ///if($_POST['rightanswer'][$qid] == $answer) {
 
       /// $_SESSION['score']++;
 
       /// }
       /// echo " Score is " . $_SESSION['score'];
      ///  }
       // echo '<script type="text/javascript">alert("' . $qid . '")</script>';
       // echo $_POST['question_id'];
          if(isset($answer))
    {
               
             
        $qid = $qid - 1;
          
       $sql1 = "UPDATE studentsession SET answer='".$_POST['question_answers']."' WHERE id='$qid'"; 
     
      $success = $con->query($sql1);
       
    if($success == false)
     {
	   echo"An error has occured".mysql_error();
	 }
     else
     {
         if($_POST['question_answers'] == $answer) 
        {
            //echo 'correct';
            echo '<script type="text/javascript">alert("correct")</script>';
        }
         else
         {         
             echo '<span style="color:red; font-size:18px; line-height:35px; font-family: Calibri;">Rational : </span>'; 
             if($_POST['question_answers'] == 'a'){
             
                // '<span style="font-color:red;">'.$rational_a.'</span>';
                echo '<span style="color:red; font-size:18px; line-height:35px; font-family: Calibri;">'.$rational_a.'</span>';
             } else if($_POST['question_answers'] == 'b') {
                 //echo $rational_b;
                 //echo '<script type="text/javascript">alert("' . $rational_b . '")</script>';
                 echo '<span style="color:red; font-size:18px; line-height:35px; font-family: Calibri;">'.$rational_b.'</span>';
             }else if($_POST['question_answers'] == 'c') {
                 //echo $rational_c;
                 //echo '<script type="text/javascript">alert("' . $rational_c . '")</script>';
                 echo '<span style="color:red; font-size:18px; line-height:35px; font-family: Calibri;">'.$rational_c.'</span>';
             }else if($_POST['question_answers'] == 'd') {
                 //echo $rational_d;
                 //echo '<script type="text/javascript">alert("' . $rational_d . '")</script>';
                 echo '<span style="color:red; font-size:18px; line-height:35px; font-family: Calibri;">'.$rational_d.'</span>';
             } else {
             }
         }
    
       
     }
    } else {
          //  echo  $b;
               $qid = $b - 1;
               $sql1 = "UPDATE studentsession SET answer='".$_POST['question_answers']."' WHERE id='$b'"; 
              echo 'Thanks for taking the Review Session';
               $sqlscript = "call insertIntoTestHistory('1')";
               ExecuteNoneQuery($sqlscript); 
              
          }
 
    } else {
   
    }
?>
<div id="strclock">Clock Here!</div>
<script type="text/javascript">
 var hour = <?php echo floor($hours); ?>;
 var min = <?php echo floor($minutes); ?>;
 var sec = <?php echo floor($seconds); ?>;
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
 
 document.getElementById('strclock').innerHTML = "Total time of session : " + hour+":"+min+":"+sec;
 setTimeout("countdown()",1000);
 }
 countdown();
</script>
 <?PHP 
include_once('ECfooter.php');
?>            