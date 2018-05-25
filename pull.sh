#!/bin/bash

# images=$(docker images --format "{{.Repository}}:{{.Tag}}" | awk -F '/' '{split($0,a,"/");print a[2]}')

images=( \
	[0]="kube-proxy-amd64:v1.10.3" \
	[1]="kube-controller-manager-amd64:v1.10.3" \
	[2]="kube-apiserver-amd64:v1.10.3" \
	[3]="kube-scheduler-amd64:v1.10.3" \
	[4]="etcd-amd64:3.1.12" \
	[5]="pause-amd64:3.1")

for image in ${images[@]}
do
    echo "pull ${image} start..."
    docker pull lsw1991abc/${image}
    docker tag lsw1991abc/${image} k8s.gcr.io/${image}
    # 开发使用，暂不清理。避免重复下载浪费时间
    # docker rmi lsw1991abc/${image}
    echo "pull ${image} complete!"
done

echo "all complete!"