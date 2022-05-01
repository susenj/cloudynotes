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

Ansible server runs setup module to get the current config/status of all the clients.

Example:

```
[ansible@ip-172-31-14-224 ~]$ ansible demo -b -m setup
[WARNING]: Platform linux on host 172.31.4.162 is using the discovered Python interpreter at /usr/bin/python, but future installation of
another Python interpreter could change this. See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html
for more information.
172.31.4.162 | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "172.31.4.162"
        ],
        "ansible_all_ipv6_addresses": [
            "fe80::89a:b6ff:fe29:5812"
        ],
        "ansible_apparmor": {
            "status": "disabled"
        },
        "ansible_architecture": "x86_64",
        "ansible_bios_date": "08/24/2006",
        "ansible_bios_version": "4.11.amazon",
        "ansible_cmdline": {
            "BOOT_IMAGE": "/boot/vmlinuz-5.10.109-104.500.amzn2.x86_64",
            "biosdevname": "0",
            "console": "ttyS0,115200n8",
            "net.ifnames": "0",
            "nvme_core.io_timeout": "4294967295",
            "rd.emergency": "poweroff",
            "rd.shell": "0",
            "ro": true,
            "root": "UUID=ea38fcc7-c4ec-43f4-a087-626a399be03a"
        },
        "ansible_date_time": {
            "date": "2022-05-01",
            "day": "01",
            "epoch": "1651369114",
            "hour": "01",
            "iso8601": "2022-05-01T01:38:34Z",
            "iso8601_basic": "20220501T013834415466",
            "iso8601_basic_short": "20220501T013834",
            "iso8601_micro": "2022-05-01T01:38:34.415466Z",
            "minute": "38",
            "month": "05",
            "second": "34",
            "time": "01:38:34",
            "tz": "UTC",
            "tz_offset": "+0000",
            "weekday": "Sunday",
            "weekday_number": "0",
            "weeknumber": "17",
            "year": "2022"
        },
        "ansible_default_ipv4": {
            "address": "172.31.4.162",
            "alias": "eth0",
            "broadcast": "172.31.15.255",
            "gateway": "172.31.0.1",
            "interface": "eth0",
            "macaddress": "0a:9a:b6:29:58:12",
            "mtu": 9001,
            "netmask": "255.255.240.0",
            "network": "172.31.0.0",
            "type": "ether"
        },
        "ansible_default_ipv6": {},
        "ansible_device_links": {
            "ids": {},
            "labels": {
                "xvda1": [
                    "\\x2f"
                ]
            },
            "masters": {},
            "uuids": {
                "xvda1": [
                    "ea38fcc7-c4ec-43f4-a087-626a399be03a"
                ]
            }
        },
        "ansible_devices": {
            "xvda": {
                "holders": [],
                "host": "",
                "links": {
                    "ids": [],
                    "labels": [],
                    "masters": [],
                    "uuids": []
                },
                "model": null,
                "partitions": {
                    "xvda1": {
                        "holders": [],
                        "links": {
                            "ids": [],
                            "labels": [
                                "\\x2f"
                            ],
                            "masters": [],
                            "uuids": [
                                "ea38fcc7-c4ec-43f4-a087-626a399be03a"
                            ]
                        },
                        "sectors": "16773087",
                        "sectorsize": 512,
                        "size": "8.00 GB",
                        "start": "4096",
                        "uuid": "ea38fcc7-c4ec-43f4-a087-626a399be03a"
                    }
                },
                "removable": "0",
                "rotational": "0",
                "sas_address": null,
                "sas_device_handle": null,
                "scheduler_mode": "mq-deadline",
                "sectors": "16777216",
                "sectorsize": "512",
                "size": "8.00 GB",
                "support_discard": "0",
                "vendor": null,
                "virtual": 1
            }
        },
        "ansible_distribution": "Amazon",
        "ansible_distribution_file_parsed": true,
        "ansible_distribution_file_path": "/etc/system-release",
        "ansible_distribution_file_variety": "Amazon",
        "ansible_distribution_major_version": "2",
        "ansible_distribution_release": "NA",
        "ansible_distribution_version": "2",
        "ansible_dns": {
            "nameservers": [
                "172.31.0.2"
            ],
            "options": {
                "attempts": "5",
                "timeout": "2"
            },
            "search": [
                "ap-south-1.compute.internal"
            ]
        },
        "ansible_domain": "ap-south-1.compute.internal",
        "ansible_effective_group_id": 0,
        "ansible_effective_user_id": 0,
        "ansible_env": {
            "HOME": "/root",
            "LANG": "en_US.UTF-8",
            "LOGNAME": "root",
            "LS_COLORS": "rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:",
            "MAIL": "/var/mail/ansible",
            "PATH": "/sbin:/bin:/usr/sbin:/usr/bin",
            "PWD": "/home/ansible",
            "SHELL": "/bin/bash",
            "SHLVL": "1",
            "SUDO_COMMAND": "/bin/sh -c echo BECOME-SUCCESS-pvqhjqklymcecxqbzboargnjxtlscspy ; /usr/bin/python /home/ansible/.ansible/tmp/ansible-tmp-1651369112.36-3689-112970972785329/AnsiballZ_setup.py",
            "SUDO_GID": "1001",
            "SUDO_UID": "1001",
            "SUDO_USER": "ansible",
            "TERM": "xterm",
            "USER": "root",
            "USERNAME": "root",
            "XDG_SESSION_ID": "2",
            "_": "/usr/bin/python"
        },
        "ansible_eth0": {
            "active": true,
            "device": "eth0",
            "features": {
                "esp_hw_offload": "off [fixed]",
                "esp_tx_csum_hw_offload": "off [fixed]",
                "fcoe_mtu": "off [fixed]",
                "generic_receive_offload": "on",
                "generic_segmentation_offload": "on",
                "highdma": "off [fixed]",
                "hw_tc_offload": "off [fixed]",
                "l2_fwd_offload": "off [fixed]",
                "large_receive_offload": "off [fixed]",
                "loopback": "off [fixed]",
                "macsec_hw_offload": "off [fixed]",
                "netns_local": "off [fixed]",
                "ntuple_filters": "off [fixed]",
                "receive_hashing": "off [fixed]",
                "rx_all": "off [fixed]",
                "rx_checksumming": "on [fixed]",
                "rx_fcs": "off [fixed]",
                "rx_gro_hw": "off [fixed]",
                "rx_gro_list": "off",
                "rx_udp_tunnel_port_offload": "off [fixed]",
                "rx_vlan_filter": "off [fixed]",
                "rx_vlan_offload": "off [fixed]",
                "rx_vlan_stag_filter": "off [fixed]",
                "rx_vlan_stag_hw_parse": "off [fixed]",
                "scatter_gather": "on",
                "tcp_segmentation_offload": "on",
                "tls_hw_record": "off [fixed]",
                "tls_hw_rx_offload": "off [fixed]",
                "tls_hw_tx_offload": "off [fixed]",
                "tx_checksum_fcoe_crc": "off [fixed]",
                "tx_checksum_ip_generic": "off [fixed]",
                "tx_checksum_ipv4": "on [fixed]",
                "tx_checksum_ipv6": "on",
                "tx_checksum_sctp": "off [fixed]",
                "tx_checksumming": "on",
                "tx_esp_segmentation": "off [fixed]",
                "tx_fcoe_segmentation": "off [fixed]",
                "tx_gre_csum_segmentation": "off [fixed]",
                "tx_gre_segmentation": "off [fixed]",
                "tx_gso_list": "off [fixed]",
                "tx_gso_partial": "off [fixed]",
                "tx_gso_robust": "on [fixed]",
                "tx_ipxip4_segmentation": "off [fixed]",
                "tx_ipxip6_segmentation": "off [fixed]",
                "tx_lockless": "off [fixed]",
                "tx_nocache_copy": "off",
                "tx_scatter_gather": "on",
                "tx_scatter_gather_fraglist": "off [fixed]",
                "tx_sctp_segmentation": "off [fixed]",
                "tx_tcp6_segmentation": "on",
                "tx_tcp_ecn_segmentation": "off [fixed]",
                "tx_tcp_mangleid_segmentation": "off",
                "tx_tcp_segmentation": "on",
                "tx_tunnel_remcsum_segmentation": "off [fixed]",
                "tx_udp_segmentation": "off [fixed]",
                "tx_udp_tnl_csum_segmentation": "off [fixed]",
                "tx_udp_tnl_segmentation": "off [fixed]",
                "tx_vlan_offload": "off [fixed]",
                "tx_vlan_stag_hw_insert": "off [fixed]",
                "udp_fragmentation_offload": "off",
                "vlan_challenged": "off [fixed]"
            },
            "hw_timestamp_filters": [],
            "ipv4": {
                "address": "172.31.4.162",
                "broadcast": "172.31.15.255",
                "netmask": "255.255.240.0",
                "network": "172.31.0.0"
            },
            "ipv6": [
                {
                    "address": "fe80::89a:b6ff:fe29:5812",
                    "prefix": "64",
                    "scope": "link"
                }
            ],
            "macaddress": "0a:9a:b6:29:58:12",
            "module": "xen_netfront",
            "mtu": 9001,
            "pciid": "vif-0",
            "promisc": false,
            "timestamping": [
                "tx_software",
                "rx_software",
                "software"
            ],
            "type": "ether"
        },
        "ansible_fibre_channel_wwn": [],
        "ansible_fips": false,
        "ansible_form_factor": "Other",
        "ansible_fqdn": "ip-172-31-4-162.ap-south-1.compute.internal",
        "ansible_hostname": "ip-172-31-4-162",
        "ansible_hostnqn": "",
        "ansible_interfaces": [
            "lo",
            "eth0"
        ],
        "ansible_is_chroot": false,
        "ansible_iscsi_iqn": "",
        "ansible_kernel": "5.10.109-104.500.amzn2.x86_64",
        "ansible_kernel_version": "#1 SMP Wed Apr 13 20:31:43 UTC 2022",
        "ansible_lo": {
            "active": true,
            "device": "lo",
            "features": {
                "esp_hw_offload": "off [fixed]",
                "esp_tx_csum_hw_offload": "off [fixed]",
                "fcoe_mtu": "off [fixed]",
                "generic_receive_offload": "on",
                "generic_segmentation_offload": "on",
                "highdma": "on [fixed]",
                "hw_tc_offload": "off [fixed]",
                "l2_fwd_offload": "off [fixed]",
                "large_receive_offload": "off [fixed]",
                "loopback": "on [fixed]",
                "macsec_hw_offload": "off [fixed]",
                "netns_local": "on [fixed]",
                "ntuple_filters": "off [fixed]",
                "receive_hashing": "off [fixed]",
                "rx_all": "off [fixed]",
                "rx_checksumming": "on [fixed]",
                "rx_fcs": "off [fixed]",
                "rx_gro_hw": "off [fixed]",
                "rx_gro_list": "off",
                "rx_udp_tunnel_port_offload": "off [fixed]",
                "rx_vlan_filter": "off [fixed]",
                "rx_vlan_offload": "off [fixed]",
                "rx_vlan_stag_filter": "off [fixed]",
                "rx_vlan_stag_hw_parse": "off [fixed]",
                "scatter_gather": "on",
                "tcp_segmentation_offload": "on",
                "tls_hw_record": "off [fixed]",
                "tls_hw_rx_offload": "off [fixed]",
                "tls_hw_tx_offload": "off [fixed]",
                "tx_checksum_fcoe_crc": "off [fixed]",
                "tx_checksum_ip_generic": "on [fixed]",
                "tx_checksum_ipv4": "off [fixed]",
                "tx_checksum_ipv6": "off [fixed]",
                "tx_checksum_sctp": "on [fixed]",
                "tx_checksumming": "on",
                "tx_esp_segmentation": "off [fixed]",
                "tx_fcoe_segmentation": "off [fixed]",
                "tx_gre_csum_segmentation": "off [fixed]",
                "tx_gre_segmentation": "off [fixed]",
                "tx_gso_list": "off [fixed]",
                "tx_gso_partial": "off [fixed]",
                "tx_gso_robust": "off [fixed]",
                "tx_ipxip4_segmentation": "off [fixed]",
                "tx_ipxip6_segmentation": "off [fixed]",
                "tx_lockless": "on [fixed]",
                "tx_nocache_copy": "off [fixed]",
                "tx_scatter_gather": "on [fixed]",
                "tx_scatter_gather_fraglist": "on [fixed]",
                "tx_sctp_segmentation": "on",
                "tx_tcp6_segmentation": "on",
                "tx_tcp_ecn_segmentation": "on",
                "tx_tcp_mangleid_segmentation": "on",
                "tx_tcp_segmentation": "on",
                "tx_tunnel_remcsum_segmentation": "off [fixed]",
                "tx_udp_segmentation": "off [fixed]",
                "tx_udp_tnl_csum_segmentation": "off [fixed]",
                "tx_udp_tnl_segmentation": "off [fixed]",
                "tx_vlan_offload": "off [fixed]",
                "tx_vlan_stag_hw_insert": "off [fixed]",
                "udp_fragmentation_offload": "off",
                "vlan_challenged": "on [fixed]"
            },
            "hw_timestamp_filters": [],
            "ipv4": {
                "address": "127.0.0.1",
                "broadcast": "",
                "netmask": "255.0.0.0",
                "network": "127.0.0.0"
            },
            "ipv6": [
                {
                    "address": "::1",
                    "prefix": "128",
                    "scope": "host"
                }
            ],
            "mtu": 65536,
            "promisc": false,
            "timestamping": [
                "tx_software",
                "rx_software",
                "software"
            ],
            "type": "loopback"
        },
        "ansible_local": {},
        "ansible_lsb": {},
        "ansible_lvm": {
            "lvs": {},
            "pvs": {},
            "vgs": {}
        },
        "ansible_machine": "x86_64",
        "ansible_machine_id": "ec241e799eaf2c0ee222f87da91ab53c",
        "ansible_memfree_mb": 672,
        "ansible_memory_mb": {
            "nocache": {
                "free": 850,
                "used": 114
            },
            "real": {
                "free": 672,
                "total": 964,
                "used": 292
            },
            "swap": {
                "cached": 0,
                "free": 0,
                "total": 0,
                "used": 0
            }
        },
        "ansible_memtotal_mb": 964,
        "ansible_mounts": [
            {
                "block_available": 1683407,
                "block_size": 4096,
                "block_total": 2094075,
                "block_used": 410668,
                "device": "/dev/xvda1",
                "fstype": "xfs",
                "inode_available": 4144622,
                "inode_total": 4193216,
                "inode_used": 48594,
                "mount": "/",
                "options": "rw,noatime,attr2,inode64,logbufs=8,logbsize=32k,noquota",
                "size_available": 6895235072,
                "size_total": 8577331200,
                "uuid": "ea38fcc7-c4ec-43f4-a087-626a399be03a"
            }
        ],
        "ansible_nodename": "ip-172-31-4-162.ap-south-1.compute.internal",
        "ansible_os_family": "RedHat",
        "ansible_pkg_mgr": "yum",
        "ansible_proc_cmdline": {
            "BOOT_IMAGE": "/boot/vmlinuz-5.10.109-104.500.amzn2.x86_64",
            "biosdevname": "0",
            "console": [
                "tty0",
                "ttyS0,115200n8"
            ],
            "net.ifnames": "0",
            "nvme_core.io_timeout": "4294967295",
            "rd.emergency": "poweroff",
            "rd.shell": "0",
            "ro": true,
            "root": "UUID=ea38fcc7-c4ec-43f4-a087-626a399be03a"
        },
        "ansible_processor": [
            "0",
            "GenuineIntel",
            "Intel(R) Xeon(R) CPU E5-2676 v3 @ 2.40GHz"
        ],
        "ansible_processor_cores": 1,
        "ansible_processor_count": 1,
        "ansible_processor_threads_per_core": 1,
        "ansible_processor_vcpus": 1,
        "ansible_product_name": "HVM domU",
        "ansible_product_serial": "ec2b362c-7b3f-aee7-7d34-9c55598e0660",
        "ansible_product_uuid": "ec2b362c-7b3f-aee7-7d34-9c55598e0660",
        "ansible_product_version": "4.11.amazon",
        "ansible_python": {
            "executable": "/usr/bin/python",
            "has_sslcontext": true,
            "type": "CPython",
            "version": {
                "major": 2,
                "micro": 18,
                "minor": 7,
                "releaselevel": "final",
                "serial": 0
            },
            "version_info": [
                2,
                7,
                18,
                "final",
                0
            ]
        },
        "ansible_python_version": "2.7.18",
        "ansible_real_group_id": 0,
        "ansible_real_user_id": 0,
        "ansible_selinux": {
            "status": "Missing selinux Python library"
        },
        "ansible_selinux_python_present": false,
        "ansible_service_mgr": "systemd",
        "ansible_ssh_host_key_ecdsa_public": "AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBF0gtFxnTExCHkCDOUorJY5BpEgcY8gyMIsrLRipa8zyHW1eRY8Oc8AaKyI/xyQAhFqi5e/LeaM2U8wKGAUKobg=",
        "ansible_ssh_host_key_ed25519_public": "AAAAC3NzaC1lZDI1NTE5AAAAIJTVj04qo2ALAH9RUr1L7KugZ7kmV7Ro7SoPCicyDYGl",
        "ansible_ssh_host_key_rsa_public": "AAAAB3NzaC1yc2EAAAADAQABAAABAQDaTfkALZ2WKzr+7Ww4I3ITTnTcQf0LiIPCUyBJ8ae8qwN7SWBhulQMn3bMRiVS9O9wZiRkszW5iQa2BfglC3rOyMnJDt2CXqY9/WxsY3aMfmr4ocADWjcQliV95JcaSyBRLj/qpI/FhtfNxTbyWysm9iylBGda3ybgw5fVSSzKCZ8oa+LymC28LTBw7BA/a5rrA58tZ4bn/uC3MZzh9srfreAW34gtEJYkjKt9qybByIHunG+w/USzMrFSMAlUowrqDuQVoB/r060mJ9pOpm5DtFam1r8pe5jlefzVGoAKgZigPOrwqWzvV/t3R6cs1Lhn/hYOfNMJQcGRnMXi84Dt",
        "ansible_swapfree_mb": 0,
        "ansible_swaptotal_mb": 0,
        "ansible_system": "Linux",
        "ansible_system_capabilities": [],
        "ansible_system_capabilities_enforced": "False",
        "ansible_system_vendor": "Xen",
        "ansible_uptime_seconds": 868,
        "ansible_user_dir": "/root",
        "ansible_user_gecos": "root",
        "ansible_user_gid": 0,
        "ansible_user_id": "root",
        "ansible_user_shell": "/bin/bash",
        "ansible_user_uid": 0,
        "ansible_userspace_architecture": "x86_64",
        "ansible_userspace_bits": "64",
        "ansible_virtualization_role": "guest",
        "ansible_virtualization_type": "xen",
        "discovered_interpreter_python": "/usr/bin/python",
        "gather_subset": [
            "all"
        ],
        "module_setup": true
    },
    "changed": false
}
[ansible@ip-172-31-14-224 ~]$
```
