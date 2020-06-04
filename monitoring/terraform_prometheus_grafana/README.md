
# Provision and deploy the Prometheus and Grafana on AWS using Terraform and Docker.


# Introduction
We will deploy a Prometheus and Grafana docker images to AWS. We will use Terraform to provision a series EC2 instance.

# Pre-requisites

- Terraform 0.18.8
- IAM access in AWS to provision the EC2 instance, VPC, subnet resources, internet gateway resources ,security groups.

# Installation and configuration

We will need to edit the prometheus.yml file and add Internal IPs of ETCD* instances created in the ETCD section. 

In this project we used the following settings.
* EC2 AMI - ami-039a49e70ea773ffc 
* EC2 Instance Type - t2.micro
* Region - US East 1
* VPC - 11.0.0.0/16
* Subnet - 11.0.1.0/24
* Port Opened - 3000, 9090 (Grafana, Prometheus UIs)

# Add internal IPs to Prometheus YAML script
```
static_configs:
    - targets: ['0.0.0.0:9090'] # TO BE REPLACED with the Output data with the internal IPs of ETCD* and port 2379
```
We will replace the line above with for example:
```
- targets: ['10.42.0.247:2379','10.42.1.251:2379','10.42.2.66:2379']
```

# Steps to run the provisioning in terraform

1. Initialize Terraform  working directory 
```
terraform init
```
2. Create Terraform execution plan
```
terraform plan
```
3. Apply Terraform plan to provision it in aws
```
terraform apply
```

# Result
```
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

Grafana_URL = http://3.235.160.82:3000
Prometheus_URL = http://3.235.160.82:9090
```

# Node Exporter
Now Grafana and Prometheus are both up and running. We will need to run node-exporter in the ec2 nodes which will the send the metrics to prometheus.

```
cd node-exporter
./node_exporter.sh
```

# AWS Peering
Since our ETCD instances are in different VPC from Prometheus and Grafana docker images we will need to add VPC Peereing.
We will go to https://console.aws.amazon.com/vpc/ VPC dashboard for that and in the Peering Connections menu select "Create Peering Connection" button. The requester will be the Prometheus VPC and another VPC (ETCD) will be the VPC to accept the Peering. When it is created we will go to Actions for the new Peering Connection and Accept it. We will make sure the new Peering Connection is Active and green.

# Grafana dashboard for ETCD monitoring
In the new Grafana UI we will go to the Dashboards and Import new dashboard from JSON file.
We can use some third party JSON for example from Grafana Labs:
https://grafana.com/api/dashboards/3070/revisions/3/download


