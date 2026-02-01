variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing key value pair name"
}

variable "ami_id" {
  description = "Amazon linux ami ID"
}
