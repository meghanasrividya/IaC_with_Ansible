
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
resource "aws_launch_template" "lt_app" {
  name_prefix   = "eng130_meghana_lt"
  image_id      = var.webapp_ami_id
  instance_type = var.ec2_type
}

resource "aws_autoscaling_group" "lt_asg" {
  availability_zones = ["eu-west-1a","eu-west-1b","eu-west-1c"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.lt_app.id
    version = "$Latest"


  }

```

