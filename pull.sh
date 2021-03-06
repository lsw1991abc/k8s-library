#!/bin/bash

file="images.properties"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS=':' read -r image_source version
  do
    echo "pull ${image_source}:${version} start..."
    image_target="lsw1991abc/${image_source:11}"
    docker pull "${image_target}":"${version}"
    docker tag "${image_target}":"${version}" "${image_source}":"${version}"
    echo "pull ${image_source}:${version} complete!"
  done < "$file"
else
  echo "$file not found."
fi

echo "all pull complete!"

