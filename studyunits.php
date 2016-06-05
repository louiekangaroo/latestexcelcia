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

			 $sql = "CALL getStudyunits($id)"; // select id,topicid,studyname,isparent,parentid from studyunits where topicid = rid;

			//$sql	= "select * from studyunits;";


			$result = mysqli_query($con, $sql);

			//$row = mysqli_fetch_assoc($result);


			// For avoiding some errors.
			if ($result) {
				// Start the list using ul.
echo '<form method="post" action="samplequestion.php">';
				echo '<table border="0">';
				$ctr=0;
				foreach ($result as $row) {
					// Print the item, you can also make links out of these.
			        if ($row['isparent'] == 1){

						echo '<tr bgcolor="#5cacee"><td colspan="4">';
			            //echo '<input type="checkbox"/>' . $row['studyname'] . '</br>';
						// Recursive function(made in next step) for getting all the subs by passing id of main item.
			        	echo $row['studyname'] . '';
			        	//$topicID = $row[topicid];
						//get_children(1,1);
			        }else{
			        	echo '</td></tr>
			        		  <tr>
			        			<td width="5%">&nbsp</td>
			        			<td>';
                        $subjid = $row['id'];
						$studyname = $row['studyname'];
						$topicid = $row['topicid'];
						$isparent = $row['isparent'];
						$parentid = $row['parentid'];
						echo $studyname." </td><td> <a href=samplequestion.php?nid=" . $subjid ."&alt=".$topicid." click here to have the post test' id='submit-pre' name='subj' value=".$row['id'].">pre-test</a></td>";
						echo "<td><a href=samplequestion.php?post-$topicid-$isparent-$parentid alt='click here to have the post test' id='submit-post'>post-test</a>";
						echo '</td></tr>';
			        }
				}
				// End the list.
				echo '<tr bgcolor="#003087"><td colspan="4"> </tr>';
				echo "<tr><td colspan='4' align='center'>
					    <!-- <input type=submit text='Next'/> -->";
				echo '</td></tr></table> </form>';

			}
			// Some message, if the database is empty.
			else {
				echo 'No Items';
			}
			// Clear the memory.
			mysqli_free_result($result);

			function get_children($parent, $level) {

			require("controllers/connection.php");

			$con = mysqli_connect($host, $username, $password,$db_name);
				//$result = mysqli_query($con,'SELECT * FROM studyunits WHERE parentid = '.(int)$parent);
				$result = mysqli_query($con,"SELECT * FROM studyunits where topicid=$parent and parentid=$parent and isparent=0;");
				// For avoiding some errors.
				if ($result) {
					// Start the list using ul html tag.
					echo '<ul>';
					foreach ($result as $row) {
						$studyname = $row['studyname'];
						$topicid = $row['topicid'];
						$isparent = $row['isparent'];
						$parentid = $row['parentid'];

					}
					// Close the list.
					echo '</ul>';
				}
			}


			?>
<?PHP 
include_once('ECfooter.php');
?>