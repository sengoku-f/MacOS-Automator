#!/bin/bash

basepath=`dirname $0`

dir_size=75

dir_name="folder"

echo "$basepath"

cd "$basepath"

n=$((`find . -maxdepth 1 -type f | wc -l`/$dir_size+1))

find "." -depth -name "* *" -execdir rename 's/ //g' "{}" \;

for i in `seq 1 $n`;
do
    mkdir -p "$dir_name$i";
    ls -d ./*.* | head -n $dir_size | xargs -P 6 -J {} mv {} "$dir_name$i"
done

find "." -depth -maxdepth 1 -mindepth 1 -type d -empty -exec rmdir {} \; && afplay "/System/Library/Sounds/Glass.aiff"
