# IaC_with_Ansible
![image](https://user-images.githubusercontent.com/97250268/201668955-ebfa816e-04ae-48ee-81ed-898e53150920.png)

# Ansible default folder / file structure
- /etc/ansible/hosts
- name + ip of our agent nodes


# What is Iac?

- Infrastructure as code is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

# What is Configuration Management?
- Configuration Management is the process of maintaining systems, such as computer hardware and software, in a desired state. Configuration Management (CM) is also a method of ensuring that systems perform in a manner consistent with expectations over time.


# What is Orchestration?
- Orchestration is the automated configuration, management, and coordination of computer systems, applications, and services. Orchestration helps IT to more easily manage complex tasks and workflows.

# What is Ansible?
- Ansible is a push-based Infrastructure as code (IaC) that provides a user-friendly domain-specific language so we can define the architecture as per desire in a declarative way.
- The term push-based signifies that Ansible utilizes SSH to communicate among the machine executing Ansible and the machines where the configurations are being applied.
- The machines working with Ansible that we like to configure are known as managed nodes or Ansible hosts. In terms of Ansible, the list of hosts is known as an inventory.
- The machine reading the definition files and executing Ansible in order to push the configuration to the host is known as a control node.
- Ansible is written in the Python programming language and has a quite minimal learning curve. The procedure to set up Ansible is pretty simple and doesn't rely on any extra application, servers, or client daemons.
- Ansible is based on the principle of embracing the interrelation and architecture of the system. Like other tools used for managing configuration (such as Puppet, Chef, or Salt), it works with two types of servers: controlling machines and nodes.
- Ansible uses small programs known as Ansible Modules in order to orchestrate nodes. These modules are the resource models of the chosen system state executed over SSH. We do not need any agents and extra custom security infrastructure for this purpose.
- The library of modules can exist in any machine. The modules perform tasks using JSON protocol over the standard output and write the convenient code in any programming language, including Python.
- The system utilizes YAML in Ansible playbooks format in order to describe the work for Automation. This way, it is the machine as well as human-friendly. And when the nodes are not being managed by Ansible, it doesn't consume resources since neither programs nor daemons are running in the background..

### Set up three Virtual machines (Ansible Controller, Web app and Db machines) using Vagrant file.
```

# -*- mode: ruby -*-
 # vi: set ft=ruby :
 
 # All Vagrant configuration is done below. The "2" in Vagrant.configure
 # configures the configuration version (we support older styles for
 # backwards compatibility). Please don't change it unless you know what
 
 # MULTI SERVER/VMs environment 
 #
 Vagrant.configure("2") do |config|
    # creating are Ansible controller
      config.vm.define "controller" do |controller|
        
       controller.vm.box = "bento/ubuntu-18.04"
       
       controller.vm.hostname = 'controller'
       
       controller.vm.network :private_network, ip: "192.168.33.12"
       
       # config.hostsupdater.aliases = ["development.controller"] 
       
      end 
    # creating first VM called web  
      config.vm.define "web" do |web|
        
        web.vm.box = "bento/ubuntu-18.04"
       # downloading ubuntu 18.04 image
    
        web.vm.hostname = 'web'
        # assigning host name to the VM
        
        web.vm.network :private_network, ip: "192.168.33.10"
        #   assigning private IP
        
        #config.hostsupdater.aliases = ["development.web"]
        # creating a link called development.web so we can access web page with this link instread of an IP   
            
      end
      
    # creating second VM called db
      config.vm.define "db" do |db|
        
        db.vm.box = "bento/ubuntu-18.04"
        
        db.vm.hostname = 'db'
        
        db.vm.network :private_network, ip: "192.168.33.11"
        
        #config.hostsupdater.aliases = ["development.db"]     
      end
    
    
    end
```
- Go inside the folder where the vagrant file is present do `vagrant up`
- Go inside each virtual machine 
- `vagrant ssh controller`
   `vagrant ssh web`
   `vagrant ssh db`

- And do `sudo apt-get update` and `sudo apt-get upgrade -y`
- After updating and upgrading all the three virtual machines,go inside the controller and give following commands
### Commands to set up controller
 ```
 vagrant ssh controller

sudo apt-get update
  
sudo apt-get install software-properties-common
  
sudo apt-add-repository ppa:ansible/ansible
  
sudo apt-get update
  
sudo apt-get install ansible

cd /etc/ansible
 ```
 - Check the version of ansible `ansible --version`

 ## SSH into web and db from the controller
 ```
 vagrant@controller:/etc/ansible$ ssh vagrant@192.168.33.10
enter 'yes' & password: vagrant
logout of web
vagrant@controller:/etc/ansible$ ssh vagrant@192.168.33.11
enter 'yes' & password: vagrant
logout of db
 ```
 ## Setting up the connections with Db and Web App
 
 - To connect to the Db and Web server we need to go inside the hosts file in controller and change the configuration
 - IP addresss of Web App is `192.168.33.10`
 - IP address of the Db VM is `192.168.33.11`
 - Go inside the hosts file `sudo nano hosts` and change configuration.
 ```
 [web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

 ```
 - 
## To check whether the connection has been successfully established
```
ping 192.168.33.10
ping 192.168.33.11
#all the servers
sudo ansible all -m ping
# or separately each server
sudo ansible web -m ping
sudo ansible app -m ping
```
## Ansible Adhoc Commands

