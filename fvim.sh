#!/bin/bash

# do other editors really exist? 
EDITOR=vim

if [ -z $1 ]; then
  echo "Specify a search term"
  exit 1
fi

unset a i
while IFS= read -r -d $'\0' file; do
  a[i++]="$file"
done < <(find . -name "$1" -print0)

if [ -z $i ]; then
  echo "No file found, maybe add a *?"
  exit 2
fi

if [[ $i -eq 1 ]] 
then
  echo "Only one file found. Opening it"
  echo "${a[0]}"
  exec $EDITOR "${a[0]}"
  exit 0
fi

j=0
while [ $j -lt $i ]; do
  echo " $j:  ${a[${j}]}"
  let j=j+1
done

echo "Number of the file to open or return to exit:"
read open

if [ -z $open ]; then
  exit 1
fi

exec $EDITOR "${a[${open}]}"

exit 0
