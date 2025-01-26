#!/bin/bash

# eval YOUTUBE_URL=\${$#}
#
# echo "Downloading \"$YOUTUBE_URL\""
#
# if [[ -z "$YOUTUBE_URL" ]]; then
#   echo "YouTube URL was not provided"
#   exit
# fi
#
# DL_DIR_NAME_RAW=$(
#   yt-dlp \
#     --print \
#     --output="%(title)s" \
#     "$YOUTUBE_URL"
# )
#
# DL_DIR_NAME=$(echo "$DL_DIR_NAME_RAW" | sed 's|--output=||' | sed 's|.$||')
#
# echo "Output will be written to \"$DL_DIR_NAME\""
#
# mkdir -p "$DL_DIR_NAME"
# cd "$DL_DIR_NAME"

yt-dlp \
  -x \
  -o "/home/nimitz/Audio/%(playlist)/%(title).200B.%(ext)s" \
  -o "chapter:/home/nimitz/Music/%(playlist)s/%(title)s/%(section_title)s.%(ext)s" \
  --split-chapters \
  "$@"
