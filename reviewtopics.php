<?PHP
include_once('ECheader.php');
?>
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">Main Topic(s)</h1>
            <hr class="thin bg-grayLighter">
            <!-- -->
            <?PHP 
              
                // Create connection
               require("controllers/connection.php");
               global $con;
               
               if (!$con) {
                die("Connection failed: " . mysqli_connect_error());
               }
               
               // $sql = "CALL getReviewtopic()";
               $sql = "select * from studyunits where isparent=1;";

               $result = mysqli_query($con, $sql);
               
               echo '<form name="revform" method="post" action="studyunits.php"><div class="coolTable" ><table><tr><td></td></tr>';
               foreach ($result as $row){
                
               
               echo '<tr>';
               echo '<label class="input-control radio" >';
                //echo '<input type="radio" name="rdtopic" value="'.$row['id'].'" id="rdio">';
               echo '<input type="radio" name="rdtopic" value="'.$row['topicid'].'" id="rdio">';
                echo '<span class="check"></span>';
                //echo '<span class="caption">'.$row["topicname"].'</span>';
                echo '<span class="caption">'.$row["studyname"].'</span>';
                echo '</label>';
                    echo '</tr>';
                   echo '<br>';
                }
               echo '</table></div>';
               echo '<button id="btnStartSession" id="submit" class="button primary btn">Submit</button></form>';
                
               ?>
         </div>
      </div>
   </body>
</html>
