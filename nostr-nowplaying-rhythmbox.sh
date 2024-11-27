#!/bin/bash

function sendMusicStatus() {
  title=$(rhythmbox-client --print-playing)
  if [ "$title" == " - " ]; then
    return
  fi
  title_enc=$(echo $title | jq -Rr '@uri')
  expiration=$(date -d'+5minutes' +%s)
  algia event --kind 30315 --content "$title" --tag d=music --tag expiration="$expiration" --tag r="spotify:search:$title_enc"
}

export -f sendMusicStatus

dbus-monitor --session "path=/org/mpris/MediaPlayer2,member=PropertiesChanged" --monitor |\
  stdbuf -i0 -oL grep PlaybackStatus |\
  xargs -i{} bash -c sendMusicStatus
