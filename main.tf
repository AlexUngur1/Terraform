terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

#   for_each = toset(var.ec2_instances)
    for_each = local.environments["dev"]
  name = each.value.name

  ami                    = each.value.ami
  instance_type          = each.value.instance
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

locals{
   environments = {
      dev = {
         "VM1" = {
            name  = "work2"
            ami = "ami-0233214e13e500f77"
            instance = "t2.micro"
         }
         "VM2" = {
            name  = "work2"
            ami = "ami-0233214e13e500f77"
            instance = "t2.micro"
         }
      }
   }
}