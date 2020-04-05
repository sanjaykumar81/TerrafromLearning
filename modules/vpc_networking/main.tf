provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "sj_tf_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "sj-tf-vpc"
  }

}

resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr
  vpc_id = aws_vpc.sj_tf_vpc.id
  tags = {
    Name = "sj_tf_public_subnet"
  }
}


resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr
  vpc_id = aws_vpc.sj_tf_vpc.id
  tags = {
    Name = "sj_tf_private_subnet"
  }
}