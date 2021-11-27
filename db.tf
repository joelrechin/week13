resource "aws_db_subnet_group" "week13-sng" {
  name       = "week13-sng"
  subnet_ids = [aws_subnet.week13-pri-a.id, aws_subnet.week13-pri-b.id]

  tags = {
    Name = "week13-sng"
  }
}

resource "aws_security_group" "week13-rds-sg" {
  name        = "week13-rds-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.week13-vpc.id

  ingress = [
    {
      description = "TCP for MySQL"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "week13-rds-sg"
  }
}

resource "aws_rds_cluster" "week13-rds" {
  cluster_identifier     = "week13-rds"
  database_name          = "week13_rds"
  engine                 = "aurora-mysql"
  engine_mode            = "serverless"
  master_username        = "admin"
  master_password        = "secret123"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.week13-sng.id
  vpc_security_group_ids = [aws_security_group.week13-rds-sg.id]

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
  }
}

output "week13-rds-endpoint" {
  value = aws_rds_cluster.week13-rds.endpoint
}
