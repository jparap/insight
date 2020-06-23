provider "aws" {
   shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
   region     = "us-west-2"
   #region     = var.region
}

terraform {
  backend "s3" {
    bucket = "cloudwork-tf"
    key = "infra.tfstate"
    region = "us-west-2"
    shared_credentials_file = "/Users/jparap1/terraform/insight/.insightcfg"
  }
}
