provider "aws" {
  region     = var.vpc_region
  profile = "default"
  shared_credentials_files = ["${path.root}/aws_credentials"]
}

module "vpc" {
  source              = "./vpc"
  vpc_region          = var.vpc_region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  lambda_subnet_count = var.lambda_subnet_count
  rds_subnet_count    = var.rds_subnet_count
}

module "security_groups" {
  source              = "./security_groups"
  vpc_id              = module.vpc.vpc_id
}

module "rds" {
  source              = "./rds"
  vpc_region          =  var.vpc_region
  subnet_group_name   =  module.vpc.rds_subnet_group_name
  security_group_id   =  module.security_groups.planty_db_sg_id
  db_username         =  var.db_username
  db_password         =  var.db_password
}