#!/bin/bash
#
# Part of k8s-scripts repository (https://github.com/tuladhar/k8s-scripts/)
#
TOP=10
NODE=$1
POD_PREFIX=trinity

LINES="$(kubectl describe node $NODE | grep $POD_PREFIX | awk '{print $1 " " $2 " " $5}' | sort | uniq | sort -rnk3 | head -n $TOP | tr ' ' '_')"

for LINE in ${LINES[@]}
do
  NAMESPACE=$(echo $LINE | awk -F_ '{print $1}')
  POD_NAME=$(echo $LINE | awk -F_ '{print $2}')
  MEM_USAGE=$(echo $LINE | awk -F_ '{print $3}')
  SERVICE_NAME=$(echo $POD_NAME | awk -F- '{print $2}')
  DEPLOYMENT_NAME=trinity-$SERVICE_NAME-deploy
  echo "kubectl -n $NAMESPACE rollout restart deploy $DEPLOYMENT_NAME # MEM: $MEM_USAGE"
done
