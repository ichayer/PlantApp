provider "aws" {
  region                   = var.region
  profile                  = "default"
  shared_credentials_files = ["${path.root}/aws_credentials"]
}

module "vpc" {
  source              = "./vpc"
  vpc_region          = var.region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  lambda_subnet_count = var.vpc_lambda_subnet_count
  rds_subnet_count    = var.vpc_rds_subnet_count
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source            = "./rds"
  subnet_group_name = module.vpc.rds_subnet_group_name
  security_group_id = module.security_groups.rds_sg_id
  db_name           = var.rds_db_name
  db_username       = var.rds_db_username
  db_password       = var.rds_db_password
}

module "s3" {
  source      = "./s3"
  bucket_name = var.s3_bucket_name
}

module "rds_proxy" {
  source               = "./rds_proxy"
  planty_db_identifier = module.rds.id
  security_group_id    = module.security_groups.rds_proxy_sg_id
  vpc_subnet_ids       = module.vpc.rds_subnet_ids
  db_secret_arn        = module.secrets.rds_secret_arn
  labrole_arn          = var.rds_proxy_iam_role_arn
}

module "secrets" {
  source      = "./secrets"
  db_name     = var.rds_db_name
  db_username = var.rds_db_username
  db_password = var.rds_db_password
}