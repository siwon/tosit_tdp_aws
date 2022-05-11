# TOSIT TDP deployment on AWS

Deploy a full [TDP](https://github.com/TOSIT-IO/tdp-getting-started/blob/master/deploy-all.yml) cluster on AWS.

## Requirements

- AWS Account
- Terraform
- Ansible
- Terraform configured to used AWS provider

## Quick Start

This steps will prepare the cluster for the TDP setup.

```bash
git clone https://github.com/siwon/tosit_tdp_aws.git
cd tosit_tdp_aws
make
```

Once this step are done, you can connect to the deployer instance and launch TDP setup :

```bash
ssh -i /tmp/ssh-private-key-tdp-default.pem admin@<EC2 DEPLOY IP>
cd tdp-getting-started
ansible-playbook deploy-all.yml
```

## Clean

In the `tosit_tdp_aws` folder :

```bash
make destroy
```

## TODO List

The TODO list is in the issue list :  [Enhancement issue list](https://github.com/siwon/tosit_tdp_aws/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)
