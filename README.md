## How to start up a laravel server using terraform

### Add this to your terraform file
```
provider "aws" {
    region = "ap-south-1" # Set your aws region
}

provider "aws" {
    region = "ap-south-1"
}

module "laravel" {
    source = "github.com/veerajongit/terraform-laravel" # You can clone the repo and use the directory name instead
    public_key = "" # Your public key will go here
}
```

run  
`terraform init && terraform apply`  
check your file changes and approve

## Access your server
`ssh -i {path_to_your_rsa} ubuntu@{your_server_ip}`