<?php

     $files = glob("*.*");
echo "<html><body>";
echo "<h1>This is the automated NOAA Satellite Image recording system of ZR6AIC.</h1>";
echo "Click on Image to enlarge.<br>";
echo 'The audio recordings for the images is avalible <a href="http://zr6aic.giga.co.za:8090/wxsat/recordings/" >here</a> if you want to manipilate it your self.';
echo 'This system is available from <a href="http://www.giga.co.za">Giga Technology.</a><br>';
echo 'This system is operated by Anton Janovsky and you can contact me<a href="https://docs.google.com/spreadsheet/viewform?fromEmail=true&amp;formkey=dEZUN2tTUTU1NUdweUxldkcwNmpXNlE6MQ" target="_blank"> here. </a><br>';
echo 'This system was started on 17 March 2017 and is situated in Bassonia in the South of Johannesburg, South Africa.<br>';
     for ($i=1; $i<count($files); $i++)

    {

    $image = $files[$i];
    $supported_file = array(
    'gif',
    'jpg',
    'jpeg',
    'png'
   );
   $ext = strtolower(pathinfo($image, PATHINFO_EXTENSION));
   if (in_array($ext, $supported_file)) {
    echo '<a href="http://zr6aic.giga.co.za:8090/wxsat/images/'.$image .'">'.$image .'</a>'."<br>";
    echo '<a href="http://zr6aic.giga.co.za:8090/wxsat/images/'.$image .'"> <img src=thumb/thumb_'.$image .' alt="Random image" height="150" width="200" ></a>'."<br><br>";

   } else {
    continue;
  }
  }
echo 'This system is operated by Anton Janovsky and you can contact me<a href="https://docs.google.com/spreadsheet/viewform?fromEmail=true&amp;formkey=dEZUN2tTUTU1NUdweUxldkcwNmpXNlE6MQ" target="_blank"> here. </a>';
echo "</body></html>";
 ?>
