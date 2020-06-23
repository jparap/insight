resource "aws_launch_template" "spot_fleet"{
    name = "${var.lt_name}"
    image_id="${var.image_id}"
    key_name="${var.key_name}"
    tags = { Name="${var.name_tag}" }
    tag_specifications {
         resource_type = "instance"
      tags = {
          Name = "${var.name_instance}"
          Creator = "Terraform"
        }
    }
    #user_data = "${base64encode(data.template_file.init.rendered)}"
    iam_instance_profile { name = var.iam_arn}
    #vpc_security_group_ids = ["${var.security_group_id}"]
    vpc_security_group_ids = "${var.security_group_id}"
}

#data "template_file" "init"{
#    template="${file("${var.user_data}")}"
#    vars{
#				VOLUME_ID = "${var.volume_id}"
#        HOST_NAME = "${var.host_name}"
#        PRIVATE_HOSTED_ZONE = "${var.private_hosted_zone}"
#        TG_ARN = "${var.target_group_arn}"
#        REGION     = "${var.region}"
#	START_DATE= "${var.start_date}"
#        END_DATE= "${var.end_date}"
#        LOG_TYPE= "${var.log_type}"
#        LOG_DOMAIN= "${var.log_domain}"
#    }
#}
