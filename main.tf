# write a script to launch resources on cloud

#create ec2 instance on AWS
# syntax  {
       #  ami= sadada }
# download dependencies from AWS

provider "aws" {


   


# which part of AWS we would like to launch resources in
region = "eu-west-1"

 }
# what type os server with what sort of functionality
resource "aws_instance" "app_instance" {
   ami = var.webapp_ami_id
   instance_type =var.ec2_type
   associate_public_ip_address = true
   tags = {
    Name ="eng130-meghana-terraform-app1"
 }
}
# add resource vpc
resource "aws_vpc" "mainvpc" {
     cidr_block = var.cidr_vpc
     tags = {
      Name ="eng130-meghana4-vpc"
     }
}
# add resource internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id

  tags = {
    Name = "eng130_meghana_terraform_internetgateway"
  }
}

#add resource subnet
resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_subnet_public

  tags = {
    Name = "eng130_meghana_terraform_subnet_public"
  }
}
# add resource route table
resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.all
    gateway_id = var.igw_id
  }
  tags = {
     
    Name ="eng130_meghana_terraform_rt_public"

}
}
# associating route table to subnet
resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_id
  route_table_id = var.rt_id
}


  # Create Security Group for instance
  resource "aws_security_group" "eng130-meghana-terraform-sg" {
    name   = "eng130-meghana-terraform-sg"
    vpc_id = var.vpc_id
    # Inbound Rules

    # SSH from anywhere
    ingress {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTP from anywhere
    ingress {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
      description = "All Outbound Traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "eng130-meghana-terraform-sg"
    }

  }
# instance type


# do we need public ip or not

# name of the server


