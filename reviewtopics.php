<?php
// Create connection
require("controllers/connection.php");
global $con;

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$sql = "CALL getReviewtopic()";

$result = mysqli_query($con, $sql);

echo '<form name="revform" method="post" action="studyunits.php"><div class="coolTable" ><table><tr><td></td><td>Session Type</td></tr>';
foreach ($result as $row){
    
    echo '<tr>';
echo '<td><input type="radio" name="rdtopic" value="'.$row['id'].'" id="rdio">';
      echo '<td>'.$row["topicname"].'</td>';

    
    echo '</tr>';
    }
  echo '</table></div>';
echo '<input type="submit" id="submit")"></input></form>';

?>


    