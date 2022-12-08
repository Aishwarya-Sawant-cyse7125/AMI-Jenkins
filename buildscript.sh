#!/bin/bash

echo "Assignment 1"

# Update packages
sudo apt -y update

echo "Packages update done"

# Install Java for Jenkins
sudo apt install openjdk-11-jre -y

# Install Jenkins LTS version
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y

sudo apt upgrade -y

sudo apt install jenkins -y
sudo systemctl status jenkins

sudo apt-get install nginx -y

sudo apt install certbot python3-certbot-nginx -y

# install python3 pip
sudo apt-get -y install python3-pip
pip3 --version

# install python-jenkins
pip install python-jenkins

# install docker
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo docker run hello-world

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
./get_helm.sh

# install kops
echo "KOPS"
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
sudo chmod +x kops
sudo mv kops /usr/local/bin/kops

# install kubectl
echo "KUBECTL"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# permissions for docker
sudo chmod 666 /var/run/docker.sock
# put jenkins in docker group
sudo usermod -a -G docker jenkins

# sudo chmod +x kubectl
# sudo mkdir -p ~/.local/bin
# sudo mv ./kubectl ~/.local/bin/kubectl

# kops install

# sudo systemctl enable jenkins
# sudo systemctl start jenkins
# sudo systemctl status jenkins