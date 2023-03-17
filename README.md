### Bosch Terraform task
variables:
vm_count = Number of VMs to create
vm_flavor = Flavor of the VM
vm_image = AMI ID of the VM

This code deploys by default 2 VMs of t2.micro type and ami-0233214e13e500f77.
Firstly, I create the VPC and Subnet on which the instances will be deployed. Afterwards, I deployed the VMs using the resource "aws_instance" and the variables. 
The passwords for each VM was created automatically using resource "random_password"
For pinging the VMs in a round-robin fashion I used the "null_resource". 