provider "aws" {
  region     = var.vpc_region
  profile = "default"
  shared_credentials_files = ["${path.root}/aws_credentials"]
}

module "vpc" {
  source              = "./vpc"
  vpc_region          = var.vpc_region
  vpc_name            = "planty-vpc"
  vpc_cidr            = "10.0.0.0/16"
  lambda_subnet_count = 2
  rds_subnet_count    = 2
}
