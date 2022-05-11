
locals {
  keyfile_path = "/tmp/ssh-private-key-${var.project}-${terraform.workspace}.pem"
  tdp_default_username = "centos"
  deployer_default_username = "admin"
}

output "username" {
  value = local.tdp_default_username
}

output "keyfile" {
  value = local.keyfile_path
}

resource "local_file" "ssh-private-key" {
  content         = tls_private_key.main.private_key_pem
  filename        = local.keyfile_path
  file_permission = "0600"
}

resource "local_file" "deployer" {
  content = templatefile("deployer.tmpl",
    {
      hostname = module.ec2_deployer.tags_all.Name
      dns = module.ec2_deployer.public_dns
      deployer_username = local.deployer_default_username
      inventory_filename = local_file.inventory.filename
      hosts_filename = local_file.hosts.filename
      keyfile = local.keyfile_path
      edge_nodes = module.ec2_edge
      master_nodes = module.ec2_master
      worker_nodes = module.ec2_worker
      serial_disk_1 = aws_ebs_volume.data_disk_1
      tdp_username = local.tdp_default_username
      domain = var.project
      keyfile = local.keyfile_path
    }
  )
  filename = "deployer-${terraform.workspace}.yml"
}

resource "local_file" "inventory" {
  content = templatefile("inventory.tmpl",
    {
      edge_nodes = module.ec2_edge
      master_nodes = module.ec2_master
      worker_nodes = module.ec2_worker
      username = local.tdp_default_username
      domain = var.project
      keyfile = local.keyfile_path
    }
  )
  filename = "inventory-${terraform.workspace}.yml"
}

resource "local_file" "hosts" {
  content = templatefile("hosts.tmpl",
    {
      edge_nodes = module.ec2_edge
      master_nodes = module.ec2_master
      worker_nodes = module.ec2_worker
      edge_type = data.aws_ec2_instance_type.ec2_edge
      master_type = data.aws_ec2_instance_type.ec2_master
      worker_type = data.aws_ec2_instance_type.ec2_worker
      domain = var.project
    }
  )
  filename = "hosts-${terraform.workspace}.yml"
}
