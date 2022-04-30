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
ansible demo -ba "yum install httpd -y"  # flag -b is for adding sudo implicitly
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

__Same Ad-hoc commands can run any number of times, and ansible doesn't check if the command has already run successfully earlier. This is one of the disadvantages of ad-hoc commands.__


## Modules ##

`-m` flag refers to the modules in Ansible commands.

`$ ansible <all/groupname/set of nodes> -b -m <module name> -a "<arguments>"`

`ansible demo -b -m yum -a "pkg = httpd state=present"`

install = present
uninstall = absent
update = latest

```
ansible demo -b -m yum -a "pkg = httpd state = latest"
ansible demo -b -m service -a "name = httpd state = started"
ansible demo -b -m copy -a "src = file4 dest = /tmp/"
```

Demo

```Terminal
[ansible@ip-172-31-14-224 ~]$ ansible demo[-1] -b -m yum -a "name=httpd state=absent"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but
future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "msg": "",
    "rc": 0,
    "results": [
        "httpd is not installed"
    ]
}
[ansible@ip-172-31-14-224 ~]$ ansible demo[-1] -b -m yum -a "name=httpd state=present"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but
future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "changes": {
        "installed": [
            "httpd"
        ]
    },
    "msg": "",
    "rc": 0,
    "results": [
        "Loaded plugins: extras_suggestions, langpacks, priorities, update-motd\nResolving Dependencies\n--> Running transaction check\n---> Package httpd.x86_64 0:2.4.53-1.amzn2 will be installed\n--> Processing Dependency: mod_http2 for package: httpd-2.4.53-1.amzn2.x86_64\n--> Running transaction check\n---> Package mod_http2.x86_64 0:1.15.19-1.amzn2.0.1 will be installed\n--> Finished Dependency Resolution\n\nDependencies Resolved\n\n================================================================================\n Package         Arch         Version                    Repository        Size\n================================================================================\nInstalling:\n httpd           x86_64       2.4.53-1.amzn2             amzn2-core       1.3 M\nInstalling for dependencies:\n mod_http2       x86_64       1.15.19-1.amzn2.0.1        amzn2-core       149 k\n\nTransaction Summary\n================================================================================\nInstall  1 Package (+1 Dependent package)\n\nTotal download size: 1.5 M\nInstalled size: 4.5 M\nDownloading packages:\n--------------------------------------------------------------------------------\nTotal                                              9.3 MB/s | 1.5 MB  00:00     \nRunning transaction check\nRunning transaction test\nTransaction test succeeded\nRunning transaction\n  Installing : mod_http2-1.15.19-1.amzn2.0.1.x86_64                         1/2 \n  Installing : httpd-2.4.53-1.amzn2.x86_64                                  2/2 \n  Verifying  : httpd-2.4.53-1.amzn2.x86_64                                  1/2 \n  Verifying  : mod_http2-1.15.19-1.amzn2.0.1.x86_64                         2/2 \n\nInstalled:\n  httpd.x86_64 0:2.4.53-1.amzn2                                                 \n\nDependency Installed:\n  mod_http2.x86_64 0:1.15.19-1.amzn2.0.1                                        \n\nComplete!\n"
    ]
}
[ansible@ip-172-31-14-224 ~]$ ansible demo[-1] -ba "systemctl start httpd"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but
future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | CHANGED | rc=0 >>

[ansible@ip-172-31-14-224 ~]$ ansible demo[-1] -ba "systemctl status httpd"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but
future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | CHANGED | rc=0 >>
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2022-04-30 03:02:14 UTC; 9s ago
     Docs: man:httpd.service(8)
 Main PID: 22190 (httpd)
   Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─22190 /usr/sbin/httpd -DFOREGROUND
           ├─22192 /usr/sbin/httpd -DFOREGROUND
           ├─22193 /usr/sbin/httpd -DFOREGROUND
           ├─22194 /usr/sbin/httpd -DFOREGROUND
           ├─22195 /usr/sbin/httpd -DFOREGROUND
           └─22196 /usr/sbin/httpd -DFOREGROUND

Apr 30 03:02:14 ip-172-31-3-202.ap-south-1.compute.internal systemd[1]: Starting The Apache HTTP Server...
Apr 30 03:02:14 ip-172-31-3-202.ap-south-1.compute.internal systemd[1]: Started The Apache HTTP Server.
[ansible@ip-172-31-14-224 ~]$ ansible demo[-1] -b -m yum -a "name=httpd state=present"
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but
future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
172.31.3.202 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "msg": "",
    "rc": 0,
    "results": [
        "httpd-2.4.53-1.amzn2.x86_64 providing httpd is already installed"
    ]
}
[ansible@ip-172-31-14-224 ~]$


```
