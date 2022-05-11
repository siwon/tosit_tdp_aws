all: ansible

ansible: ansible-deployer ansible-edge ansible-master ansible-worker

ansible-deployer:
	ansible-playbook -i deployer-default.yml playbook-deployer.yml

ansible-edge:
	ansible-playbook -i deployer-default.yml playbook-edge.yml

ansible-master:
	ansible-playbook -i deployer-default.yml playbook-master.yml

ansible-worker:
	ansible-playbook -i deployer-default.yml playbook-worker.yml
