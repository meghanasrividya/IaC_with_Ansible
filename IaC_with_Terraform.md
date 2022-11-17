## Infrastructure as Code - Orchestration with Terraform

### What is Terraform ?
- Terraform is an open-source, infrastructure as code, software tool created by HashiCorp.

- Terraform can be defined as a tool for versioning, changing, and building infrastructure efficiently and safely. It can manage popular and existing service providers and custom in-house solutions also.

- Configuration files explain to terraform that the elements required executing our entire data center or an individual application. Terraform produces a single execution plan explaining what it'll do for reaching the desired state after it runs for building the desired infrastructure. Terraform is capable of determining what will change and build execution plans that can be used as the configuration modifications.

- The infrastructure terraform could handle low-level elements like networking, storage, compute instances, also high-level elements like SaaS features, DNS entries, etc.

- Terraform can provide support with multi-cloud via having a single workflow for every cloud. Various manages of terraform infrastructure could be hosted over Google Cloud Platform, Microsoft Azure, and Amazon Web Services, or on-prem within the private clouds like CloudStack, OpenStack, or VMWare vSphere. Terraform considers IaC (Infrastructure as Code). So, we need not to be worried about our infrastructure drifting away through the desired configuration.
 
 ### Benefits :
 - Declarative nature.
 - Platform agnostics.
 - Reusable configurations.
 - Managed state.
 - Easy rollsbacks.

### Usecases:
- Build and Dispose Environments
- N-Tier Application Deployments
- Using Multiple Clouds
- Working with Most Popular PaaS Tools

 ### Terraform Commands
 ```
 Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.

 ```
 ## Terraform Architecture:

![image](https://user-images.githubusercontent.com/97250268/202471468-1c1c1bb1-2c1d-4c76-a506-71744d957ab4.png)

![image](https://user-images.githubusercontent.com/97250268/202480098-0fe3c7ef-4024-4819-b6a6-30ca66c78dfc.png)


![image](https://user-images.githubusercontent.com/97250268/202479452-d1718426-02e6-4854-9c8e-c6dc800f7c67.png)



#### Steps:
- Attach VPC to IG
- Associate the route table to the subnet. 



#### main.tf code

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
  route_table_id = var.subnet_id
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




```

 
