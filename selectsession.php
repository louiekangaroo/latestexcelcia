<?PHP
include_once('ECheader.php');
?>
      <div class="container">
          <div class="main-content clear-float">
            <h1 class="welcome-to-title">Select your session</h1>
            <hr class="thin bg-grayLighter">
           <!-- <form method="post" action="reviewtopics.php"> -->
            <form method="post" action="reviewtopics.php"> 
              <label class="input-control radio">
                  <input type="radio" name="session" checked>
                  <span class="check"></span>
                  <span class="caption">Study Session</span>
              </label>
              <br>
              <label class="input-control radio">
                <input type="radio" name="session">
                <span class="check"></span>
                <span class="caption">Test Session</span>
              </label>
              <br><br>
              <!-- <button id="btnStartSession" class="button primary btn">Start Session</button> -->
              <input type="submit" name="submit" class ="button primary btn" value="Submit">
            </form> 

<?PHP 
include_once('ECfooter.php');
?>