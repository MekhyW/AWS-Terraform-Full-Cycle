output "db_security_group" {
 value = aws_security_group.db.id
}

output "app_security_group" {
 value = aws_security_group.app.id
}

output "lb_security_group" {
 value = aws_security_group.lb.id
}

output "sub_private" {
 value = [aws_subnet.sub_private.id, aws_subnet.sub_db_2.id]
}

output "sub_public" {
 value = [aws_subnet.sub_public.id, aws_subnet.sub_public_2.id]
}

output "vpc_id" {
 value = aws_vpc.vpc.id
}