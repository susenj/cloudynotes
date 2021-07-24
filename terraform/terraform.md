# Applying my first .tf file

``` bash
susenj@susenj-vbox:~$ terraform validate
Success! The configuration is valid.

susenj@susenj-vbox:~$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.eip will be created
  + resource "aws_eip" "eip" {
      + allocation_id             = (known after apply)
      + associate_with_private_ip = "10.0.0.12"
      + association_id            = (known after apply)
      + carrier_ip                = (known after apply)
      + customer_owned_ip         = (known after apply)
      + domain                    = (known after apply)
      + id                        = (known after apply)
      + instance                  = (known after apply)
      + network_border_group      = (known after apply)
      + network_interface         = (known after apply)
      + private_dns               = (known after apply)
      + private_ip                = (known after apply)
      + public_dns                = (known after apply)
      + public_ip                 = (known after apply)
      + public_ipv4_pool          = (known after apply)
      + tags_all                  = (known after apply)
      + vpc                       = true
    }

  # aws_instance.neeraj_ubuntu will be created
  + resource "aws_instance" "neeraj_ubuntu" {
      + ami                                  = "ami-0c1a7f89451184c8b"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = "ap-south-1b"
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "app-key-pair"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "neerajk-ubuntu-webserver"
        }
      + tags_all                             = {
          + "Name" = "neerajk-ubuntu-webserver"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "a7ae17f62bdeef71e39db6f7b1a8509fa8c0ed01"
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = false
          + device_index          = 0
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "igw-neeraj"
        }
      + tags_all = {
          + "Name" = "igw-neeraj"
        }
      + vpc_id   = (known after apply)
    }

  # aws_network_interface.eni will be created
  + resource "aws_network_interface" "eni" {
      + id                 = (known after apply)
      + interface_type     = (known after apply)
      + ipv6_address_count = (known after apply)
      + ipv6_addresses     = (known after apply)
      + mac_address        = (known after apply)
      + outpost_arn        = (known after apply)
      + private_dns_name   = (known after apply)
      + private_ip         = (known after apply)
      + private_ips        = [
          + "10.0.0.12",
        ]
      + private_ips_count  = (known after apply)
      + security_groups    = (known after apply)
      + source_dest_check  = true
      + subnet_id          = (known after apply)
      + tags_all           = (known after apply)

      + attachment {
          + attachment_id = (known after apply)
          + device_index  = (known after apply)
          + instance      = (known after apply)
        }
    }

  # aws_route_table.rt will be created
  + resource "aws_route_table" "rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "prod-rt"
        }
      + tags_all         = {
          + "Name" = "prod-rt"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.rtas will be created
  + resource "aws_route_table_association" "rtas" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.allow_http will be created
  + resource "aws_security_group" "allow_http" {
      + arn                    = (known after apply)
      + description            = "Allow port 80"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "allow_http"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "neeraj_allow_http"
        }
      + tags_all               = {
          + "Name" = "neeraj_allow_http"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.allow_ssh will be created
  + resource "aws_security_group" "allow_ssh" {
      + arn                    = (known after apply)
      + description            = "Allow port 22"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "allow_ssh"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "neeraj_allow_ssh"
        }
      + tags_all               = {
          + "Name" = "neeraj_allow_ssh"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.allow_tls will be created
  + resource "aws_security_group" "allow_tls" {
      + arn                    = (known after apply)
      + description            = "Allow specific ports"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "allow_tls"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "neeraj_allow_all"
        }
      + tags_all               = {
          + "Name" = "neeraj_allow_all"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet-1 will be created
  + resource "aws_subnet" "subnet-1" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "ap-south-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.0.0/28"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet"
        }
      + tags_all                        = {
          + "Name" = "prod-subnet"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.first-vpc-by-tf will be created
  + resource "aws_vpc" "first-vpc-by-tf" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.0.0.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "production"
        }
      + tags_all                         = {
          + "Name" = "production"
        }
    }

Plan: 11 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.first-vpc-by-tf: Creating...
aws_vpc.first-vpc-by-tf: Creation complete after 10s [id=vpc-0d95568fdf912e865]
aws_subnet.subnet-1: Creating...
aws_internet_gateway.igw: Creating...
aws_security_group.allow_tls: Creating...
aws_security_group.allow_http: Creating...
aws_security_group.allow_ssh: Creating...
aws_subnet.subnet-1: Creation complete after 2s [id=subnet-00cd8b79afcfd260a]
aws_internet_gateway.igw: Creation complete after 4s [id=igw-0e8a522c3b656912e]
aws_route_table.rt: Creating...
aws_security_group.allow_tls: Creation complete after 6s [id=sg-05268e91e09305646]
aws_security_group.allow_http: Creation complete after 6s [id=sg-051839d9aebf72b25]
aws_security_group.allow_ssh: Creation complete after 7s [id=sg-0e5517c14cdb9d215]
aws_network_interface.eni: Creating...
aws_route_table.rt: Creation complete after 5s [id=rtb-0bd09d6bf4baeee30]
aws_route_table_association.rtas: Creating...
aws_route_table_association.rtas: Creation complete after 2s [id=rtbassoc-08a0f75cdab14bb66]
aws_network_interface.eni: Still creating... [10s elapsed]
aws_network_interface.eni: Still creating... [20s elapsed]
aws_network_interface.eni: Still creating... [30s elapsed]
aws_network_interface.eni: Creation complete after 33s [id=eni-0e9d16259acaf4483]
aws_eip.eip: Creating...
aws_instance.neeraj_ubuntu: Creating...
aws_eip.eip: Creation complete after 3s [id=eipalloc-01ef356fd80f2916a]
aws_instance.neeraj_ubuntu: Still creating... [10s elapsed]
aws_instance.neeraj_ubuntu: Still creating... [20s elapsed]
aws_instance.neeraj_ubuntu: Still creating... [30s elapsed]
aws_instance.neeraj_ubuntu: Creation complete after 32s [id=i-029cc88f298dbfcf4]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.
susenj@susenj-vbox:~$
```

