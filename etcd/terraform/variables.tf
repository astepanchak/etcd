variable default_keypair_public_key {
  description = "Public Key of the default keypair"
}

variable control_cidr {
  description = "CIDR you are connecting from: inbound traffic will be allowed from this IPs"
}

variable default_keypair_name {
  description = "Name of the KeyPair used for all nodes"
  default = "etcd-default"
}

variable vpc_name {
  description = "Name of the VPC"
  default = "etcd-default"
}

variable elb_name {
  description = "Name of the ELB"
  default = "etcd"
}


variable owner {
  default = "ETCD"
  # If we are going to share the same AWS account with others, we can easily filter your resources on AWS console.
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "ETCD01" 

# Networking setup
variable "region" {
  default = "us-east-1"
}

variable "zones" {
  description = "Availability Zones"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "node_count" {
  description = "Number of etcd nodes to use (one per AZ)"
  # Must be <= the number of 'zones'
  default = 3
}

variable vpc_cidr {
  default = "10.42.0.0/16"
}

# Used in ssh.cfg. Must match our vpc_cidr.
variable vpc_cidr_glob {
  default = "10.42.*"
}

variable internal_dns_zone_name {
  default = "vpc.aws"
  # Must match the zone name defined in ./ansible/group_vars/all/vars.yml!!!
}

variable etcd_client_port {
  default = "2379"
}
variable etcd_peer_port {
  default = "2380"
}


# Instances Setup
variable etcd_ami {
  description = "AMI for etcd nodes"
  default = "ami-039a49e70ea773ffc" // Unbuntu 18.04 LTS (us-east-1)
}

variable etcd_user {
  default = "ubuntu"
}

variable etcd_instance_type {
  default = "t2.micro"
  # I sed micro instances to save money. 
  # If in PROD env - installations should use bigger one.
}

variable bastion_ami {
  description = "AMI for Bastion node"
  default = "ami-039a49e70ea773ffc" // Unbuntu 18.04 LTS (us-east-1)
}

variable bastion_user {
  default = "ubuntu"
}

variable bastion_instance_type {
  default = "t2.micro"
}

# ETCD data volumes setup
variable etcd_data_volume_size {
  default = 5
}

variable etcd_data_volume_type {
  default = "standard"
  # I used standard disk to save money. 
  # Production installations should probably use SSD!!!
}
