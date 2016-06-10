<?PHP 
include_once('ECheader.php');
if(!(trim($usertype)=="admin" || trim($usertype)=="teacher")){
  siteRedirectWithAlert("Sorry you are not allowed to use this module! ".$usertype,"index.php");
}
// start of save user submitted data to table
if(isset($_POST["txttype"])){
    $capture_field_vals ="";
	$ctr = 0;
	$recID = implode(",", $_POST['id']);
	$elementID = 0;
	foreach (explode(',',$recID) as $value){
		$ArrayDataID[$ctr] = "\"".trim($value)."\"";
		$ctr++;
	}
	$ctr = 0;
	$sql = "";

	foreach($_POST["txttype"] as $key => $text_field){
		//echo "txttype : $text_field ID : " ; // textfield is the txttype
		//echo $ArrayDataID[$ctr];     // this is the record ID
		//echo " </br>";
		$updatetype = $text_field;
		$updateid = $ArrayDataID[$ctr];
		$sql = "update examquestion set type = '$updatetype' where id=$updateid; ";
		if(!ExecuteNoneQuery($sql)){
			$errCtr++;
			die("Database update error --> update examquestion table (user set type)...");
		}else{
			//DisplayAlert("Updating of Exam Selection completed");	
		}
		$ctr++;
    }


}
// end of saving user submitted data to table

include_once('ECfooter.php');
?>