
module "ec2_edge" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = max(1,var.nb_edge)

  name = "srv-${var.project}-edge-${format("%03d", count.index)}-${terraform.workspace}"

  ami           = data.aws_ami.centos.id
  instance_type = var.edge_instance_type
  key_name      = aws_key_pair.main.key_name
  monitoring    = true
  vpc_security_group_ids = [
    module.sg_ssh.security_group_id
  ]
  subnet_id = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 125
      volume_size = 8
    },
  ]
}

data "aws_ec2_instance_type" "ec2_edge" {
  instance_type = var.edge_instance_type
}
