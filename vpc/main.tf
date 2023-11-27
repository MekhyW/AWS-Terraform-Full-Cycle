resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

data "aws_availability_zones" "zones" {
  state = "available"
}

resource "aws_subnet" "sub_private" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_private_cidr
    availability_zone = data.aws_availability_zones.zones.names[0]
    map_public_ip_on_launch = false
}

resource "aws_subnet" "sub_db_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.db_second_subnet
    availability_zone = data.aws_availability_zones.zones.names[1]
    map_public_ip_on_launch = false
}

resource "aws_subnet" "sub_public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_public_cidr
    availability_zone = data.aws_availability_zones.zones.names[0]
    map_public_ip_on_launch = true
}

resource "aws_subnet" "sub_public_2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.sub_public_cidr_2
    availability_zone = data.aws_availability_zones.zones.names[1]
    map_public_ip_on_launch = true
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.sub_public.id
}

resource "aws_route_table_association" "public_2_rt_assoc" {
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.sub_public_2.id
}
resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private_rt_assoc" {
    route_table_id = aws_route_table.private_route.id
    subnet_id = aws_subnet.sub_private.id
}

resource "aws_route_table_association" "private_rt_assoc_db" {
    route_table_id = aws_route_table.private_route.id
    subnet_id = aws_subnet.sub_db_2.id
}

resource "aws_security_group" "app" {
    name = "app"
    description = "App server that use fast api and sql alchemy"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Allow remote access to app"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        security_groups = [aws_security_group.lb.id] 
    }

    egress {
        description = "Allow acess to MySQL database"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "lb" {
    name = "load_balancer"
    description = "Load balancer to app servers"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Allow load balancer HTTP traffic"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow acess to app servers"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db" {
    name = "db"
    description = "MySQL database"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Allow acess to MySQL database"
        from_port = "3306"
        to_port = "3306"
        protocol = "tcp"
        cidr_blocks = [var.sub_public_cidr, var.sub_public_cidr_2]
    }
    egress {
        description = "Allow acess to MySQL database"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}