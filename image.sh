#!/bin/sh

# image.sh
#
# Created by Koh Chin Wee on 23/2/14.
# Copyright (c) 2014 Chinwee Koh. All rights reserved.
#
# Version 1.0.0

for img in *.png; do
    filename=${img%.*}

    cp "$filename.png" "$filename@1x.png"
    cp "$filename.png" "$filename@2x.png"
    cp "$filename.png" "$filename@3x.png"
    rm "$filename.png"
done

for img in *@3x.png; do
    filename=${img}
    if [ -f "$filename" ]; then
        mv "$filename" "$filename"
    fi
done

for img in *@2x.png; do
    filename=${img}
    if [ -f "$filename" ]; then
        x3=`sips --getProperty pixelWidth "$filename" | awk '/pixelWidth/ {print $2}'`
        x2=$(( x3 * 2/3 ))
        sips -Z ${x2} ${filename}

        mv "$filename" "$filename"
    fi
done

for img in *@1x.png; do
    filename=${img}
    if [ -f "$filename" ]; then
    x3=`sips --getProperty pixelWidth "$filename" | awk '/pixelWidth/ {print $2}'`
    x1=$(( x3 * 1/3 ))
    sips -Z ${x1} ${filename}

    fileName=${img%@*}
    mv "$filename" "$fileName.png"
    fi
done

exit
