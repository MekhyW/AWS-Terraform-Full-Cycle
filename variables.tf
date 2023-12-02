variable "vpc_cidr" {
    description = "CIDR block"
    type = string
    default = "10.0.0.0/16"
}

variable "sub_private_cidr" {
    description = "CIDR block"
    type = string
    default = "10.0.1.0/24"
}

variable "sub_public_cidr" {
    description = "CIDR block"
    type = string
    default = "10.0.2.0/24"
}

variable "sub_public_cidr_2" {
    description = "CIDR block"
    type = string
    default = "10.0.4.0/24"
}

variable "db_second_subnet" {
    description = "CIDR block"
    type = string
    default = "10.0.3.0/24"
}