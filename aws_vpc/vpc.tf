resource "aws_vpc" "vpc1" {
  cidr_block                       = "${var.cidr}"
  instance_tenancy                 = "${var.instance_tenancy}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  enable_dns_support               = "${var.enable_dns_support}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"

  tags = "${merge(map("Name", format("%s", var.name)), var.tags, var.vpc_tags)}"
}

resource "aws_subnet" "subnet1" {
    vpc_id = "${aws_vpc.vpc1.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "${var.az}"

    tags {
        Name = "Private Subnet"
    }
}
resource "aws_subnet" "subnet2" {
    vpc_id = "${aws_vpc.vpc1.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${var.az}"
    map_public_ip_on_launch = true
    tags {
        Name = "Public Subnet"
    }
}

resource "aws_internet_gateway" "gateway1" {
    vpc_id = "${aws_vpc.vpc1.id}"
    depends_on = ["aws_subnet.subnet2"]
}

resource "aws_route" "route1" {
    route_table_id = "${aws_vpc.vpc1.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway1.id}" 
    depends_on = ["aws_internet_gateway.gateway1"]
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.vpc1.id}"
  depends_on = ["aws_route.route1"]
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
