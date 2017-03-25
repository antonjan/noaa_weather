<?php

/*     $files = glob("NOAA18-MCIR*.png",GLOB_NOSORT);*/
echo "<html><body>";
echo "<h1>This is the automated NOAA Satellite Image recording system of ZR6AIC.</h1>";
echo "Click on Image to enlarge.<br>";
echo 'The audio recordings for the images is avalible <a href="http://zr6aic.giga.co.za:8090/wxsat/recordings/" >here</a> if you want to manipilate it your self.<br>';
echo 'This system is available from <a href="http://www.giga.co.za">Giga Technology.</a><br>'; 
echo 'This system is operated by Anton Janovsky and you can contact me<a href="https://docs.google.com/spreadsheet/viewform?fromEmail=true&amp;formkey=dEZUN2tTUTU1NUdweUxldkcwNmpXNlE6MQ" target="_blank"> here. </a><br>';
echo 'This system was started on 17 March 2017 and is situated in Bassonia in the South of Johannesburg, South Africa.<br>';
echo 'This stations position is 26°17.13 S 28°4.25 E, KG43AR if you need it for your Wxtoimg software. <br>';
echo "<hr><br>";
$dir = "/home/anton/wxsat/images";
chdir($dir);
array_multisort(array_map('filemtime', ($files = glob("*.{png,jpg}", GLOB_BRACE))), SORT_DESC, $files);
foreach($files as $filename)
{
  /*echo "<a>".substr($filename, 0, -4)."</a><br>";*/
  /*echo "<a>".$filename."</a><br>";*/
    echo '<a href="http://zr6aic.giga.co.za:8090/wxsat/images/'.$filename.'">'.$filename.'</a>'."<br>";
    echo '<a href="http://zr6aic.giga.co.za:8090/wxsat/images/'.$filename .'"> <img src=thumb/thumb_'.$filename .' alt="Random image" height="150" width="200" ></a>'."<br><br>";

  }
echo 'This system is operated by Anton Janovsky and you can contact me<a href="https://docs.google.com/spreadsheet/viewform?fromEmail=true&amp;formkey=dEZUN2tTUTU1NUdweUxldkcwNmpXNlE6MQ" target="_blank"> here. </a><br>';
session_start();
$counter_name = "counter.txt";
// Check if a text file exists. If not create one and initialize it to zero.
if (!file_exists($counter_name)) {
  $f = fopen($counter_name, "w");
  fwrite($f,"0");
  fclose($f);
}
// Read the current value of our counter file
$f = fopen($counter_name,"r");
$counterVal = fread($f, filesize($counter_name));
fclose($f);
// Has visitor been counted in this session?
// If not, increase counter value by one
if(!isset($_SESSION['hasVisited'])){
  $_SESSION['hasVisited']="yes";
  $counterVal++;
  $f = fopen($counter_name, "w");
  fwrite($f, $counterVal);
  fclose($f); 
}
echo "You are visitor number ".$counterVal." to this site";
echo "</body></html>";
 ?>
