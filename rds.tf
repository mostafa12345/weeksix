
resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet-private-02a.id, aws_subnet.subnet-private-02b.id]

  tags = {
    Name = "rds-subnet-group"
    Environment = "${var.environment}"
  }
}

resource "aws_db_instance" "postgresql" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  db_name              = "postgresqldatabase"
  username             = "postgres"
  password             = "PASSWORD"
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg-01.id]
  skip_final_snapshot  = true
  multi_az = true
  
  tags = {
    Name = "rds_postgress_01"
  }
}
