variable "aws_region" {
  type = string
}
variable "instance_type" {
    type    = string
    default = "t2.nano"
}

variable "ami" {
  type = string
}

variable "public_key" {
  type = string
}

variable "user_data_path" {
  type    = string
  default = "laravel_module/script.sh"
}