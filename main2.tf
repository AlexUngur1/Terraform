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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_instance" "my_instance" {
  count         = var.vm_count
  ami           = var.vm_image
  instance_type = var.vm_flavor
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name = "my-vm-${count.index}"
  }
}

resource "random_password" "vm_password" {
  length  = 16
  special = true
  override_special = "/\\()\"'"
  count   = var.vm_count
}

resource "null_resource" "ping_vms" {
  count = length(aws_instance.my_instance)

  triggers = {
    next_index = (count.index + 1) % length(aws_instance.my_instance)
  }

  provisioner "local-exec" {
    command = "ping -c 5 ${aws_instance.my_instance[triggers.next_index].private_ip} > /tmp/ping_${count.index}.txt || true"
  }
}

output "ping_results" {
  value = [
    for f in fileset(".", "ping_*.txt") :
    {
      filename = f
      contents = file(f)
    }
  ]
}