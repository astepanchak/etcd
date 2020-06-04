# Credentials

## KeyPair

We will need a valid AWS Identity (PEM) file and the corresponding Public Key. Terraform will import the KeyPair and Ansible will use the Identity to SSH into the machines.
We will extract the public key from the PEM file using the following command:

```
$ ssh-keygen -y -f <keyfile>.pem
```

## Terraform and Ansible authentication

Both Terraform and Ansible expect AWS credentials in environment variables:
```
$ export AWS_ACCESS_KEY_ID=<access-key-id>
$ export AWS_SECRET_ACCESS_KEY="<secret-key>"
```

Ansible also expects ssh identity loaded into ssh agent:
```
$ eval `ssh-agent`
$ ssh-add <keypair-name>.pem
```
