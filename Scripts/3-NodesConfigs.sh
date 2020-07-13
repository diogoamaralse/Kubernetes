ssh jda@ubutu-node1

swapoff -a
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

sudo apt-get update
apt-cache policy kubelet | head -n 20 

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

#ON MASTER
#To get your token.
kubeadm token list

#To generate a new token
kubeadm token create

#To  find the ca cert hash.
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

#ON WORKER
#You need to change ip, token and CA
sudo kubeadm join 192.168.1.70:6443 \
    --token 9woi9e.gmuuxnbzd8anltdg \
    --discovery-token-ca-cert-hash sha256:f9cb1e56fecaf9989b5e882f54bb4a27d56e1e92ef9d56ef19a6634b507d76a9

#Back on master, this will say NotReady until the networking pod is created on the new node. Has to schedule the pod, then pull the container.
kubectl get nodes 

#On the master, watch for the calico pod and the kube-proxy to change to Running on the newly added nodes.
kubectl get pods --all-namespaces --watch

#Still on the master, look for this added node's status as ready.
kubectl get nodes

#GO BACK TO THE TOP AND DO THE SAME FOR c1-node2.
#Just SSH into c1-node2 and run the commands again.
ssh aen@c1-node2
#You can skip the token re-creation if you have one that's still valid.