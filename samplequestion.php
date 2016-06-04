<?PHP 
   session_start();
   include_once("./udf/udf.php");
   include_once("menuinterface.php");

   //die $_REQUEST['session'];

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
      </div>
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">Review Question that requires answer</h1>
            <hr class="thin bg-grayLighter">
            <!-- -->
            <?php
   //session_start();
   include_once("./udf/udf.php");
   include_once("menuinterface.php");



 $nid = $_GET['nid'];
 $alt = $_GET['alt'];
//echo $_POST['subj'];
	$topicID = '1';
	$testtype = "pre-test";
	$studentID = '1';
    $subjID = '2';
	

	//the testsessionid
	$testsessionid = $topicID.'-'.$testtype.'-'.$studentID;

	// we need php session variable for the $topicID, $testtype, $studentID  

	$itemseasy = getfieldvalue("topic_config", "itemseasy", "where topicid = '$alt' and testtype = '$testtype'");
    //echo $itemseasy;
	$itemsmoderate = getfieldvalue("topic_config", "itemsmoderate", "where topicid = '$alt' and testtype = '$testtype'");
    //echo $itemsmoderate;
	$itemsdifficult = getfieldvalue("topic_config", "itemsdifficult", "where topicid = '$alt' and testtype = '$testtype'");
    //echo $itemsdifficult;

    $sqlscript = "call generateQuestions('1','$alt','$nid','$testtype',$itemseasy,$itemsmoderate,$itemsdifficult)";
    ExecuteNoneQuery($sqlscript);

?>



<?php

require('./controllers/connection.php');
global $con;
 //session_start();
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
 $sql= "call getQuestion('".$a."','1','$alt','$nid')";//"SELECT * FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid ORDER BY ss.id LIMIT 1 OFFSET $a";
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
    $rational_a = $row["a_rational"];
    $rational_b = $row["b_rational"];
    $rational_c = $row["c_rational"];
    $rational_d = $row["d_rational"];

    echo   "<h3>" .$questions. "</h3>";
	echo   "<div>";
    echo   "<input type='radio' name='question_answers' id='question-1-answers-A' value='a' />";
    echo   "<label for='question-1-answers-A'>". $opt1. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question_answers' id='question-1-answers-B' value='b' />";
    echo   "<label for='question-1-answers-B'>". $opt2. "</label>";
    echo   "</div>";               
    echo   "<div>";
    echo   "<input type='radio' name='question_answers' id='question-1-answers-C' value='c' />";
    echo   "<label for='question-1-answers-C'>" . $opt3. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question_answers' id='question-1-answers-D' value='d' />";
    echo   "<label for='question-1-answers-D'>" . $opt4. "</label>";
    echo   "</div>";
    echo   "</li>"; 
    echo   "</li>";
    echo   "</ol>";
    
	echo   "</div>";
    echo   "<input type='hidden' name='question_id' value''.$qid.''/>";
    echo   "<input type='hidden' name='rightanswer[' . $qid . ']' value='' . $answer . '' /> <br>";
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
   
 $nid = $_GET['nid'];
 $alt = $_GET['alt'];



  $myQuery = "SELECT SUM(eq.minutes) AS MIN FROM examquestion eq INNER JOIN studentsession ss ON eq.id = ss.questionid WHERE ss.studentid = 1 AND eq.topicid = '$alt' AND eq.SUBJID = '$nid'";

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
 
 document.getElementById('strclock').innerHTML = "Total time of session : " + hour+":"+min+":"+sec;
 setTimeout("countdown()",1000);
 }
 countdown();
</script>

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
             if($_POST['question_answers'] = 'a'){
                 //echo $rational_a;
                echo '<script type="text/javascript">alert("' . $rational_a . '")</script>';
             } else if($_POST['question_answers'] = 'b') {
                 //echo $rational_b;
                 echo '<script type="text/javascript">alert("' . $rational_b . '")</script>';
             }else if($_POST['question_answers'] = 'c') {
                 //echo $rational_c;
                 echo '<script type="text/javascript">alert("' . $rational_c . '")</script>';
             }else if($_POST['question_answers'] = 'd') {
                 //echo $rational_d;
                 echo '<script type="text/javascript">alert("' . $rational_d . '")</script>';
             } else {
             }

         }
    
       
     }
    } else {
              echo 'Thanks for taking the Review Session';
          }
 
    } else {
   
    }
?>
             

