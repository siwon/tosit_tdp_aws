
module "ec2_deployer" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "srv-${var.project}-deployer-${terraform.workspace}"

  ami           = data.aws_ami.debian.id
  instance_type = "t3a.nano"
  key_name      = aws_key_pair.main.key_name
  monitoring    = true
  vpc_security_group_ids = [
    module.sg_ssh.security_group_id
  ]
  subnet_id = module.vpc.public_subnets[0]

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 125
      volume_size = 8
    },
  ]
}
