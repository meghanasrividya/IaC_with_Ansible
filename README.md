# IaC_with_Ansible
![image](https://user-images.githubusercontent.com/97250268/201668955-ebfa816e-04ae-48ee-81ed-898e53150920.png)

# What is Ansible?
-Ansible is a push-based Infrastructure as code (IaC) that provides a user-friendly domain-specific language so we can define the architecture as per desire in a declarative way.
- The term push-based signifies that Ansible utilizes SSH to communicate among the machine executing Ansible and the machines where the configurations are being applied.
- The machines working with Ansible that we like to configure are known as managed nodes or Ansible hosts. In terms of Ansible, the list of hosts is known as an inventory.
- The machine reading the definition files and executing Ansible in order to push the configuration to the host is known as a control node.
- Ansible is written in the Python programming language and has a quite minimal learning curve. The procedure to set up Ansible is pretty simple and doesn't rely on any extra application, servers, or client daemons.
- Ansible is based on the principle of embracing the interrelation and architecture of the system. Like other tools used for managing configuration (such as Puppet, Chef, or Salt), it works with two types of servers: controlling machines and nodes.
- Ansible uses small programs known as Ansible Modules in order to orchestrate nodes. These modules are the resource models of the chosen system state executed over SSH. We do not need any agents and extra custom security infrastructure for this purpose.
- The library of modules can exist in any machine. The modules perform tasks using JSON protocol over the standard output and write the convenient code in any programming language, including Python.
- The system utilizes YAML in Ansible playbooks format in order to describe the work for Automation. This way, it is the machine as well as human-friendly. And when the nodes are not being managed by Ansible, it doesn't consume resources since neither programs nor daemons are running in the background.
