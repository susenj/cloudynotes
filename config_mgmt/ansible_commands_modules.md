Ansible supports

1. Ad-hoc commands - Simple Linux Commands - Needs to be performed quickly. For example: quick shutdown, create a file, stop a service
2. Modules - Modules single command
3. Playbooks - collection of Modules(Generally required for a set of tasks) written in a YAML file.


## Ad-hoc commands ##

We go to the ansible server, and run the command:

`$ ansible <all/groupname/set of nodes> -a <linux command>`

Sample commands:

```
ansible demo -a "sudo yum install httpd -y"
ansible demo[-1] -a "df -kh ."
ansible all -a "free -m"
```

Demo:
``` Bash
[ansible@ip-172-31-14-224 ~]$ ansible demo -a "systemctl status sshd"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | CHANGED | rc=0 >>
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2022-04-29 03:30:14 UTC; 22h ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 315 (sshd)
   CGroup: /system.slice/sshd.service
           ├─  315 /usr/sbin/sshd -D
           ├─18005 sshd: root [priv]
           └─18006 sshd: root [net]

Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.4.162 | CHANGED | rc=0 >>
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2022-04-29 03:29:57 UTC; 22h ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 367 (sshd)
   CGroup: /system.slice/sshd.service
           └─367 /usr/sbin/sshd -D

Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
[ansible@ip-172-31-14-224 ~]$ ls
```
