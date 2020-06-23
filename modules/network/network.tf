module "vpc" {
  source     = "./vpc"
  env        = "${var.env}"
  id         = "${var.id}"
  cidr       = "${var.vpc_cidr}"
  zone_id    = "${var.region-zoneid}"
  create_eip = "${var.eip_creation}"
  vpc-state  = "${var.vpc-state}"
}

module "public_subnet" {
  source = "./public_subnet"

  name                  = "${var.name}-public"
  vpc_id                = "${module.vpc.vpc_id}"
  cidrs                 = "${var.public_subnets}"
  cidrs_2               = "${var.public_subnets-az-two}"
  az1                   = "${var.az1}"
  az2                   = "${var.az2}"
  env                   = "${var.env}"
  id                    = "${var.id}"
  subnetname-pub        = "${var.subnetname-pub}"
  subnetname-pub-az-two = "${var.subnetname-pub-az-two}"
}

#module "private_subnet" {
#  source               = "./private_subnet"
#  region               = "${var.region}"
#  name                 = "${var.name}-private"
#  vpc_id               = "${module.vpc.vpc_id}"
#  cidrs                = "${var.private_subnets}"
#  cidrs_2              = "${var.private_subnets-az-two}"
#  az1                  = "${var.az1}"
#  az2                  = "${var.az2}"
#  env                  = "${var.env}"
#  id                   = "${var.id}"
#  subnetname-priv      = "${var.subnetname}"
#  subnetname-az-two    = "${var.subnetname-az-two}"
#  nat_interface_id-az2 = "${var.nat_interface_id-az2}"
#  nat_interface_id     = "${var.nat_interface_id}"
#}

module "securitygroup" {
  source = "./securitygroup"
  vpc_id = "${module.vpc.vpc_id}"
  cidr   = "${var.vpc_cidr}"
  env    = "${var.env}"
  id     = "${var.id}"
}
