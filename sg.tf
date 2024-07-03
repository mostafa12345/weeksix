
resource "aws_internet_gateway" "gw-01" {
  vpc_id = aws_vpc.vpc-01.id

  tags = {
    Name = "gw-01"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "rt-01" {
  vpc_id = aws_vpc.vpc-01.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-01.id
  }
tags = {
  Name = "rt-01"
  Environment = "${var.environment}"
 }
}

resource "aws_route_table_association" "art-01a" {
 subnet_id   = aws_subnet.subnet-public-01a.id
 route_table_id = aws_route_table.rt-01.id
}
resource "aws_route_table_association" "art-01b" {
 subnet_id   = aws_subnet.subnet-public-01b.id
 route_table_id = aws_route_table.rt-01.id
}

resource "aws_security_group" "sg-01" {
  vpc_id = aws_vpc.vpc-01.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-01"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "bastion" {
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.vpc-01.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion_security_group"
    Environment = "${var.environment}"
  }
}
