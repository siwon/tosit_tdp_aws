
###########################
######### AMI
###########################

data "aws_ami" "centos" {
  most_recent = true
  name_regex  = "^CentOS.*"
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "debian" {
  most_recent = true
  name_regex  = "^debian-11-amd64-.*"
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

###########################
######### Credentials
###########################

resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main" {
  key_name   = "kp-${var.project}-${terraform.workspace}"
  public_key = tls_private_key.main.public_key_openssh
}
