#Variable declaration with default values for instance type and count, these values gets overrided by the values provided in .tfvars file

variable "env" {}
variable "id" {}
variable "region-key" {}
variable "region-zoneid" {}
variable "region-domain" {}

variable "region" {
  default = "us-west-2"
}

variable "region-az1" {
  default = "us-west-1a"
}

variable "region-az2" {
  default = "us-west-1b"
}

variable "private_subnets" {}
variable "public_subnets" {}
variable "private_subnets-az-two" {}
variable "public_subnets-az-two" {}
variable "vpc_cidr" {}
variable "subnetname" {}
variable "subnetname-pub" {}
variable "subnetname-az-two" {}
variable "subnetname-pub-az-two" {}
