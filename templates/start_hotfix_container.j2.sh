#!/bin/bash -x

if ! $(echo $PWD | egrep -q '/scripts$'); then
  echo "This file needs to be executed from directory scripts"
  exit 1
fi 

ORIGINAL_TAG=$(docker images | grep "{{ container_registry }}/{{ container_image_name }}" | grep -v hotfix | awk 'NR==1{print $2}')
HOTFIX_TAG=$(docker images | grep "{{ container_registry }}/{{ container_image_name }}" | awk 'NR==1{print $2}')

ORIGINAL_IMAGE={{ container_registry }}/{{ container_image_name }}:$ORIGINAL_TAG
HOTFIX_IMAGE={{ container_registry }}/{{ container_image_name }}:$HOTFIX_TAG

mkdir /tmp/docker_backup
cp /var/lib/tripleo-config/docker-container-startup-config-step_4.json /tmp/docker-container-startup-config-step_4.${HOTFIX_TAG}.json

sed -i "s#\"${ORIGINAL_IMAGE}\"#\"${HOTFIX_IMAGE}\"#" /tmp/docker-container-startup-config-step_4.${HOTFIX_TAG}.json

docker stop {{ container_name }}
paunch debug --action run --file /tmp/docker-container-startup-config-step_4.${HOTFIX_TAG}.json --container {{ container_name }}
