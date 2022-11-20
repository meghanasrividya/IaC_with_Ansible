
## Infrastructure as Code:

![image](https://user-images.githubusercontent.com/97250268/202718791-505c8e7a-a1ef-4f0e-abef-b5cf03de6633.png)

### Steps:

- From the local host using terraform create `main.tf` file to launch the EC2 instances(3 instances) in the AWS cloud.Create another file `variable.tf` for storing varibles
- Install the ansible  in one of the EC2 instance which acts as ansible controller
- From the controller install the node app in web EC2 instance using `node.yml` file
- From the controller install the mongodb  in mongodb EC2 instance using `mongo.yml` file

### What is Terraform State and how does it work?

- Terraform must store state about our managed infrastructure and configuration. This state is used by Terraform to map real world resources to our configuration, keep track of metadata, and to improve performance for large infrastructures.

- This state is stored by default in a local file named terraform.tfstate

- Terraform uses this local state to create plans and make changes to our infrastructure. Before any terraform operation, Terraform does a refresh to update the state with the real infrastructure.

### Code to create Autoscaling group
```
# To create launch template
resource "aws_launch_template" "lt_app" {
   name="eng130-meghana-lt"

  image_id      = var.webapp_ami_id
  instance_type = var.ec2_type
}
# To create autoscaling group
resource "aws_autoscaling_group" "lt_asg" {
   name="eng130_meghana_asg"
  availability_zones = ["eu-west-1a","eu-west-1b","eu-west-1c"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.lt_app.id
    version = "$Latest"


  }
}

```

### Code to Create Cloud Metrics
```
resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-up" {
    alarm_name = eng130-meghana-alarm
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CUPUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "70"

    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.tf-auto-scaling-group.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = ["${aws_autoscaling_policy.tf-autoscaling-up.arn}"]
}

# Create Auto Scaling Policy - Decreased Usage
resource "aws_autoscaling_policy" "tf-autoscaling-down"{
    name = `eng130-asg`
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.tf-auto-scaling-group.name}"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-down" {
    alarm_name = eng130-meghana-alarm
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CUPUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "30"

    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.tf-auto-scaling-group.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = ["${aws_autoscaling_policy.tf-autoscaling-down.arn}"]
}

```
### main.tf code to install 3 EC2 instances :

```


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
# add resource vpc
resource "aws_vpc" "mainvpc" {
     cidr_block = var.cidr_vpc
     tags = {
      Name ="eng130-meghana4-vpc"
     }
}

# add resource internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.mainvpc.id

  tags = {
    Name = "eng130_meghana_terraform_internetgateway"
  }
}

#add resource subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = var.cidr_subnet_public

  tags = {
    Name = "eng130_meghana_terraform_subnet_public"
  }
}
# add resource route table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = var.all
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
     
    Name ="eng130_meghana_terraform_rt_public"

}
}
# associating route table to subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}


  # Create Security Group for instance
  resource "aws_security_group" "sg" {
    name   = "eng130-meghana-terraform-sg"
    vpc_id = aws_vpc.mainvpc.id
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
resource "aws_instance" "web_app_instance" {
   ami = var.webapp_ami_id
   instance_type =var.ec2_type
   associate_public_ip_address = true
subnet_id = aws_subnet.main.id
   key_name=var.aws_key_name   
vpc_security_group_ids = [aws_security_group.sg.id]
  
  

   tags = {
    Name ="eng130-meghana-terraform-app1"
 }
}




# To create an autoscaling policy
# Create Auto Scaling Policy - Increased Usage
resource "aws_instance" "ansible_controller" {

   ami =var.ansible_ami_id
   instance_type=var.ec2_type
   associate_public_ip_address =true
   subnet_id=aws_subnet.main.id
   key_name=var.aws_key_name
   security_groups =[aws_security_group.sg.id]
    
   tags = {
    Name= "eng130-meghana-ansible"}

}


resource "aws_instance" "db_instance"{
     ami =var.webapp_ami_id
     instance_type=var.ec2_type
     associate_public_ip_address =true
     subnet_id=aws_subnet.main.id
     key_name=var.aws_key_name
     security_groups =[aws_security_group.sg.id]

  tags ={
      Name ="eng130-meghana-dbapp"
}

}

```
