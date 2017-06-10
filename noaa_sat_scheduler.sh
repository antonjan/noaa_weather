#!/bin/bash

#clear array
unset var1[@]

if [ -z $1 ]; then
    echo "Must specify which bird"
    exit 1
fi
if [ -z $2 ]; then
    echo "Must specify frequency in MHz"
    exit 1
fi

#get command line arg for bird/freq
bird=$1
freq=$2

#calculate best passes
for i in {00..23}
do
var1[10#$i]=$(predict -t ~/wxsat/weather.txt -q ~/.predict/predict.qth -p "NOAA ${bird}" $(date -d "+$i hour" +%s) | awk '{ if($5>=30) print $0}' |sort -u | head -1)
done

#calculate start-end for each pass
for x in $(printf -- '%s\n' "${var1[@]}" | grep : | awk '{print $1,$3$4}' | cut -d : -f 1,2 | sort -uk 2 | awk '{print $1}')
do
recstart=$(predict -t ~/wxsat/weather.txt -q ~/.predict/predict.qth -p "NOAA ${bird}" $x | awk '{ if($5>=10) print $0}' | head -1 | awk '{print $1}')
recend=$(predict -t ~/wxsat/weather.txt -q ~/.predict/predict.qth -p "NOAA ${bird}" $x | awk '{ if($5>=10) print $0}' | tail -1 | awk '{print $1}')
rectime=$(awk "BEGIN {print $recend-$recstart}")
init=$(date -d "@$recstart" +%y%m%d%H%M)
#create at file
cat << EOF > ~/wxsat/noaa${bird}.at
recdate=\$(date +%Y%m%d-%H%M)
#mapdate "06 04 2017 18:44"
mapdate=\$(date '+%d %m %Y %H:%M')
timeout $rectime /usr/local/bin/rtl_fm -d 0 -f ${freq}M -s 48000 -g 49.6 -p 1 -F 9 -A fast -E DC ~/wxsat/recordings/NOAA${bird}-\$recdate.raw
/usr/bin/sox -t raw -r 48000 -es -b16 -c1 -V1 ~/wxsat/recordings/NOAA${bird}-\$recdate.raw ~/wxsat/recordings/NOAA${bird}-\$recdate.wav rate 11025
touch -r ~/wxsat/recordings/NOAA${bird}-\$recdate.raw ~/wxsat/recordings/NOAA${bird}-\$recdate.wav
#wxmap  -T "NOAA 15" -d -a -o -G ~/wxsat -H weather.txt -L "-26.17/-28.03/1700.0" "06 04 2017 18:44" ./NOAA15-201704-1844.png
wxmap -a -T "NOAA ${bird}" -G ~/wxsat -H weather.txt -L "-26.17/28.03/1700" -p0 -o "\$mapdate" ~/wxsat/noaa${bird}map.png
wxmap -a -T "NOAA ${bird}" -G ~/wxsat -H weather.txt -L "-26.17/28.03/1700" -p0 -o "\$mapdate" ~/wxtoimg/maps/noaa${bird}map.png
#/home/anton/wxtoimg/maps
/usr/local/bin/wxtoimg -N -e MCIR -m ~/wxsat/noaa${bird}map.png ~/wxsat/recordings/NOAA${bird}-\$recdate.wav ~/wxsat/images/NOAA${bird}-MCIR-\$recdate.png
/usr/local/bin/wxtoimg -N -e HVCT -m ~/wxsat/noaa${bird}map.png ~/wxsat/recordings/NOAA${bird}-\$recdate.wav ~/wxsat/images/NOAA${bird}-HVCT-\$recdate.png
#/usr/local/bin/wxtoimg -e MCIR-precip -m ~/wxsat/noaa${bird}map.png ~/wxsat/recordings/NOAA${bird}-\$recdate.wav ~/wxsat/images/NOAA${bird}-PRECIP-\$recdate.png
/usr/local/bin/wxtoimg -N -e MSA -m ~/wxsat/noaa${bird}map.png ~/wxsat/recordings/NOAA${bird}-\$recdate.wav ~/wxsat/images/NOAA${bird}-MSA-\$recdate.png
#contrast enhans
/usr/local/bin/wxtoimg -N -b -e contrast -m ~/wxsat/noaa${bird}map.png ~/wxsat/recordings/NOAA${bird}-\$recdate.wav ~/wxsat/images/NOAA${bird}-CONB-\$recdate.png
#bash ~/wxsat/Dropbox-Uploader/dropbox_uploader.sh upload ~/wxsat/images/NOAA${bird}-*-\$recdate.png /
rm ~/wxsat/recordings/NOAA${bird}-\$recdate.raw
EOF
#schedule at
at -f ~/wxsat/noaa${bird}.at -t $init
done
#create the thumbnails
~/sh/create_thumpnail.sh
#clear array
unset var1[@]
