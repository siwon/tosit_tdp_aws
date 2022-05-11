
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.3.0"
    }
  }
  required_version = ">= 0.14.2"
}
