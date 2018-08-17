#!/bin/bash

file="images.properties"

if [ -f "$file" ]
then
  echo "$file found."

  while IFS='=' read -r key value version
  do
    #echo "${key}=${value}"
    echo "pull ${value}:${version} start..."
    docker pull ${value}:${version}
    docker tag ${value}:${version} ${key}:${version}
    # 开发使用，暂不清理。避免重复下载浪费时间
    # docker rmi ${value}
    echo "pull ${value}:${version} complete!"
  done < "$file"
else
  echo "$file not found."
fi

echo "all complete!"