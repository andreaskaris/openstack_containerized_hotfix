#!/bin/bash -x

if ! $(echo $PWD | egrep -q '/scripts$'); then
  echo "This file needs to be executed from directory scripts"
  exit 1
fi 

: ${IMAGE_TAG:=$(docker images | grep "{{ container_registry }}/{{ container_image_name }}" | awk 'NR==1{print $2}')}

git clone https://github.com/openstack/ansible-role-tripleo-modify-image
mkdir ansible-role-tripleo-modify-image/roles
ln -s $PWD/ansible-role-tripleo-modify-image $PWD/ansible-role-tripleo-modify-image/roles/tripleo-modify-image
rm -Rf /tmp/hotfix
mkdir /tmp/hotfix
cp ../rpms/*.rpm /tmp/hotfix
cp hotfix.yaml $PWD/ansible-role-tripleo-modify-image
cd $PWD/ansible-role-tripleo-modify-image
ansible-playbook -e image_tag=$IMAGE_TAG hotfix.yaml
