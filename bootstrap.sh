#!/bin/sh

read -p "Enter root password : " password

# Update APT repos
sudo apt update

# Make sure python is installed
sudo apt install python3 python3-pip

# Install pipx
sudo apt install pipx
pipx ensurepath

# Install Ansible
pipx install --include-deps ansible

# Install passlib (for ssh password connection)
sudo apt install sshpass

# Make sure git is installed
sudo apt install git

# Clone ansible_playbooks repo
git clone https://git.athelas-conseils.fr/Stage/ansible_playbooks.git

~/.local/bin/ansible-playbook ansible_playbooks/tasks/full_setup.yml -i ansible_playbooks/inventory.ini --extra-vars "ansible_ssh_pass=$password ansible_ssh_common_args='-o StrictHostKeyChecking=no'"