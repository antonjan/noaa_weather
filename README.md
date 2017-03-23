# noaa_weather
This repository will have all the files of the Automated NOAA weather satellite system.
<b>How dose this system work?</b><br>

The system consists of 3 shell scripts that tail 5 applications together.<br>
This shell scrip will fetch the satellite TLE keps data from celestrack. http://www.celestrak.com/NORAD/elements/weather.txt<br>
The NOAA satellite TLE data is then passed to the predict satellite positioning software.<br>
 The predict software calculate when the next satellite will be above your radio station. <br>
The result of the calculations for the next 24 hours is then send to a scheduler program call "at".<br>
The "at" scheduler will then start and stop the rtl_fm receiver at the required time and record the audio from the NOAA satellite and save the recordings to the recordings directory.<br>
The Audio files is not in the correct format for wxtoimg utility to convert it to images and need to be converted to the correct format using the SOX until.<br>
The converted recordings is then passed to wxtoimg utility to generate the Satellite images.<br>
The images is then exposed via a Apache web server with a php plugin to the internet.<br>
The instelation and configeration details is avalible here http://zr6aic.blogspot.co.za/2017/03/receiving-noaa-weather-satellite-images.html <br>
Hardware block diagram<br>
![Alt text](NOAA_automated_Satelite_System.png?raw=true "Hardware Block diagram")<br>
Software block diagram<br>
![Alt text](NOAA_Satellite_Block_diagram_2.png?raw=true "Software Block diagram")<br>
Here is some images from the system.
Index page
![Alt text](wxsat_3.png?raw=true "WXSAT Index page")<br>
Image
![Alt text](NOAA19-HVCT-20170317-1552.png?raw=true "Satellite Image of South Africa")<br>
Image
![Alt text](NOAA19-MSA-20170322-1455.png?raw=true "Satellite Image of South Africa")<br>
