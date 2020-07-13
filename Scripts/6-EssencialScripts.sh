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
