provider "aws" {
  region                   = var.region
  profile                  = "default"
  shared_credentials_files = ["${path.root}/aws_credentials"]
}