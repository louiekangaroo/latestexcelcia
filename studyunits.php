
<?php
// Create connection
require("controllers/connection.php");
global $con;

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}
$id = $_POST['rdtopic'];
$sql = "CALL getStudyunits($id)";

$result = mysqli_query($con, $sql);

//$row = mysqli_fetch_assoc($result);


// For avoiding some errors.
if ($result) {
	// Start the list using ul.
	echo '<ul>';
	foreach ($result as $row) {
		// Print the item, you can also make links out of these.
        if ($row['isparent'] == 1){
            echo '<input type="checkbox"/>' . $row['studyname'] . '</br>';
		// Recursive function(made in next step) for getting all the subs by passing id of main item.
		get_children($row['id']);
        }
		
	}
	// End the list.
	echo '</ul>';
}
// Some message, if the database is empty.
else {
	echo 'No Items';
}
// Clear the memory.
mysqli_free_result($result);

echo "<input type=submit text='Next'/>";



function get_children($parent, $level = 1) {

require("controllers/connection.php");

$con = mysqli_connect($host, $username, $password,$db_name);
	$result = mysqli_query($con,'SELECT * FROM studyunits WHERE parentid = '.(int)$parent);
	
	// For avoiding some errors.
	if ($result) {
		// Start the list using ul html tag.
		echo '<ul>';
		foreach ($result as $row) {
			// Print an item, you can also make links out of these.
			echo '<input type="checkbox" name= "chkstudy" value="'.$row['id'].'"/>'.$row['studyname'].'</br>';
			// This is similar to our last code, but
			// this function calls itself, so its recursive.
			//get_children($row['id'], $level+1);
		}
		// Close the list.
		echo '</ul>';
	}
}


?>


