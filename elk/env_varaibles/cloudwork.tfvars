/*************************************************
#          Launch template Varibale              #
*************************************************/
volume_id=""
region = "us-west-2"
image_id = "ami-06583a57aa5a2803f"
key_name = "cloudwork"
name_tag = "test-cloudwork-elk"
instance_tag = "test-cloudwork-instance"
user_data = ""
###
iam_arn =   "s3full_inst_profile"
security_group_id = ["sg-085d82aebc1c012ef"]
subnet_id = "subnet-007550c68a811c380"
lt_name="CLOUDWORK-ELK-LT-1"
##USER DATA
private_hosted_zone = "Z00015492OPD9EF43JQ3Q"
/* *******************************
#         Ec2 Variables          #
*********************************/
instance_type1 = "m4.xlarge"
instance_type2 = "r3.xlarge"
instance_type3 = "r4.xlarge"
total_target = "1"
total_spot = "1"
