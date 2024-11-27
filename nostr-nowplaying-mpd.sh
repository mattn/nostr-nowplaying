#!/bin/bash

MPD_HOST="${MPD_HOST:-127.0.0.1}"

while true; do
  title=$(mpc -h $MPD_HOST current --wait 2> /dev/null)
  if [ "$title" == "" ]; then
    sleep 3
    continue
  fi
  title_enc=$(echo $title | jq -Rr '@uri')
  expiration=$(date -d'+5minutes' +%s)
  algia event --kind 30315 --content "♫ $title" --tag d=music --tag expiration="$expiration" --tag r="spotify:search:$title_enc"
done
