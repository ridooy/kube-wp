#! /bin/bash
source config.sh

WP_DESIRED_COUNT=$(kubectl get deployment -n wordpress | grep wordpress | awk '{print $2}')
echo "Currently we have $WP_DESIRED_COUNT POD(s) wordpress \n"

echo "want to modify the count of wordpress pods? : "
read -p  "[y/n]" SCALE
echo "\n"

if [ "$SCALE" == "n" ]; then
  exit 0
elif [ "$SCALE" == "y" ]; then
  read -p "enter the new replica number: " NEWSCALE
  kubectl scale --replicas $NEWSCALE deployments $KUBE_NAMESPACE-$KUBE_NAME --namespace=$KUBE_NAMESPACE
fi