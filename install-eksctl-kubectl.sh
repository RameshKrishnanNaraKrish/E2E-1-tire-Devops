#!/usr/bin/env bash

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz
# (Optional) Verify checksum
curl -sL https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt | grep
$PLATFORM | sha256sum --check
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
cp kubectl /usr/local/bin/

eksctl create cluster --name my-cluster --region us-east-1 --nodes 2 --node-type t3.medium --managed