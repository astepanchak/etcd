# Provision infrastructure, with Terraform

We will need to run the following Terraform commands from `./terraform` subdirectory.

```
$ terraform plan
$ terraform apply
```

When infrastructure provisioning is complete, Terraform outputs some useful information:
```

Apply complete! Resources: 5 added, 1 changed, 4 destroyed.

Outputs:

bastion_ip = 54.160.57.233
etcd_dns = andrey-etcd-271665528.us-east-1.elb.amazonaws.com
etcd_ip = 10.42.0.241 10.42.1.239 10.42.2.222
ip_authorised_for_inbound_traffic = 217.66.157.0/24
```


## Generated SSH config

Terraform generates `./ssh.cfg` in project root directory.
Ansible uses this configuration to SSH into internal instances through the Bastion.

We will also use this configuration file to SSH into internal nodes using a single command in order to implement Prometheus monitoring.
