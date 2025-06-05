variable "vpc_cidr" {
    type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "count_jenkins_server" {
    type = number
    default = 3
}