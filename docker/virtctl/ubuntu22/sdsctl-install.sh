#!/bin/bash

function add-ceph-yum-repository()
{
cat <<EOF > /etc/yum.repos.d/ceph.repo
[ceph]
name=ceph
baseurl=http://mirrors.aliyun.com/ceph/rpm-nautilus/el7/x86_64/
gpgcheck=0
priority=1

[ceph-noarch]
name=cephnoarch
baseurl=http://mirrors.aliyun.com/ceph/rpm-nautilus/el7/noarch/
gpgcheck=0
priority=1

[ceph-source]
name=Ceph source packages
baseurl=http://mirrors.aliyun.com/ceph/rpm-nautilus/el7/SRPMS
enabled=0
gpgcheck=1
type=rpm-md
gpgkey=http://mirrors.aliyun.com/ceph/keys/release.asc
priority=1
EOF
}

function yum-ceph-install()
{
  yum install epel-release -y
  yum install ceph -y
  yum install nfs-utils -y
}

function apt-ceph-install()
{
  echo "6\n" | apt install ceph -y
}

install=""
osname=""
if [[ -n $(cat /etc/os-release | grep centos) ]]
then
  install="yum"
  osname="centos"
  add-ceph-yum-repository
  yum-ceph-install
elif [[ -n $(cat /etc/os-release | grep ubuntu) ]]
then
  install="apt"
  osname="ubuntu"
  apt-ceph-install
else
  echo "only support centos and ubuntu."
  exit 1
fi
