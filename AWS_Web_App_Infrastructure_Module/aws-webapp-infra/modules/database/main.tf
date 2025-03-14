resource "aws_db_subnet_group" "webapp" {
  name = "webapp-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "WebApp DB Subnet Group"
  }
}

resource "aws_rds_cluster" "webapp" {
  cluster_identifier = "webapp-db-cluster"
  engine = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.10.2"
  availability_zones = data.aws_availability_zones.available.names
  database_name = var.db_name
  master_username = var.db_username
  master_password = var.db_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name = aws_db_subnet_group.webapp.name
  vpc_security_group_ids = [aws_security_group.db.id]

  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "webapp" {
  count = 2
  identifier = "webapp-db-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.webapp.id
  instance_class = "db.t3.medium"
  engine = aws_rds_cluster.webapp.engine
  engine_version = aws_rds_cluster.webapp.engine_version
}

# Add ElastiCache cluster and security group

