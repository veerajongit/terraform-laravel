## How to start up a laravel server using terraform

### Add this to your terraform file
```
module "laravel" {
    source = "github.com/veerajongit/
    terraform-laravel" # You can clone the repo 
    and use the directory name instead

    aws_region = "aws_region" # AWS Region to setup your EC2 instance
    ami        = "ami-id" # This is region specific
    public_key = "" # Your public key to access your id
    ssh_access_ipv4 = ["0.0.0.0/0"] # List of ipv4 strings to provide ssh access
    ssh_access_ipv6 = [::/0] # List of ipv6 strings to provide ssh access
}
```

## run the command and check your server changes to approve
`terraform init && terraform apply`  


## Access your server
`ssh -i {path_to_your_rsa} ubuntu@{your_server_ip}`