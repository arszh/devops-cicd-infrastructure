variable "aws_region"    { type = string  default = "eu-central-1" }
variable "instance_type" { type = string  default = "t3.micro" }
variable "key_name"      { type = string }
variable "ingress_cidr"  { type = string  default = "0.0.0.0/0" }
