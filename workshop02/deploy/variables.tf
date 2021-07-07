variable DO_token {
    type = string
    description = "this is DO token"
    sensitive = true
}

variable droplet_image {
    type = string
    default = "mynginx"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable droplet_size {
    type = string
    default = "s-1vcpu-1gb"
}
