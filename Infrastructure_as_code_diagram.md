
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
