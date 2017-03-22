#Run for a satellite sceduling at midnight (cron scedule)
#The original data I got from this link https://github.com/the2belo/wxsat-scheduler
#get the lates TLE kept elemts for NOAA satellite
wget -qr www.celestrak.com/NORAD/elements/weather.txt -O ~/wxsat/weather.txt
sudo ./noaa_sat_scheduler.sh 15 137.6200
sudo ./noaa_sat_scheduler.sh 18 137.9125
sudo ./noaa_sat_scheduler.sh 19 137.1000
#NOAA 15 – 137.6200 MHz
#NOAA 18 – 137.9125 MHz
#NOAA 19 – 137.1000 MHz
#The following write out a html page witch will have the scedule for the day 
sudo echo "<html><body>" > ~/wxsat/images/NOAA_schedule.html
sudo at -l >> ~/wxsat/images/NOAA_schedule.html
sudo echo "</body></html>" >> ~/wxsat/images/NOAA_schedule.html

