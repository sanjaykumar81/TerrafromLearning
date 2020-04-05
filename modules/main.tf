provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "sj-tf-state-bucket-uk"
    region = "eu-west-2"
    key = "sj-test-tf.tfstate"
  }
}

module "vpc_module" {
  source              = "./vpc_networking"
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  vpc_cidr_block      = var.vpc_cidr_block
}

module "s3-bucket" {
  source = "./storage"
}