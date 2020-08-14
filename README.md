# k8s-elk-vagrant
Kuberenetes cluster deployment using vagrant, ansible for elk stack and 2 apps with traefik , this will be used to auth kibana from frontend.

## Dependancies
Tested and verfied on macbook pro , min RAM requirements 16GB and Quad Core processor, may be run with less but will require update to Vagrantfile to lower node requirements. elastic will not start without sufficient RAM available.

Tools required to be installed for setup to run correctly.

- Virtualbox installation from https://download.virtualbox.org/virtualbox/6.1.12/VirtualBox-6.1.12-139181-OSX.dmg
- Vagrant installation https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.dmg

## Installation and setup

To run setup clone repo and browse to root directory and run setup.sh from command line, this should run the following.
- run setup.sh from root directory

This will do the following

- vagrant up to bring up k8s clusters with number of nodes, to decrease or increase node amounts, please update the N Value in the VagrantFile https://github.com/deeco/k8s-elk-vagrant/blob/3197f44f4a7c9b711de00acfaf830c9aea889a87/VagrantFile#L3
- helm install each component and service of elk stack , test apps and trafeik. 
* trafiek can be updated or run separetly using the setup_traefik shell script also https://github.com/deeco/k8s-elk-vagrant/blob/master/setup_traefik.sh

## Access to Stack and apps

Access to elastic , kibana, apps and trafiek are all done directly via Nodeport as no lb in place or access to cluster IP as vagrant uses multiple eth interfaces.

* To access kibana use url 
* To access and verify Elastic http://192.168.50.11:30601/

## Remove Environment

Run following command 
* vagrant destroy -f
