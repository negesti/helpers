#!/bin/bash

if [ $# -ne 2 ]; then
  echo "we need two files to find a mismatch"
  exit -1
fi

echo "elements not part of first file: "
awk 'NR == FNR { list[tolower($0)]=1; next } { if (! list[tolower($0)]) print }' $1 $2

echo "-----------------------------------------------------------"

echo "elements not part of second file: "
awk 'NR == FNR { list[tolower($0)]=1; next } { if (! list[tolower($0)]) print }' $2 $1
