variable "name" {
  default = "private"
}

variable "vpc_id" {}
variable "cidrs" {}
variable "az1" {}
variable "env" {}
variable "id" {}
variable "subnetname-priv" {}
variable "subnetname-az-two" {}
variable "region" {}
variable "az2" {}
variable "cidrs_2" {}
variable "nat_interface_id" {}
variable "nat_interface_id-az2" {}

resource "aws_subnet" "private" {
  #region  = "${var.region}"  
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs), count.index)}"
  availability_zone = "${element(split(",", var.az1), count.index)}"
  count             = "${length(split(",", var.cidrs))}"

  tags = {
    Name = "${var.env}-${var.id}-${element(split(",", var.subnetname-priv), count.index)}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs_2), count.index)}"
  availability_zone = "${element(split(",", var.az2), count.index)}"
  count             = "${length(split(",", var.cidrs_2))}"

  tags = {
    Name = "${var.env}-${var.id}-${element(split(",", var.subnetname-az-two), count.index)}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#route_table creation

resource "aws_route_table" "private-az1" {
  vpc_id = "${var.vpc_id}"

#  route {
#    cidr_block           = "0.0.0.0/0"
#    network_interface_id = "${var.nat_interface_id}"
#  }

  tags = {
    Name = "${var.env}-${var.id}-kp-rtable-private"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#route_table association
resource "aws_route_table_association" "private-az1" {
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private-az1.id}"

  lifecycle {
    create_before_destroy = true
  }
}

#route_table association
resource "aws_route_table_association" "private-az2" {
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.private1.*.id, count.index)}"
  route_table_id = "${aws_route_table.private-az1.id}"

  lifecycle {
    create_before_destroy = true
  }
}


#output RT
output "private_route-table" {
  value = "${aws_route_table.private-az1.id}"
}

