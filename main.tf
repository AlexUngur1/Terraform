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
  name = try(each.value.name, "vm-${random_string.random_name.result}")

  ami                    = try(each.value.ami, "ami-0233214e13e500f77")
  instance_type          = try(each.value.instance, "t2.micro")
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
            name  = "work1"
            ami = "ami-0233214e13e500f77"
            instance = "t2.micro"
         }
         "VM2" = {
            name  = "work2"
            ami = "ami-0233214e13e500f77"
            instance = "t2.micro"
         }
         "VM3" = {
            # name  = "work3"
            instance = "t2.micro"
         }
      }
   }
}

resource "random_string" "random_name" {
  length           = 16
  special          = true
  override_special = "/@£$"
}