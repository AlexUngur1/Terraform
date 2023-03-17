# variable "vms" {
#    # environments = {
#       # dev = {
#          VM1 = {
#             name  = "work2"
#             ami = "ami-0233214e13e500f77"
#             instance = "t2.micro"
#          }
#          VM2 = {
#             name  = "work2"
#             ami = "ami-0233214e13e500f77"
#             instance = "t2.micro"
#          }
#       # }
#    # }
# }
variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}

variable "vm_flavor" {
  description = "Flavor of the VM"
  type        = string
  default     = "t2.micro"
}

variable "vm_image" {
  description = "AMI ID of the VM"
  type        = string
  default     = "ami-0c94855ba95c71c99"
}