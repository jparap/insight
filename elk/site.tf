provider "aws" {
   shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
   region     = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "cloudwork-tf"
    key = "spotfleet.tfstate"
    region = "us-west-2"
    shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
  }
}

module "lt"{
    lt_name= "${var.lt_name}"
    source = "../modules/launch_template"
    region = "${var.region}"
    image_id = "${var.image_id}"
    key_name = "${var.key_name}"
    name_tag = "${var.name_tag}"
    name_instance = "${var.instance_tag}"
  #  user_data = "${var.user_data}"
  #  iam_arn = "${var.iam_arn}"
    iam_arn = "s3full_inst_profile"
    security_group_id = "${var.security_group_id}"
}

module "spot_fleet"{
    source = "../modules/ec2_spot_fleet"
    region = "${var.region}"
    name_instance = "${var.instance_tag}"
    instance_type1 = "${var.instance_type1}"
    instance_type2 = "${var.instance_type2}"
    instance_type3 = "${var.instance_type3}"
    total_target =  "${var.total_target}"
    total_spot  = "${var.total_spot}"
    lt_id   =   "${module.lt.launch_template_id}"
    lt_version   =   "${module.lt.latest_version}"
    subnet_id = "${var.subnet_id}"
}

output "fleet_id" {
    value = "${module.spot_fleet.ec2_fleet_id}"
}

output "lt_id" {
    value = "${module.lt.launch_template_id}"
}
