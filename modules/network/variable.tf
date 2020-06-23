#variable "nat_interface_id" {}
#variable "nat_interface_id-az2" {}
variable "name" {
  default = "cloudops"
}
variable "vpc-state" {}
variable "eip_creation" {}
variable "vpc_cidr" {}
variable "az1" {}
variable "az2" {}
variable "region" {}
variable "private_subnets" {}
variable "subnetname" {}
variable "public_subnets" {}
variable "subnetname-pub" {}
#for second-AZ
variable "private_subnets-az-two" {}
variable "subnetname-az-two" {}
variable "public_subnets-az-two" {}
variable "subnetname-pub-az-two" {}
variable "key_name" {
  default = "cloudops"
}
variable "env" {}
variable "id" {}
variable "region-zoneid" {}
