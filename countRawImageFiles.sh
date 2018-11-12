#!/bin/bash
#
# Author: Ahmad Ghadiri
# This file counts the number of raw files and jpg file
# in the given directory and prints the number of raw
# files and jpg files that don't have counterpart
#
# Usage: ./countRawImageFiles.sh <absolute path to the photo directory>

DIR_ABS_PATH=$1

rawCount=$(find ${DIR_ABS_PATH} -iname '*.orf' | wc -l)
echo "Number of raw files: ${rawCount}"

jpgCount=$(find ${DIR_ABS_PATH} -iname '*.jpg' | wc -l)
echo "Number of jpg files: ${jpgCount}"

rawCountWithoutJpg=0

for file in $(find ${DIR_ABS_PATH} -iname '*.orf'); do
  filename=$(basename -- "$file")
  filename="${filename%.*}"
  jpgNAME="${filename}.JPG"
  if [[ ! -f "${DIR_ABS_PATH}/${jpgNAME}" ]]; then
    rawCountWithoutJpg=$((rawCountWithoutJpg+1))
  fi
done

echo "Number of raw files without jpg: ${rawCountWithoutJpg}"

jpgCountWithoutRaw=0

for file in $(find ${DIR_ABS_PATH} -iname '*.jpg'); do
  filename=$(basename -- "$file")
  filename="${filename%.*}"
  orfNAME="${filename}.ORF"
  if [[ ! -f "${DIR_ABS_PATH}/${orfNAME}" ]]; then
    jpgCountWithoutRaw=$((jpgCountWithoutRaw+1))
  fi
done

echo "Number of jpg files without raw: ${jpgCountWithoutRaw}"

