variable "subnet_lb_ids" {
    description = "lb subnet ids"
    type = list(string)
}

variable "vpc_id" {
    description = "vpc id"
    type = string
}

variable "app_security_group" {
    description = "app security group"
    type = list(string)
}

variable "lb_security_group" {
    description = "lb security group"
    type = list(string)
}

variable "rds_endpoint" {
    description = "rds endpoint"
    type = string
}