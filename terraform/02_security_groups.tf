
module "sg_ssh" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name        = "ssh-${var.project}-${terraform.workspace}"
  description = "Security group for SSH within VPC"
  vpc_id      = module.vpc.vpc_id

  use_name_prefix = false

  ingress_cidr_blocks = ["0.0.0.0/0"]
}
