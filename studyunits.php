<?PHP 
   session_start();
   include_once("./udf/udf.php");
   include_once("menuinterface.php");
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
      <script src="js/globalscript.js"></script>
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
       <script>
        $("#btnStartSession").click(function() {
           alert('meh'); 
        });
       </script>
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
         <div class="app-bar-element place-right">
            <span class="dropdown-toggle"><span class="mif-cog"></span> Hi, <?PHP echo $usertype . ' ' . $fname ?></span>
            <div class="app-bar-drop-container padding10 place-right no-margin-top block-shadow fg-dark" data-role="dropdown" data-no-close="true" style="width: 220px">
               <h2 class="text-light">Quick settings</h2>
               <ul class="unstyled-list fg-dark">
                  <li><a href="" class="fg-white1 fg-hover-yellow">Profile</a></li>
                  <li><a href="controllers/logout.php" class="fg-white3 fg-hover-yellow">Logout</a></li>
               </ul>
            </div>
         </div>
      </div>





      
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
						// Print an item, you can also make links out of these.
						
						/*
						echo "<input type='checkbox' name= '$studyname' value='".$row['id']."'/>" .$row['studyname']."<a href=samplequestion.php?'$topicid-$isparent-$parentid'>take pre-test</a></br>";
						*/
						//echo $row['studyname']."<a href=samplequestion.php?'$topicid-$isparent-$parentid'>take pre-test</a></br>";

						// This is similar to our last code, but
						// this function calls itself, so its recursive.
						//get_children($row['id'], $level+1);
					}
					// Close the list.
					echo '</ul>';
				}
			}


			?>
         </div>
      </div>
   </body>
</html>

<a href='asd.php?phone=0001112222'>click</a>

