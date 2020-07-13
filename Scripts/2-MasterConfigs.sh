#Configuration
wget https://docs.projectcalico.org/manifests/calico.yaml

sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f calico.yaml

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#Commands to validate
kubectl get nodes 
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces --watch
kubectl get pods --all-namespaces

sudo systemctl status kubelet.service 

ls /etc/kubernetes
ls /etc/kubernetes/manifests

sudo more /etc/kubernetes/manifests/etcd.yaml
sudo more /etc/kubernetes/manifests/kube-apiserver.yaml
