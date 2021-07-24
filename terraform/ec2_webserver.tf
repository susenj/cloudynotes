# ec2_webserver.tf
# Does all the stuff via Terraform, right from designing the EC2, its network etc.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
  access_key = "<access_key>"
  secret_key = "<secret_key>"
}

# resource "<provider>_<resource_type>" "name"{
#   config options...
#   key = "value"
#   key2 = "another_value"
#}

# 1. Create vpc
resource "aws_vpc" "first-vpc-by-tf" {
   cidr_block = "10.0.0.0/24"
   tags = {
      Name = "production"
   }
}

# 2. Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.first-vpc-by-tf.id

  tags = {
    Name = "igw-neeraj"
  }
}

# 3. Create a custom route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.first-vpc-by-tf.id

  route {
    #cidr_block = "10.0.0.0/27"
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prod-rt"
  }
}

# 4. create a subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.first-vpc-by-tf.id
  cidr_block = "10.0.0.0/28"

  # New thing coming in
  availability_zone = "ap-south-1b"
  tags = {
    Name = "prod-subnet"
  }
}

# 5. Associate subnet with the Route Table
resource "aws_route_table_association" "rtas" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

# 6. Create Security Group to allow port 22, 80, 443
resource "aws_security_group" "allow_tls" {
  name           = "allow_tls"
  description    = "Allow specific ports"
  vpc_id         = aws_vpc.first-vpc-by-tf.id

  ingress  {
        from_port     = 443
        to_port       = 443
        protocol      = "tcp"
        description   = "HTTPS"
        cidr_blocks   = ["0.0.0.0/0"]
        #cidr_blocks   = [aws_vpc.first-vpc-by-tf.cidr_block] # We need to provide the cidr_block correctly, check above
  }   
  egress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  tags = {
      Name = "neeraj_allow_all"
  }
}
# I don't need to create multiple SGs separately, instead could have used multiple ingress blocks for each protocol in one SG.
resource "aws_security_group" "allow_ssh" {
  name           = "allow_ssh"
  description    = "Allow port 22"
  vpc_id         = aws_vpc.first-vpc-by-tf.id

  ingress  {
        from_port     = 22
        to_port       = 22
        protocol      = "tcp"
        description   = "SSH"
        cidr_blocks   = ["0.0.0.0/0"]
  }   
  egress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  tags = {
      Name = "neeraj_allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name           = "allow_http"
  description    = "Allow port 80"
  vpc_id         = aws_vpc.first-vpc-by-tf.id

  ingress  {
        from_port     = 80
        to_port       = 80
        protocol      = "tcp"
        description   = "HTTP"
        cidr_blocks   = ["0.0.0.0/0"]
  }   
  egress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  tags = {
      Name = "neeraj_allow_http"
  }
}

# 7. Create a network interface with an ip in the subnet that was created in step 4
resource "aws_network_interface" "eni" {
   subnet_id          = aws_subnet.subnet-1.id
   private_ips        = ["10.0.0.12"]
   security_groups    = [aws_security_group.allow_ssh.id, aws_security_group.allow_tls.id, aws_security_group.allow_http.id]
}

# 8 . and Assign an elastic IP to the network interface created in the step 7
resource "aws_eip" "eip" {
   vpc               = true
   network_interface = aws_network_interface.eni.id
   associate_with_private_ip = "10.0.0.12"
   # New thing coming in
   depends_on        = [aws_internet_gateway.igw]
}

# 9. Create an Ubuntu server EC2 instance and install/enable apache2
resource "aws_instance" "neeraj_ubuntu" {
   ami = "ami-0c1a7f89451184c8b"
   instance_type = "t2.micro"
   availability_zone = "ap-south-1b"
   key_name          = "app-key-pair"

   network_interface {
      device_index = 0
      network_interface_id = aws_network_interface.eni.id
   }

   #provisioner "local-exec" { # This was wrongly done because this would start executing the commands on local machine..lol xD
   user_data  = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
systemctl enable httpd
sudo bash -c 'echo your very first web server' > /var/www/html/index.html
EOF
   #}
   tags = {
     Name = "neerajk-ubuntu-webserver"
   }
}
