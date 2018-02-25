#!/bin/bash

yum -y update
sudo yum install -y yum-utils
sudo yum install -y centos-release-scl
sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
#devtoolset-7 comes with gcc 7.2.1 and g++ 7.2.1
sudo yum install -y devtoolset-7
export PATH="/opt/rh/devtoolset-7/root/usr/bin:$PATH"
echo 'export PATH="/opt/rh/devtoolset-7/root/usr/bin:$PATH"' >> /etc/drydock/.env
scl enable devtoolset-7 bash
gcc --version
g++ --version


#Add this 3rd party repo to install clang-5.0.1
echo "[alonid-llvm-5.0.1]
name=Copr repo for llvm-3.9.0 owned by alonid
baseurl=https://copr-be.cloud.fedoraproject.org/results/alonid/llvm-5.0.1/epel-7-x86_64/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/alonid/llvm-5.0.1/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1" >> /etc/yum.repos.d/epel.repo

yum install clang-5.0.1 -y

export PATH=/opt/llvm-5.0.1/bin:$PATH
echo 'export PATH=/opt/llvm-5.0.1/bin:$PATH' >> /etc/drydock/.env

clang --version
