#variable required for the vpc creation

variable "vpc-state" {}
variable "cidr" {}
variable "env" {}
variable "id" {}
variable "zone_id" {}
variable "create_eip" {}

#VPC creation block
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-${var.id}-${var.vpc-state}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#route53 Association of VPC with hosted zone
resource "aws_route53_zone_association" "vpcroute53" {
  zone_id = "${var.zone_id}"
  vpc_id  = "${aws_vpc.vpc.id}"
}

#EIP Allocation
#resource "aws_eip" "openswan-eip" {
#  vpc   = true
#  count = "${var.create_eip}"
#}

#output EIP
#EIP
#output "eip-openswan-alloc-id" {
#  value = "${aws_eip.openswan-eip.id}"
#}
#
#output "eip-openswan-alloc-ip" {
#  value = "${aws_eip.openswan-eip.public_ip}"
#}

#output variable for out source the different resources
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.vpc.cidr_block}"
}
