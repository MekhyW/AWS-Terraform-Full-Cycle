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