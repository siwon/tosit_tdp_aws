all: ansible

ansible: ansible-deployer ansible-tdp-nodes

ansible-deployer:
	ansible-playbook -i deployer-default.yml playbook-deployer.yml

ansible-tdp-nodes:
	ansible-playbook -i deployer-default.yml playbook-tdp-nodes.yml
