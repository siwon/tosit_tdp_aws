all: terraform-all copy-inventories ansible-all

############
# Terraform
############

terraform-all: terraform-init terraform-apply
	$(MAKE) -C terraform init

terraform-init:
	$(MAKE) -C terraform init

terraform-apply:
	$(MAKE) -C terraform apply

terraform-destroy:
	$(MAKE) -C terraform destroy

############
# Copy
############

copy-inventories:
	cp terraform/deployer-default.yml ansible/deployer-default.yml
	cp terraform/inventory-default.yml ansible/inventory-default.yml
	cp terraform/hosts-default.yml ansible/hosts-default.yml

############
# Ansible
############

ansible-all:
	$(MAKE) -C ansible all

############
# Clean
############

destroy: terraform-destroy
	rm -f ansible/deployer-default.yml
	rm -f ansible/inventory-default.yml
	rm -f ansible/hosts-default.yml
	rm -f terraform/deployer-default.yml
	rm -f terraform/inventory-default.yml
	rm -f terraform/hosts-default.yml
