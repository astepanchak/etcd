# Set up environment

Before running Terraform, we must set some Terraform variables defining the environment.

- `control_cidr`: The CIDR of your IP. The Bastion host will accept only traffic from this address. Ex.  `123.45.67.89/32`. It is mandatory.
- `default_keypair_public_key`: Valid public key corresponding to the Identity (PEM) you will use to SSH into instances, for example `"ssh-rsa AAA....xyz"`. It is also mandatory.


There are some optional defines for the following variables:

- `default_keypair_name`: AWS KeyPair name for all instances (Default: "etcd-sample")
- `vpc_name`: VPC Name. Must be unique in the AWS Account (Default: "ETCD")
- `elb_name`: ELB Name. Can only contain characters valid for DNS names. Must be unique in the AWS Account (Default: "etcd")
- `owner`: `Owner` tag added to all AWS resources. No functional use. It may become useful to filter your resources on AWS console if you are sharing the same AWS account with others. (Default: "ETCD").

The easiest way to do it is creating a `terraform.tfvars` variable file in `./terraform` directory. Terraform automatically includes this file.

Our version of this file is as follows:

```
default_keypair_public_key = "ssh-rsa AAAAxxxxxx...xxxx"
control_cidr = "aaa.bbb.ccc.ddd/XX"
default_keypair_name = "andreys-MBP"
vpc_name = "Andrey ETCD"
elb_name = "andrey-etcd"
owner = "Andrey"
region  = "us-east-1"
zones = ["us-east-1a","us-east-1b","us-east-1c"]
node_count = 3
bastion_ami = "ami-039a49e70ea773ffc"
etcd_ami = "ami-039a49e70ea773ffc"
```

## How To Setup AWS Region

To use a spacific Region, we will need to set two additional Terraform variables:

- `region`: AWS Region 
- `zones`: Comma separated list of AWS Availability Zones, in the selected Region (for example: "eu-west-1a,eu-west-1b,eu-west-1c")
- `node_count`: Number of AZ to use. Must be <= the number of AZ in `zones`
- `bastion_ami` and `etcd_ami`: Choose AMI with Unbuntu 18.04, available in the new Region

We also have to **manually** modify `./ansible/inventory/ec2.ini`, changing `regions = us-east-1` to the Region we are using.
