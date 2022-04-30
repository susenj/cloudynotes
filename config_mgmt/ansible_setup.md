**Ansible** is a configuration management tool.
The Ansible **server** and its **clients** connect via **SSH**. 
Ansible clients themselves don't need any installation or configuration for Ansible.

Once Ansible is installed, edit `/etc/ansible/hosts` to include the client IP addresses under a batch.

```
[demo]
172.31.4.162
172.31.3.202
```
Edit `/etc/ansible/ansible.cfg` file and use the following parameters:

```
inventory      = /etc/ansible/hosts
sudo_user      = root
```

Create an ansible user(name: **ansible** with same password preferred) on all the hosts. Add it to `sudoers`.

`ansible ALL=(ALL)       NOPASSWD: ALL`

Use `ssh-keygen` to generate a keypair in the Ansible server and copy the public key to each of the clients. This helps the ansible user to run commands without getting prompted for the password..

We are all set now.
