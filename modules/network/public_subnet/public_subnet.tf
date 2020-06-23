variable "name" {
  default = "public"
}

variable "vpc_id" {}
variable "cidrs" {}
variable "az1" {}
variable "env" {}
variable "id" {}
variable "subnetname-pub" {}
variable "az2" {}
variable "subnetname-pub-az-two" {}
variable "cidrs_2" {}

resource "aws_internet_gateway" "public" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs), count.index)}"
  availability_zone = "${element(split(",", var.az1), count.index)}"
  count             = "${length(split(",", var.cidrs))}"

  tags = {
    Name = "${var.env}-${var.id}-${element(split(",", var.subnetname-pub), count.index)}"
  }

  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}

resource "aws_subnet" "public1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs_2), count.index)}"
  availability_zone = "${element(split(",", var.az2), count.index)}"
  count             = "${length(split(",", var.cidrs_2))}"

  tags = {
    Name = "${var.env}-${var.id}-${element(split(",", var.subnetname-pub-az-two), count.index)}"
  }

  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}

#routetable creation
resource "aws_route_table" "public-az1" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags = {
    Name = "${var.env}-${var.id}-kp-rtable-public"
  }
}

#route table association
resource "aws_route_table_association" "public-az1" {
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-az1.id}"
}

#route table association
resource "aws_route_table_association" "public-az2" {
  count          = "${length(split(",", var.cidrs_2))}"
  subnet_id      = "${element(aws_subnet.public1.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-az1.id}"
}

#output subnet_id
output "subnet_ids" {
  value = "${join(",", aws_subnet.public.*.id)}"
}

output "subnet_ids_az2" {
  value = "${join(",", aws_subnet.public1.*.id)}"
}

#output public route table
output "public_route-table" {
  value = "${aws_route_table.public-az1.id}"
}
