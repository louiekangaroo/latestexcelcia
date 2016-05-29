
<?php
// Create connection
require("connection.php");
global $con;

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

//$id = $_POST['chkstudy'];
$sql = "select * from examquestion eq inner join studentsession ss on eq.id = ss.questionid" ;
$result = $con->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
	
	echo   "<h3>" .$row["question"]. "</h3><br>";
	echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-A' value='". $row["a"]."' />";
    echo   "<label for='question-1-answers-A'>". $row["a"]. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-B' value='". $row["b"]."' />";
    echo   "<label for='question-1-answers-B'>". $row["b"]. "</label>";
    echo   "</div>";               
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-C' value='". $row["c"]."' />";
    echo   "<label for='question-1-answers-C'>" . $row["c"]. "</label>";
    echo   "</div>";
    echo   "<div>";
    echo   "<input type='radio' name='question-1-answers' id='question-1-answers-D' value='". $row["d"]."' />";
    echo   "<label for='question-1-answers-D'>" . $row["d"]. "</label>";
    echo   "</div>";
    echo   "</li>"; 
    echo   "</li>";
    echo   "</ol>";
    
	echo   "</form>";
	echo   "</div>";
	
	         }
			 
} else {
    echo "0 results";
}
$con->close();
?> 



