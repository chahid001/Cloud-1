
# Cloud-1

"Cloud-1" automates deploying Inception's infrastructure on a remote server via containers. Students leverage tools like Ansible to set up WordPress, PHPMyAdmin, etc., ensuring full automation and data persistence on server reboots. They manage resources within allocated credits, emphasizing real-world costs and security. The submission focuses on functional deployment scripts over visual presentation.

# Tech used in the project

![Markup](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Markup](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Markup](https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white)
![Markup](https://img.shields.io/badge/microsoft%20azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white) 
![Markup](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) 
![Markup](https://img.shields.io/badge/Wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white) 

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`URL`

`MYSQL_USER`
`MYSQL_PASSWORD`
`MYSQL_ROOT_PASSWORD`

`WORDPRESS_ROOT_LOGIN`
`WORDPRESS_ROOT_EMAIL`
`WORDPRESS_NAME`
`WORDPRESS_USER_EMAIL`

`FTP_USER`
`FTP_PASSWORD`

# Deployment
# Ansible version
The project is supposed to be in the cloud but for this example, we going to work 
with a VirtualBox ubuntu server with Vagrant, because as a wise man once said: 
        **' There is no cloud it’s just someone else’s computer '**
but for the school, it will be deployed in Microsoft Azure (or AWS or any cloud platform you like).
so you need first to set up your environment variables file .env and place it in resources/.env
then run your vagrant server
```bash
  vagrant up
```
and you need to generate the ssh key of your host machine
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
then in your host, you can begin deployment with Ansible
```bash
  ansible-playbook -i inventory playbook.yaml
```
and don't forget to replace your server IP address in the **Inventory** file
# Terraform version
It's the same thing as the Ansible version unless here we gonna automate the deployment of the infrastructure (Infrastructure as a code)
instead of deploying it manually on the Cloud provider website.
## Azure
First of all, you need to authenticate with the cloud provider, we're doing that with the CLI
### Install the azure CLI

```bash
  brew update && brew install azure-cli
```
Then 
```bash
  az login --use-device-code
```
go to the website, enter the code, and sign in with your azure account
and verify with
```bash
  az account show
```
after that, you can add your public ssh-key to the main.tf and also we have customdata.tpl so we can install python (for Ansible)
then to check

```bash
  terraform plan
```
and 
```bash
  terraform apply -auto-approve
```
## AWS
First of all, you need to authenticate with the cloud provider, we're doing that with the CLI

so you need to install the AWS CLI by following these [steps](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## About the project

In this version, each process will have its container. You CAN NOT deploy the same
images from Inception and be done with it ;) You can of course get the source of the
website (Your WordPress blog for instance), but you have to deploy it using a container
per process and automation.

    


    



