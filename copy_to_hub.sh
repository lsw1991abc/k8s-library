#!/bin/bash

file="images.properties"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS=':' read -r image_source version
  do
    echo "pull ${image_source}:${version} start..."
    image_target="lsw1991abc/${image_source:11}"
    docker pull "${image_source}":"${version}"
    docker tag "${image_source}":"${version}" "${image_target}":"${version}"
    docker push "${image_target}":"${version}"
    echo "copy ${image_source}:${version} complete!"
  done < "$file"
else
  echo "$file not found."
fi

echo "all copy complete!"

