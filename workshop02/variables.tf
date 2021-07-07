variable docker_host {
    type = string
}

variable docker_cert_path {
    type = string
}

variable DO_token {
    type = string
    description = "this is DO token"
    sensitive = true
}

variable droplet_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable droplet_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable dov_tag {
    type = string
    description = "Image tag default to v4"
    default = "v4"
}

variable dov_instances {
    type = list(string)
    default = [ "one", "two", "three" ]
}

variable public_key {
    type = string
}

variable private_key {
    type = string
    sensitive = true
    default = "../../fred"
}