We can ssh to the ubuntu instance that we just created and can see the webserver up and running.

```bash
neerakum@NEERAKUM-WT4 MINGW64 ~
$ ssh -i Downloads/app-key-pair.pem ubuntu@65.1.72.225
load pubkey "Downloads/app-key-pair.pem": invalid format
The authenticity of host '65.1.72.225 (65.1.72.225)' can't be established.
ECDSA key fingerprint is SHA256:Ex4E5tDkMGjW6MJkRmFLJhM6G0cXPjzI4O557zYKUtM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '65.1.72.225' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-1045-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Jul 24 04:40:28 UTC 2021

  System load:  0.45              Processes:             106
  Usage of /:   18.7% of 7.69GB   Users logged in:       0
  Memory usage: 24%               IPv4 address for eth0: 10.0.0.12
  Swap usage:   0%

93 updates can be applied immediately.
51 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-0-0-12:~$ uname -a
Linux ip-10-0-0-12 5.4.0-1045-aws #47-Ubuntu SMP Tue Apr 13 07:02:25 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
ubuntu@ip-10-0-0-12:~$ system ctl ^C
ubuntu@ip-10-0-0-12:~$ systemctl status apache2
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2021-07-24 04:39:57 UTC; 45s ago
       Docs: https://httpd.apache.org/docs/2.4/
   Main PID: 1972 (apache2)
      Tasks: 55 (limit: 1160)
     Memory: 5.6M
     CGroup: /system.slice/apache2.service
             ├─1972 /usr/sbin/apache2 -k start
             ├─1974 /usr/sbin/apache2 -k start
             └─1975 /usr/sbin/apache2 -k start

Jul 24 04:39:57 ip-10-0-0-12 systemd[1]: Starting The Apache HTTP Server...
Jul 24 04:39:57 ip-10-0-0-12 systemd[1]: Started The Apache HTTP Server.

ubuntu@ip-10-0-0-12:~$ curl localhost
your very first web server
ubuntu@ip-10-0-0-12:~$
```

Let's check a few commands related to states.

```bash
susenj@susenj-vbox:~$ terraform state list
aws_eip.eip
aws_instance.neeraj_ubuntu
aws_internet_gateway.igw
aws_network_interface.eni
aws_route_table.rt
aws_route_table_association.rtas
aws_security_group.allow_http
aws_security_group.allow_ssh
aws_security_group.allow_tls
aws_subnet.subnet-1
aws_vpc.first-vpc-by-tf
susenj@susenj-vbox:~$ terraform state show aws_route_table_association.rtas
# aws_route_table_association.rtas:
resource "aws_route_table_association" "rtas" {
    id             = "rtbassoc-08a0f75cdab14bb66"
    route_table_id = "rtb-0bd09d6bf4baeee30"
    subnet_id      = "subnet-00cd8b79afcfd260a"
}
susenj@susenj-vbox:~$ terraform state show aws_eip.eip
# aws_eip.eip:
resource "aws_eip" "eip" {
    associate_with_private_ip = "10.0.0.12"
    association_id            = "eipassoc-0fcf4646807a2bf9b"
    domain                    = "vpc"
    id                        = "eipalloc-01ef356fd80f2916a"
    network_border_group      = "ap-south-1"
    network_interface         = "eni-0e9d16259acaf4483"
    private_dns               = "ip-10-0-0-12.ap-south-1.compute.internal"
    private_ip                = "10.0.0.12"
    public_dns                = "ec2-65-1-72-225.ap-south-1.compute.amazonaws.com"
    public_ip                 = "65.1.72.225"
    public_ipv4_pool          = "amazon"
    tags_all                  = {}
    vpc                       = true
}
susenj@susenj-vbox:~$ 
```
