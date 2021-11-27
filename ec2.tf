resource "aws_security_group" "week13-ssh-sg" {
  name        = "week13-ssh-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.week13-vpc.id

  ingress = [
    {
      description = "SSH from VPC"
      from_port   = 22
      to_port     = 22
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
    Name = "week13-ssh-sg"
  }
}


/*resource "aws_instance" "week13-bastion-vm" {
  ami                    = "ami-02e136e904f3da870"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.week13-sub-a.id
  vpc_security_group_ids = [aws_security_group.week13-ssh-sg.id]
  key_name               = "week3-ssh"

  tags = {
    Name = "week13-bastion-vm"
  }
}*/


