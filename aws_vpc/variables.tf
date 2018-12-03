variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
}

variable "assign_generated_ipv6_cidr_block" {
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  default     = "private"
}

variable "private_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
}

variable "public_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  default     = {}
}

variable "enable_dns_hostnames" {
}

variable "enable_dns_support" {
}

variable "az" {
}

