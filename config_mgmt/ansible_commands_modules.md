Ansible supports

1. Ad-hoc commands - Simple Linux Commands - Needs to be performed quickly. For example: quick shutdown, create a file, stop a service
2. Modules - Modules single command
3. Playbooks - collection of Modules(Generally required for a set of tasks) written in a YAML file.


## Ad-hoc commands ##

We go to the ansible server, and run the command:

`$ ansible <all/groupname/set of nodes> -a <linux command>`

Example: 

```
ansible demo -a "sudo yum install httpd -y"
ansible demo[-1] -a "df -kh ."
ansible all -a "free -m"
```
