// Write the terraform configuration blocks for the following providers
// docker, local and digitalocean 
terraform {
    required_version = ">= 1.0.0"
    required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.10.1"
    }
    local = {
        source = "hashicorp/local"
        version = "2.1.0"
    }
  }
}

// configure the providers
provider digitalocean {
    token = var.DO_token
}

provider local { }