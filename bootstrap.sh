#!/bin/sh

read -p "Enter root password : " password

# Update APT repos
sudo apt update

# Make sure python is installed
sudo apt install python3 python3-pip -y

# Install pipx
sudo apt install pipx -y
pipx ensurepath

# Install Ansible
pipx install --include-deps ansible

# Install sshpass (for ssh password connection) & passlib (for password encryption)
sudo apt install python3-passlib sshpass
pipx inject ansible passlib

# Make sure git & git-lfs are installed and configured
sudo apt install git git-lfs -y
git lfs install

# Clone ansible_playbooks repo
git clone https://git.athelas-conseils.fr/Stage/ansible_playbooks.git


~/.local/bin/ansible-playbook ansible_playbooks/tasks/full_setup.yml -i ansible_playbooks/inventory.ini --extra-vars "ansible_ssh_pass=$password ansible_ssh_common_args='-o StrictHostKeyChecking=no'"