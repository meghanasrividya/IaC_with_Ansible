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
   ami = "ami-0b47105e3d7fc023e"
   instance_type ="t2.micro"
   associate_public_ip_address = true
   tags = {
    Name ="eng130-meghana-terraform-app"
 }
}
# add resource

# ami

# instance type


# do we need public ip or not

# name of the server


