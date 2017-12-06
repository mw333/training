#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-fcc4db98
#
# Your subnet ID is:
#
#     subnet-fd3241b0
#
# Your security group ID is:
#
#     sg-a2c975ca
#
# Your Identity is:
#
#     terraform-training-moose
#
terraform {
  backend "atlas" {
    name = "mjw333/training"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "num_webs" {
  default = "3"
}

resource "aws_instance" "web" {
  count = "${var.num_webs}"

  #  access_key  = "${aws.access_key}"
  #  secret_key = "${aws.secret_key}"
  #  region     = "${aws.region}"
  ami = "ami-fcc4db98"

  instance_type          = "t2.micro"
  subnet_id              = "subnet-fd3241b0"
  vpc_security_group_ids = ["sg-a2c975ca"]

  tags {
    "Identity"    = "terraform-training-moose"
    "Foo"         = "bar"
    "  fjfjfjfj " = "woosh"
    "Name"        = "web ${1+count.index}/${var.num_webs}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
