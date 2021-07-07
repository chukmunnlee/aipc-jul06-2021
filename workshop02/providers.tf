// Write the terraform configuration blocks for the following providers
// docker, local and digitalocean 
terraform {
    required_version = ">= 1.0.0"
    required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.10.1"
    }
  }
}

provider digitalocean {
    token = var.DO_token
}
