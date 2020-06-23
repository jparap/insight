variable "region" {}
variable "volume_id" {default = ""}
variable "image_id" {}
variable "key_name" {}
variable "name_tag" {}
#variable "user_data" {}
variable "iam_arn" {}
variable "lt_name" {}
#variable "private_hosted_zone" {}
variable "security_group_id" {type="list"}
variable "name_instance" {}
variable "target_group_arn" { default = "xxxxxxxxx"}
variable "start_date" {default = "xxxx"}
variable "end_date" {default = "xxxx"}
variable "log_type" {default = "xxxx"}
variable "log_domain" {default = "xxxx"}
