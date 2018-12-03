output "igw_id" {
  value       = "${aws_internet_gateway.gateway1.id}"
  description = "The ID of the Internet Gateway"
}

output "vpc_id" {
  value       = "${aws_vpc.vpc1.id}"
  description = "The ID of the VPC"
}

output "route_table_id" {
  value       = "${aws_vpc.vpc1.main_route_table_id}"
  description = "The ID of the main route table associated with this VPC."
}

output "security_group_id" {
  value       = "${aws_vpc.vpc1.default_security_group_id}"
  description = "The ID of the security group created by default on VPC creation"
}

output "private_subnet" {
  description = "List of IDs of private subnets"
  value       = "${aws_subnet.subnet1.id}"
}

output "public_subnet" {
  description = "List of IDs of private subnets"
  value       = "${aws_subnet.subnet2.id}"
}
