# k8s-library
用于记录K8S配置的镜像信息。主要解决天国无法正常拉取的问题。

当前Kubernetes使用版本 v1.16.0


## 拉取镜像

```bash
./pull.sh
```

## kubeadm初始化

```bash
kubeadm init --kubernetes-version=v1.16.0 --apiserver-advertise-address=HOST_IP --token=abcdef.0123456789abcdef --token-ttl=0 --pod-network-cidr=10.244.0.0/16
```

## Flannel

略

## Dashboard

### 命名空间

```bash
kubectl create namespace kubernetes-dashboard
```

### 手动创建证书

```bash
mkdir /data/k8s/certs
cd /data/k8s/certs
openssl genrsa -out dashboard.key 2048
openssl rsa -in dashboard.key -out dashboard.key
openssl req -sha256 -new -key dashboard.key -out dashboard.csr -subj '/CN=localhost'
openssl x509 -req -sha256 -days 365 -in dashboard.csr -signkey dashboard.key -out dashboard.crt
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt -n kubernetes-dashboard
```

### 创建dashboard的deployment和service

```bash
kubectl create -f kubernetes-dashboard.yaml
```

### 创建用于登录使用的token

```bash
kubectl create -f dashboard-adminuser.yaml
```

### 获取登录使用的token

```bash
kubectl create serviceaccount dashboard-admin -n kube-system
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin
kubectl describe secrets -n kubernetes-dashboard $(kubectl -n kubernetes-dashboard get secret | awk '/dashboard-admin/{print $1}')
```

### 浏览器证书

Dashboard 2.0.0-betaX(1-6) 部署后访问提示 `Your connection is not private`

默认自己创建的是过期的证书，所以需要手动创建。但手动创建的浏览器并不识别，需要将证书导入本地并设置信任才可以使用

参考链接: [https://www.andrewconnell.com/blog/updated-creating-and-trusting-self-signed-certs-on-macos-and-chrome/](https://www.andrewconnell.com/blog/updated-creating-and-trusting-self-signed-certs-on-macos-and-chrome/)
