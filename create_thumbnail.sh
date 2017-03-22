#!/bin/bash
#This Bash script will create thumnail images of all the noaa images in the images directory and place them in the thumb directory
for file in ~/wxsat/images/*
do
  # next line checks the mime-type of the file
  IMAGE_TYPE=`file --mime-type -b "$file" | awk -F'/' '{print $1}'`
  if [ "x$IMAGE_TYPE" == "ximage" ]; then

    WIDTH=`imageinfo --width "$file"`      # obtaining the image width
    HEIGHT=`imageinfo --height "$file"`    # obtaining the image height

    # If the image width is greater that 200 or the height is greater that 150 a thumb is created
    if [ $WIDTH -ge  201 ] || [ $HEIGHT -ge 151 ]; then
       #This line convert the image in a 200 x 150 thumb
       convert -sample 200x150 "$file" "$(dirname "$file")/thumb/thumb_$(basename "$file")"
    fi
  fi
done
