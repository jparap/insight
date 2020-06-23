# VPC
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

#EIP-for-openswan
#output "eip_address" {
#  value = "${module.vpc.eip-openswan-alloc-ip}"
#}
#
#output "eip_id" {
#  value = "${module.vpc.eip-openswan-alloc-id}"
#}

# public subnets
output "public_subnet_ids"  { value = "${module.public_subnet.subnet_ids}" }
output "public_subnet_ids_az2"  { value = "${module.public_subnet.subnet_ids_az2}" }

##route-table
#output "private_route-table" {
#  value = "${module.private_subnet.private_route-table}"
#}

output "public_route-table" {
  value = "${module.public_subnet.public_route-table}"
}

output "cloudops-http-SG" {
  value = "${module.securitygroup.cloudops-http}"
}
