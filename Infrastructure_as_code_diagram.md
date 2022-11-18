
## Infrastructure as Code:

![image](https://user-images.githubusercontent.com/97250268/202718791-505c8e7a-a1ef-4f0e-abef-b5cf03de6633.png)

### Steps:

- First with the help of Terraform `main.tf`launch the EC2 instances(3 instances) in the AWS cloud.Create another file `variable.tf` for storing varibles
- Install the ansible  in one of the EC2 instance which acts as ansible controller
- From the controller install the node app in web EC2 instance using `node.yml` file
- From the controller install the mongodb  in mongodb EC2 instance using `mongo.yml` file


