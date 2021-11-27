resource "aws_security_group" "week13-https-sg" {
  name        = "week13-https-sg"
  description = "Allow TCP traffic from worker-vm"
  vpc_id      = aws_vpc.week13-vpc.id

  ingress = [
    {
      description      = "TCP from worker VM"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.week13-vpc.cidr_block]
      security_groups  = []
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
    }
  ]
  egress = [
    {
      description      = "Allow all"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false

    }
  ]

  tags = {
    Name = "week13-https-sg"
  }
}

resource "aws_vpc_endpoint" "week13-sm-ep" {
  vpc_id            = aws_vpc.week13-vpc.id
  service_name      = "com.amazonaws.us-east-1.secretsmanager"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
  aws_security_group.week13-https-sg.id, ]

  private_dns_enabled = true
  subnet_ids          = [aws_subnet.week13-pri-a.id, aws_subnet.week13-pri-b.id]
  tags = {
    Environment = "test"
    Name        = "week13-sm-ep"
  }
}

