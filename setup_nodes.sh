#!/bin/bash

#Remove swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
