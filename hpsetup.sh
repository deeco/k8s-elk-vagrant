#!/bin/sh
echo install awx operator into kubernetes cluster
export KUBECONFIG=$PWD/kubernetes-setup/hpconfig
kubectl apply -f namespaces/awx_namespaces.yaml
kubectl apply -f https://raw.githubusercontent.com/deeco/awx-operator/devel/deploy/awx-operator.yaml
sleep 30
echo get all resources
kubectl get all --all-namespaces
kubectl apply -f awx_install/awx_storage_class.yaml
kubectl apply -f awx_install/awx_pv.yaml
kubectl apply -f awx_install/awx_install.yaml
sleep 15
kubectl patch svc awx-service -n ansible-awx -p '{"spec": {"type": "NodePort"}}'
kubectl describe service/awx-service -n ansible-awx
