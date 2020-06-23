provider "aws" {
   shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
   region     = var.region
}

terraform {
  backend "s3" {
    bucket = "cloudwork-tf"
    key = "ec2.tfstate"
    region = "us-west-2"
    shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
  }
}

resource "aws_iam_role" "cloudwork_s3_full" {
  name               = "cloudworks3fullaccess"
  assume_role_policy = file("policies/s3role.json")
}

resource "aws_iam_policy_attachment" "s3full_attach" {
  name       = "s3full_attach"
  roles      = [aws_iam_role.cloudwork_s3_full.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "s3full_ip" {
  name  = "s3full_inst_profile"
  path  = "/"
  role = "${aws_iam_role.cloudwork_s3_full.name}"
}

resource "aws_iam_role" "s3readonlyaccess" {
  name = "s3readonlyaccess"
  assume_role_policy = file("policies/s3role.json")
}
resource "aws_iam_policy_attachment" "s3readonly_attach" {
  name       = "s3readonly_attach"
  roles      = [aws_iam_role.s3readonlyaccess.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "s3readonly_ip" {
  name  = "s3readonly_inst_profile"
  path  = "/"
  role = "${aws_iam_role.s3readonlyaccess.name}"
}


#==========================
output "iam_role_s3full" {
  value = "${aws_iam_instance_profile.s3full_ip.name}"
}
