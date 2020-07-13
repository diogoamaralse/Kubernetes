#Setup 
#Ubuntu 18.04.1.0

swapoff -a

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

sudo apt-get update
apt-cache policy kubelet | head -n 20 
apt-cache policy docker.io | head -n 20 

sudo apt-get install -y docker.io kubelet kubeadm kubectl
sudo apt-mark hold docker.io kubelet kubeadm kubectl


sudo systemctl status kubelet.service 
sudo systemctl status docker.service 

sudo systemctl enable kubelet.service
sudo systemctl enable docker.service

sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF'

sudo systemctl daemon-reload
sudo systemctl restart docker
