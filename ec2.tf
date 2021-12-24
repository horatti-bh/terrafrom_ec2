data "terraform_remote_state" "vpc" {
  backend = "s3"
  config   = {
    bucket = var.bucket
    key    = "VPC/${var.env}/terraform.tfstate"
    region = "us-east-1"
  }
}

variable "bucket" {}
variable "key" {}
variable "env" {
  default = "dev"
}

resource "aws_instance" "fromvpc" {
  ami = "ami-0760b951ddb0c20c9"
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.vpc.outputs.SUBNET_ID
}
