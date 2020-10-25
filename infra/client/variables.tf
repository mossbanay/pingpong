variable "region" {}
variable "instance_type" { default = "t2.nano" }
variable "pub_key" {}

variable "amis" {
  default = {
    "af-south-1"     = "ami-0c46d08aa97038709"
    "ap-east-1"      = "ami-c6aeecb7"
    "ap-northeast-1" = "ami-05698dc45791b3927"
    "ap-northeast-2" = "ami-0a7df9a5e0a646e63"
    "ap-northeast-3" = "ami-0ad5f499cc4870457"
    "ap-south-1"     = "ami-041b909a9705d30ff"
    "ap-southeast-1" = "ami-08cd463d424f35eda"
    "ap-southeast-2" = "ami-0f64ce54f05977e95"
    "ca-central-1"   = "ami-0ad340a3355388c70"
    "cn-north-1"     = "ami-00cc446c1f9e0b72a"
    "cn-northwest-1" = "ami-05b363127143238ba"
    "eu-central-1"   = "ami-056114420b6ed624e"
    "eu-north-1"     = "ami-08d18dd6fa8bd7fe6"
    "eu-south-1"     = "ami-04ae6b3b18f5fa3ea"
    "eu-west-1"      = "ami-01aa664a17515f5bb"
    "eu-west-2"      = "ami-0ed4a9453b39ea8c1"
    "eu-west-3"      = "ami-05e451e12993709b7"
    "me-south-1"     = "ami-0d5d8c1f8b718abdb"
    "sa-east-1"      = "ami-0a517c1502073aad9"
    "us-east-1"      = "ami-07bfe0a3ec9dfcffa"
    "us-east-2"      = "ami-08f00d6a7c9dfdc7f"
    "us-west-1"      = "ami-0e42deec9aa2c90ce"
    "us-west-2"      = "ami-032ed93ef3b2a867c"
  }
}
