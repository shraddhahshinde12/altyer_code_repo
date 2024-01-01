resource "aws_instance" "example_aws_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  tags                   = var.tags_name
  vpc_security_group_ids = [aws_security_group.example_instance_sg1.id]
  subnet_id              = aws_subnet.example-public_subent_01.id

  user_data = <<-EOF
              #!/bin/bash
              echo "${var.my_secret_key}" 
              EOF
}

//creating Security group
resource "aws_security_group" "example_instance_sg1" {
  name        = "aws-instance-sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.example-vpc1.id
  // Ingress rules for enhanced security
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // for ssh access, one can also do security hardening from specific IP range declrations  }

  }
}


//creating a VPC
resource "aws_vpc" "example-vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "eg-vpc"
  }

}


// Creating a Subnet 
resource "aws_subnet" "example-public_subent_01" {
  vpc_id                  = aws_vpc.example-vpc1.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "example-public_subent_01"
  }

}

//Creating a Internet Gateway 
resource "aws_internet_gateway" "example_IG" {
  vpc_id = aws_vpc.example-vpc1.id
  tags = {
    Name = "example_IG"
  }
}

// Create a route table 
resource "aws_route_table" "example-public-RT" {
  vpc_id = aws_vpc.example-vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_IG.id
  }
  tags = {
    Name = "example-public-RT"
  }
}


// Associate subnet with routetable 
resource "aws_route_table_association" "example_RTA" {
  subnet_id      = aws_subnet.example-public_subent_01.id
  route_table_id = aws_route_table.example-public-RT.id

}