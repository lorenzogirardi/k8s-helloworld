#!/bin/bash

#set my account as a cluster admin
kubectl --context $1 create clusterrolebinding ethzero-gke-cluster-admin-binding \
--clusterrole=cluster-admin \
--user=lorenzo@ethzero.it

#deploy ingress and demo application based on this folder
for i in `ls -1|grep -v boot` ; do kubectl --context $1 apply -f $i && sleep 2 ;done

