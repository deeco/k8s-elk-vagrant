#!/bin/sh
echo vagrant up and install elk into kubernetes cluster
vagrant up
export KUBECONFIG=$PWD/kubernetes-setup/kubevagrantconfig/k8s-master/home/vagrant/.kube/config
kubectl patch nodes k8s-master -p '{"spec":{"taints":[]}}'
kubectl label nodes k8s-node-1 nodename=node1
kubectl label nodes k8s-node-2 nodename=node2
kubectl apply -f elk-install/elasticsearch/storage-class.yaml
kubectl apply -f elk-install/elasticsearch/es-pv.yaml
kubectl apply -f elk-install/elasticsearch/svc-escluster.yaml
kubectl apply -f elk-install/elasticsearch/service_account.yaml
sleep 10
kubectl apply -f elk-install/elasticsearch/es-deployment.yaml
sleep 20
kubectl apply -f elk-install/filebeat/service-account-filebeat.yaml
kubectl apply -f elk-install/filebeat/cluster-role-filebeat.yaml
kubectl apply -f elk-install/filebeat/cluster-role-bind.yaml
kubectl apply -f elk-install/filebeat/configmap-filebeat.yaml
kubectl apply -f elk-install/filebeat/deployment-filebeat.yaml
sleep 5
kubectl apply -f elk-install/logstash/configmap-logstash.yaml
kubectl apply -f elk-install/logstash/service-logstash.yaml
kubectl apply -f elk-install/logstash/deployment-logstash.yaml
sleep 5
kubectl apply -f elk-install/kibana/deployment-kibana.yaml
echo installing test webapps
sleep 10
kubectl apply -f namespaces/app_namespaces.yaml
#app1
kubectl apply -f app1/app_pod.yaml
#app2
kubectl apply -f app2/app2_svc.yaml
kubectl apply -f app2/app2_pod.yaml
echo #############################################################
sleep 5
echo #############################################################
echo install ingress
kubectl apply -f traefik-deployment/traefik-namespace.yaml
kubectl apply -f traefik-deployment/traefik-service-account.yaml
kubectl apply -f traefik-deployment/traefik-cluster-role.yaml
kubectl apply -f traefik-deployment/persistent-volume-test.yaml
kubectl apply -f traefik-deployment/persistent-volume-claim-test.yaml
kubectl apply -f traefik-deployment/traefik-secrets.yaml
kubectl apply -f traefik-deployment/traefik-config.yaml
kubectl apply -f traefik-deployment/traefik-dyn-config.yaml
kubectl apply -f traefik-deployment/traefik-deployment.yaml
kubectl apply -f traefik-deployment/traefik-service.yaml
echo get all resources
kubectl get all --all-namespaces