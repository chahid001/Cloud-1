
# Cloud-1

This topic is inspired by the subject Inception. The goal is to deploy your site and the
necessary docker infrastructure on an instance provided by a cloud provider.

# Tech used in the project

![Markup](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Markup](https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white)
![Markup](https://img.shields.io/badge/microsoft%20azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white) 
![Markup](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Markup](https://img.shields.io/badge/Wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white) 

# Deployment

The project is supposed to be in the cloud but for this example we gonna work 
with a virtualbox ubuntu server with Vagrant, because as a wise man once said: 
        **'There is no cloud it’s just someone else’s computer'**
but for the school it will be deployed in microsoft azure (or AWS or any cloud platform that you like).
so you need first to setup your environment variables file .env and place it in resources/.env
then run your vagrant server
```bash
  vagrant up
```
and you need to generate your ssh key of your host machine
```bash
  ssh-keygen
```
after that connect with vagrant ssh
```bash
  vagrant ssh
```
and copy your host ssh key to the server
```bash
  echo "<ssh_public_key>" >> ~/.ssh/authorized_keys
```
then in your host you can begin deployment with Ansible
```bash
  ansible-playbook -i inventory playbook.yaml
```
and dont forget to replace your server IP address to the **Inventory**
## About the project

In this version, each process will have its container. You CANNOT deploy the same
images from Inception and be done with it ;) You can of course get the source of the
website (Your WordPress blog for instance), but you have to deploy it using a container
per process and automation.

    


    



