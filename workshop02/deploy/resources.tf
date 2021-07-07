data digitalocean_ssh_key fred {
    name = "fred"
}

data digitalocean_image mynginx {
    name = var.droplet_image
}

// create a droplet, ubuntu 20.04.x64, sgp1, s-1vcpu-1gb
// set the corresponding private key the above public key
// output the ipv4 address of the droplet
resource digitalocean_droplet nginx {
    name = "nginx"
    image = data.digitalocean_image.mynginx.id
    size = var.droplet_size
    region = var.droplet_region

    ssh_keys = [ data.digitalocean_ssh_key.fred.id ]
}

// local variables, not available outside of this 'module'
output nginx_ipv4 {
    value = digitalocean_droplet.nginx.ipv4_address
}

