## Ansible Playbooks ##

Playbook in ansible are written in YAML format. It is human readbale data serialization language(commonly used for configuration files).

Playbook may consist of:

Vars
Tasks,
Handlers
Files,
Tempplates, and
Roles

Playbooks are dividen into many sections

1. Target section - Ansible clients against which playbook task has to be executed
2. Variable section - Specifies variables to be used under more than one tasks
3. Task section - A particular task


## Writing First Playbook

```YAML
--- # My first Ansible playbook
--- # target.yml
- hosts: demo
  user: ansible
  become: yes
  connection: ssh
  gather_facts: yes
```
Execution:

```
[ansible@ip-172-31-14-224 ~]$ ansible-playbook target.yml

PLAY [demo] *****************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.4.162]
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.3.202]

PLAY RECAP ******************************************************************************************************************************
172.31.3.202               : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.31.4.162               : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[ansible@ip-172-31-14-224 ~]$
```

## Playbook with a task

```YAML
--- # Playbook with a task
--- # task.yml
- hosts: demo
  user: ansible
  become: yes
  connection: ssh

  tasks:
    - name: install httpd on linux
      action: yum name=httpd state=present
```

Execution:
```
[ansible@ip-172-31-14-224 ~]$ ansible-playbook task.yml

PLAY [demo] *****************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.4.162]
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.3.202]

TASK [install httpd on linux] ***********************************************************************************************************
changed: [172.31.4.162]
changed: [172.31.3.202]

PLAY RECAP ******************************************************************************************************************************
172.31.3.202               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.31.4.162               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[ansible@ip-172-31-14-224 ~]$ ansible demo -a "whereis httpd"
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
172.31.4.162 | CHANGED | rc=0 >>
httpd: /usr/sbin/httpd /usr/lib64/httpd /etc/httpd /usr/share/httpd /usr/share/man/man8/httpd.8.gz
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
172.31.3.202 | CHANGED | rc=0 >>
httpd: /usr/sbin/httpd /usr/lib64/httpd /etc/httpd /usr/share/httpd /usr/share/man/man8/httpd.8.gz
[ansible@ip-172-31-14-224 ~]$  
```
## Example of a variable

```YAML
--- # Another playbook having variables
--- # vars.yml

- hosts: demo
  user: ansible
  become: yes
  connection: ssh
  vars:
    - pkgname: httpd
  tasks:
    - name: install httpd server
      action: yum name='{{pkgname}}' state=present
```

```
[ansible@ip-172-31-14-224 ~]$ ansible-playbook vars.yml

PLAY [demo] *****************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.3.202]
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
ok: [172.31.4.162]

TASK [install httpd server] *************************************************************************************************************
changed: [172.31.4.162]
changed: [172.31.3.202]

PLAY RECAP ******************************************************************************************************************************
172.31.3.202               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.31.4.162               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[ansible@ip-172-31-14-224 ~]$ ansible demo -a "whereis httpd"
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
172.31.4.162 | CHANGED | rc=0 >>
httpd: /usr/sbin/httpd /usr/lib64/httpd /etc/httpd /usr/share/httpd /usr/share/man/man8/httpd.8.gz
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
172.31.3.202 | CHANGED | rc=0 >>
httpd: /usr/sbin/httpd /usr/lib64/httpd /etc/httpd /usr/share/httpd /usr/share/man/man8/httpd.8.gz
[ansible@ip-172-31-14-224 ~]$
```

## Credit and Reference:
https://www.youtube.com/watch?v=uyFrrKju4Es
