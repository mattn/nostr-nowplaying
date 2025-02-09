#!/bin/bash

spotify-current-playing | while read -r title; do
  title_enc=$(echo $title | jq -Rr '@uri')
  expiration=$(date -d'+5minutes' +%s)
  algia event --kind 30315 --content "$title" --tag d=music --tag expiration="$expiration" --tag r="spotify:search:$title_enc"
done
