#!/bin/sh
#Run for a satellite
#enable cron to run this script every day.
#3 0 * * * /home/anton/sh/run_wxsat.sh > /home/anton/sh/cron.log
#https://github.com/the2belo/wxsat-scheduleri
PATH=/home/anton/bin:/home/anton/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/anton/iwxsat:/home/anton/sh
cd /home/anton/sh
/usr/bin/wget -qr www.celestrak.com/NORAD/elements/weather.txt -O /home/anton/wxsat/weather.txt
#wget -qr www.celestrak.com/NORAD/elements/amateur.txt -O ~/iss_igate/amateur.txt
sudo /home/anton/sh/noaa-scheduler.sh 15 137.6200
sudo /home/anton/sh/noaa-scheduler.sh 17 137.5000
sudo /home/anton/sh/noaa-scheduler.sh 18 137.9125
sudo /home/anton/sh/noaa-scheduler.sh 19 137.1000
#NOAA 15 – 137.6200 MHz
#NOAA 18 – 137.9125 MHz
#NOAA 19 – 137.1000 MHz
sudo echo "<html><body>" > /home/anton/wxsat/images/NOAA_schedule.html
sudo /usr/bin/at -l >> /home/anton/wxsat/images/NOAA_schedule.html
sudo echo "</body></html>" >> /home/anton/wxsat/images/NOAA_schedule.html
#/usr/local/bin/wxmap -a -T "NOAA 15" -H ~/wxsat/weather.txt -L "-26.170/28.030/1700.0" -p0 -o "20 03 2017 18:43"  ~/wxsat/noaa15map.png
#at 00:05 /home/anton/sh/run_wxsat.sh
