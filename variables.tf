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

variable "ssh_access_ipv4" {
  type = list
  default = ["0.0.0.0/0"]
}

variable "ssh_access_ipv6" {
  type = list
  default = ["::/0"]
}