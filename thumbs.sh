#!/bin/bash


shopt -s globstar
for filename in /var/www/html/usbdrive/**/*.mov; do
	#export filename="/var/www/html/usbdrive/Camera1_2019.02.25_19-00.mov"
	export pathhash=$(echo -n "$filename" | sha1sum | cut -c1-40)

	#echo "Processing $filename - $pathhash ..."

	export capturename="/var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg"
	export capturehash=$(echo -n "$capturename" | sha1sum | cut -c1-40)
	export thumb240="/var/www/html/_h5ai/public/cache/thumbs/thumb-$capturehash-240x240.jpg"
	export thumb320="/var/www/html/_h5ai/public/cache/thumbs/thumb-$capturehash-320x240.jpg"

	#[ -s "$capturename" ] && echo "\tCapture - exists"

	[ -s "$capturename" ] || nice ffmpeg -ss 0:05:10 -probesize 100M -analyzeduration 100M -i $filename -an -vframes 1 /var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg -y > /dev/null 2>&1
	[ -s "$capturename" ] || nice ffmpeg -ss 0:04:20 -probesize 100M -analyzeduration 100M -i $filename -an -vframes 1 /var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg -y > /dev/null 2>&1
	[ -s "$capturename" ] || nice ffmpeg -ss 0:03:40 -probesize 100M -analyzeduration 100M -i $filename -an -vframes 1 /var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg -y > /dev/null 2>&1
	[ -s "$capturename" ] || nice ffmpeg -ss 0:02:40 -probesize 100M -analyzeduration 100M -i $filename -an -vframes 1 /var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg -y > /dev/null 2>&1
	[ -s "$capturename" ] || nice ffmpeg -ss 0:00:15 -probesize 100M -analyzeduration 100M -i $filename -an -vframes 1 /var/www/html/_h5ai/public/cache/thumbs/capture-$pathhash.jpg -y > /dev/null 2>&1
	
	[ -s "$capturename" ] || echo "\t$filename - Capture - error"
	[ -s "$capturename" ] || rm -f $filename
	[ -s "$capturename" ] && chmod 777 $capturename

	[ -s "$thumb240" ] || nice convert "$capturename" -resize 240x240 "$thumb240" > /dev/null 2>&1
	[ -s "$thumb320" ] || nice convert "$capturename" -resize 320x240 "$thumb320" > /dev/null 2>&1
	
	[ -s "$thumb240" ] && chmod 777 $thumb240
	[ -s "$thumb320" ] && chmod 777 $thumb320
	
done




