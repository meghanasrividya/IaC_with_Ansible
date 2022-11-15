sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
sudo apt-get install tree
cd /etc/ansible
echo [web] >> hosts
echo 192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant >> hosts
echo [db] >> hosts
echo 192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant >> hosts

