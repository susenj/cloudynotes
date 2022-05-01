## Conditions in Ansible playbook

Condition represent tasks with conditions - denoted by the keyword `when`. 
Example:
```YAML
--- # Conditions in a playbook
    # conditions.yml
- hosts: demo
  user: ansible
  become: yes
  connection: ssh
  tasks:
    - name: Install apache server for the debian family
      command: apt-get -y install apache2             # command keyword is used to fire a linux CLI
      when: ansible_os_family == "Debian"
    - name: Install apache server for the RHEL family
      command: yum -y install httpd                   # otherwise we could have used the regular name, state convention
      when: ansible_os_family == "RedHat"

```

Execution:
```
[ansible@ip-172-31-14-224 ~]$ ansible-playbook conditions.yml

PLAY [demo] **********************************************************************************

TASK [Gathering Facts] ***********************************************************************
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more
information.
ok: [172.31.4.162]
[WARNING]: Platform linux on host 172.31.3.202 is using the discovered Python interpreter at
/usr/bin/python, but future installation of another Python interpreter could change this. See
https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more
information.
ok: [172.31.3.202]

TASK [Install apache server for the debian family] *******************************************
skipping: [172.31.4.162]
skipping: [172.31.3.202]

TASK [Install apache server for the RHEL family] *********************************************
[WARNING]: Consider using the yum module rather than running 'yum'.  If you need to use
command because yum is insufficient you can add 'warn: false' to this command task or set
'command_warnings=False' in ansible.cfg to get rid of this message.
changed: [172.31.3.202]
changed: [172.31.4.162]

PLAY RECAP ***********************************************************************************
172.31.3.202               : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.31.4.162               : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

[ansible@ip-172-31-14-224 ~]$ 
```

## Ansible Vault

Ansible allows keeping sensitive data such as passwords or keys in encrypted files, rather than a plaintext in our playbooks.

Creating a new encrypted playbook
`nsible-vault create vault.yml`

Edit the encrypted playbook
`nsible-vault edit vault.yml`

To change the password
`ansible-vault rekey vault.yml`

To encrypt an existing non-encrypted playbook
`ansible-vault encrypt target.yml`

To decrypt an encrypted playbook
`ansible-vault decrypt target.yml`
  
