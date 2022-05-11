
##########################
######## Provider aws
##########################

provider "aws" {
  default_tags {
    tags = {
      ENV       = terraform.workspace
      OWNER     = "https://github.com/siwon"
      LB_PROJET = var.project
    }
  }
}

##########################
######## Provider random
##########################

provider "random" {
}

##########################
######## Provider tls
##########################

provider "tls" {
}
