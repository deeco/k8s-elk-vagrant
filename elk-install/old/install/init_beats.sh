#!/bin/sh -xv

# Run metricbeat setup and wait for it to complete
kubectl create -f $HOME/elastic/kubevagrant/elk-install/metricbeat/metricbeat-setup.yml
# Run filebeat setup and wait for it to complete
kubectl create -f $HOME/elastic/kubevagrant/elk-install/filebeat/filebeat-setup.yml
# Run packetbeat setup and wait for it to complete
kubectl create -f $HOME/elastic/kubevagrant/elk-install/packetbeat/packetbeat-setup.yml

kubectl wait --for=condition=complete job/metricbeat-init --namespace=kube-system --timeout=30m
kubectl wait --for=condition=complete job/filebeat-init --namespace=kube-system --timeout=30m
kubectl wait --for=condition=complete job/packetbeat-init --namespace=kube-system --timeout=30m
