provider "aws" {
   shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
   region     = "${var.region}"
}

resource "aws_ec2_fleet" "ec2_spot"{
    terminate_instances = "true"
    excess_capacity_termination_policy = "termination"
    replace_unhealthy_instances="true"
    tags = {
      Name = "${var.name_instance}"
    }
    spot_options {
        allocation_strategy = "diversified"
    }

    launch_template_config {
        launch_template_specification{
            launch_template_id = "${var.lt_id}"
						version            = "${var.lt_version}"
        }
        override {
            instance_type     = "${var.instance_type1}"
            priority          = 0
            subnet_id         = "${var.subnet_id}"
						max_price		   = "${var.spot_price}"
        }
        override {
            instance_type     = "${var.instance_type2}"
            subnet_id         = "${var.subnet_id}"
            priority          = 1
						max_price		   = "${var.spot_price}"
        }
        override {
            instance_type     = "${var.instance_type3}"
            priority          = 2
            subnet_id         = "${var.subnet_id}"
						max_price		   = "${var.spot_price}"
            #root_block_device { delete_on_termination = true }
        }
    }


    target_capacity_specification{
        default_target_capacity_type = "spot"
        total_target_capacity = "${var.total_target}"
        spot_target_capacity  = "${var.total_spot}"
    }
}


output "ec2_fleet_id" {
    value = "${aws_ec2_fleet.ec2_spot.id}"
}
