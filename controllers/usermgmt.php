 <?php
// Create connection
require("connection.php");
global $con;

  $sql = "SELECT * FROM personalinfo";  
  $result = mysqli_query($con, $sql);
          
  $rows = array();
   while($r = mysqli_fetch_assoc($result)) {
     $rows[] = $r;
   }

 print json_encode($rows);

?>