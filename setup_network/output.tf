#This file holds the output variables. These out variables required to use in compute and network modules and in VPN stage.
#Public Subnets
##NAT-AZ1 network interface id used in rt_tables
#output "nat_interface_id" {
#  value = "${module.compute.nat_interface_id}"
#}
#
##NAT-AZ2 network interface id used in rt_tables
#output "nat_interface_id-az2" {
#  value = "${module.compute.nat_interface_id-az2}"
#}

#output "priv-ip-nat" {
#  value = "${module.compute.priv-ip-nat}"
#}

#output "priv-ip-nataz2" {
#  value = "${module.compute.priv-ip-nataz2}"
#}
#
#output "tag_name_nat" {
#  value = "${module.compute.tag_name_nat}"
#}
#
#output "tag_name_nataz2" {
#  value = "${module.compute.tag_name_nataz2}"
#}
#
#VPC ID
output "vpc_id" {
  value = "${module.network.vpc_id}"
}

#VPC CIDR
output "vpc_cidr" {
  value = "${module.network.vpc_cidr}"
}

#Private route-table
#output "private_route_table_id" {
#  value = "${module.network.private_route-table}"
#}

#Public route-table
output "public_route_table_id" {
  value = "${module.network.public_route-table}"
}

output "region" {
  value = "${var.region}"
}

output "environment" {
  value = "${var.env}"
}

output "region-az1" {
  value = "${var.region-az1}"
}

output "region-az2" {
  value = "${var.region-az2}"
}

output "region-key" {
  value = "${var.region-key}"
}

#output "region-domain" {
#  value = "${var.region-domain}"
#}

output "region-zoneid" {
  value = "${var.region-zoneid}"
}

output "cloudops-public-subnets" { 
  value = "${module.network.public_subnet_ids}" 
} 

output "cloudops-public-subnets-az2" { 
  value = "${module.network.public_subnet_ids_az2}" 
} 
output "cloudops-http-sg" {
  value = "${module.network.cloudops-http-SG}"
}
