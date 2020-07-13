#Open a PowerShell as Admin
Install-Module DockerMsftProvider -Force
Install-Package Docker -ProviderName DockerMsftProvider -Force

# Test your docker
docker container run hello-world:nanoserver

#Powershell as Admin
curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.18.0

#Join the node
#You need to change from your parameters (Ip/Token/Ca)
kubeadm join 192.168.1.86:6443 --token uicgg0.rquebhyvnuxulzar \
    --discovery-token-ca-cert-hash sha256:7179ceb25f1a2936769d524e5a7bed4a82147a88d9422ed2f4ad7b45a9cea689

#validate your installation
kubectl get nodes -o wide

#If your new node is in the NotReady state it is likely because the flannel image is still downloading. 
#You can check the progress as before by checking on the flannel pods in the kube-system namespace
kubectl -n kube-system get pods -l app=flannel