output "launch_template_id" {
value = "${aws_launch_template.spot_fleet.id}"
}


output "latest_version" {
value = "${aws_launch_template.spot_fleet.latest_version}"
}

