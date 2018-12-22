#! /bin/bash

source config.sh

echo “spinning up wordpress” \n

helm install --name=$KUBE_NAMESPACE --namespace=$KUBE_NAMESPACE \
    --set wordpressUsername=$WP_USERNAME,wordpressPassword=$WP_PASSWD,mariadb.mariadbRootPassword=$DB_PASSWD \
    stable/wordpress > install_log.txt

echo "wait a sec till ALB is created"
sleep 10

SERVICE_URL=$(kubectl get svc --namespace wordpress wordpress-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
echo "Wordpress is ready, visit the page using this link \n"
echo "http://$SERVICE_URL"
echo "http://$SERVICE_URL/admin"

