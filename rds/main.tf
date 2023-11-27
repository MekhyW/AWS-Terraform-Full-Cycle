resource "aws_db_instance" "db" {
  allocated_storage = 20
  identifier = "myrdsdb" 
  db_name = "academia"
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0.33"
  instance_class = "db.t2.micro"
  username = "root"
  password = "megadados"
  vpc_security_group_ids = var.vpc_security_group_ids_var 
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
  backup_retention_period = 7
  backup_window = "04:00-05:00"
  maintenance_window = "Mon:03:00-Mon:04:00"
  multi_az = true
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name = "myrdsdb_subnet_group"
    description = "myrdsdb_subnet_group"
    subnet_ids = var.subnet_ids_var
}