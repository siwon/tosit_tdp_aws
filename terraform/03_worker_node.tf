
locals {
  worker_instance_type = "t3a.nano"
}

module "ec2_worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  count = max(3,var.nb_worker)

  name = "srv-${var.project}-worker-${format("%03d", count.index)}-${terraform.workspace}"

  ami           = data.aws_ami.centos.id
  instance_type = local.worker_instance_type
  key_name      = aws_key_pair.main.key_name
  monitoring    = true
  vpc_security_group_ids = [
    module.sg_ssh.security_group_id
  ]
  subnet_id = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 125
      volume_size = 8
    },
  ]

  tags = {
    "data_disk_1_serial" = aws_ebs_volume.data_disk_1[count.index].id
  }
}

data "aws_ec2_instance_type" "ec2_worker" {
  instance_type = local.worker_instance_type
}

resource "aws_ebs_volume" "data_disk_1" {
  count = var.nb_worker

  availability_zone = module.vpc.azs[count.index % length(module.vpc.azs)]
  size              = var.data_disk_size
  iops              = 3000
  type              = "gp3"
  throughput        = 125
  encrypted         = true

  tags = {
    Name = "srv-${var.project}-worker-${format("%03d", count.index)}-data-01-${terraform.workspace}"
  }
}

resource "aws_volume_attachment" "data_disk_1" {
  count = var.nb_worker

  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.data_disk_1[count.index].id
  instance_id = module.ec2_worker[count.index].id
}
