### Steps to create node.yml to install node.js app in web from the controller

- Create a new file using the command `sudo nano node.yml`

- Inside the node.yml file

```
# This is a playbook to install and set up Nginx in our web server (192.168.33.10) and install node.js to our app
---
# sudo coding of the instructions we need:
# name of the host - hosts is to define the name of your host or all
# This tells the controller which server the controller needs to talk to

- hosts: web

# Find the facts about the host, this is optional to gather more info

  gather_facts: yes
  
# We need the admin access
  become: true
  
# Instructions using tasks module in ansible. Instructions to give controller

  tasks:
  
    - name: Install Nginx
    
# install nginx
     
      apt: pkg=nginx state=present  update_cache=yes
      
# Like a notification
      notify:
        - restart nginx

     
# To allow port 80
    - name: Allow all access to tcp port 80
    ufw:
      rule: allow
      port: '80'
      proto: tcp    
   # handler to restart nginx
  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted

-
  name: Installing nodejs
  hosts: web
  become: true
  tasks:
    - name: Add nodejs apt key
      apt_key:
        url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
        state: present


    - name: Installing nodejs
      apt:
        update_cache: yes
        name: nodejs
        state: present

    - name: Install npm
      apt: pkg=npm state=present

    - name: Install pm2
      npm:
        name: pm2
        global: yes
        production: yes
        state: present
        
 ```
 - To check the syntax of the node.yml give the command `sudo ansible-playbook node.yml --syntax-check`
 - If the syntax is ok.it will display `playbook: node.yml`
 - To run the playbook ,give the command `sudo ansible-playbook node.yml`
   
