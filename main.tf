terraform {
    required_providers {
        aws = {
        version = "5.98.0"
        source = "hashicorp/aws"
        } 
    }
 
}

data "aws_ami" "amazon-linux-ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20250527.1-x86_64-gp2"]
  }
}


data "aws_vpc" "default_VPC" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

data "aws_subnets" "jenkins_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_VPC.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_security_group" "jenkins_sg" {
  filter {
    name   = "group-name"
    values = ["My-Jenkins-SG"]  
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_VPC.id]
  }
}