all: init apply

init:
	terraform init

apply:
	terraform apply -auto-approve || terraform apply -target aws_ebs_volume.data_disk_1 -auto-approve && terraform apply -target module.ec2_edge -target module.ec2_master -target module.ec2_worker -auto-approve && terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

clean:
	rm -f super-linter.log
	rm -rf .terraform
	rm -f .terraform.lock.hcl
