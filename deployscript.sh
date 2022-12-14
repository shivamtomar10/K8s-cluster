sudo apt-get update
sudo apt-get -y upgrade

#installing docker 
sudo apt install -y docker.io


#for Debian distribution

#Update the apt package index and install packages needed to use the Kubernetes apt repository:
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curlkubectl taint nodes --all node-role.kubernetes.io/control-plane-

#Download the Google Cloud public signing key:
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

#Add the Kubernetes apt repository:
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

#Configure Kubernetes Master
kubeadm config images pull
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

export KUBECONFIG=/etc/kubernetes/admin.conf

#if [ $((id -u))==0]
#then 

#else
  #mkdir -p $HOME/.kube
  #sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 # sudo chown $(id -u):$(id -g) $HOME/.kube/config
#fi

#Install Flannel for the Pod Network (On Master Node)
kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

#Control plane node isolation 
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
