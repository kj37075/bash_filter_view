#!/bin/bash
#Copyright Kris Occhipinti 2018
#http://filmsbykris.com
#license GPLv3 - https://www.gnu.org/licenses/gpl.txt

# ext and viewer added by Ken Johnson 2021 https://pastebin.com/Tka5JEM8
# allow choice of file extensions to filter, default to jpg if nothing is specified
if [ $1 != "" ]; then
 EXT="$1"
 else EXT="jpg"
fi
l=$(ls *.$EXT)

# allow choice of image veiwer to disply files, default to feh if nothing is specified
if [ "$2" == "" ]; then
 VIEWER="feh"
 else VIEWER="$2"
fi
# end of ext and viewer added by Ken Johnson 2021

tmp_i=""
i=""

clear
echo "$l"
 
function prompt(){
  clear
  output="$(echo "$l"|grep -i "$i")"
  count="$(echo "$l"|grep -i "$i"|wc -l)"
 
  echo "$count results for $i"
  echo "===================================="
  echo "$output"
 
}
 
while true; do
read -rsn1 input
  i+=$input
  prompt
 
  if [ "$output" == "" ]
  then
    echo "No Entries Found for ${i}..."
    echo "Clearing list"
    i="$tmp_i";
    sleep 1 
    prompt
  elif [ $count -eq 1 ]
  then
    clear
    echo "$output is found"
    $VIEWER "$output"
    i=""
    prompt
    #break 
  fi
  tmp_i="$i"
  
done
