<?PHP
include_once('ECheader.php');
?>
      
      <div class="container">
         <div class="main-content clear-float">
            <h1 class="welcome-to-title">List of Topic(s)</h1>
            <hr class="thin bg-grayLighter">
            <!-- -->
			<?php
			// Create connection
			require("controllers/connection.php");
			global $con;

			if (!$con) {
			    die("Connection failed: " . mysqli_connect_error());
			}
			 $id = $_POST['rdtopic'];

             echo $id;
			 $sql = "CALL getStudyunits()"; // select id,topicid,studyname,isparent,parentid from studyunits where topicid = rid;

			//$sql	= "select * from studyunits;";


			$result = mysqli_query($con, $sql);

			//$row = mysqli_fetch_assoc($result);


			// For avoiding some errors.
			// For avoiding some errors.
if ($result) {
	// Start the list using ul.
	echo '<ul>';
    echo '<form name="revform" method="post" action="samplequestion.php">';
    
	foreach ($result as $row) {
		// Print the item, you can also make links out of these.
        if ($row['isparent'] == 1){
             
            echo '<input type="checkbox" />' . $row['studyname'] . '</br>';
		// Recursive function(made in next step) for getting all the subs by passing id of main item.
		get_children($row['id']);
        }
		
	}
	// End the list.
	echo '</ul>';
    echo "<input type='hidden' value='$id' name='topicid'>";
    echo "<input type='hidden' value='$id' name='session'>";
    echo '<button id="btnStartSession" id="submit" class="button primary btn">Submit</button></form>';
}
// Some message, if the database is empty.
else {
	echo 'No Items';
}
// Clear the memory.
			mysqli_free_result($result);

			function get_children($parent, $level = 1) {

require("controllers/connection.php");

$con = mysqli_connect($host, $username, $password,$db_name);
	$result = mysqli_query($con,'SELECT * FROM studyunits WHERE parentid = '.(int)$parent);
	
	// For avoiding some errors.
	if ($result) {
		// Start the list using ul html tag.
		echo '<ul>';
		foreach ($result as $row) {
			echo '<input type="checkbox" name ="chkstudy[]" value="'.$row['id'].'"/>'.$row['studyname'].'</br>';

		}
		// Close the list.
		echo '</ul>';
	}
}


			?>
<?PHP 
include_once('ECfooter.php');
?>