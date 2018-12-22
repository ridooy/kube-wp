#! /bin/bash

source config.sh

helm delete --purge $KUBE_NAME
