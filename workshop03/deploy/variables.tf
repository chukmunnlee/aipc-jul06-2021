variable DO_token {
    type = string
    sensitive = true
}
variable droplet_size {
    type = string
    default = "s-1vcpu-2gb"
}

variable droplet_region {
    type = string
    default = "sgp1"
}

variable private_key {
    type = string
    sensitive = true
    default = "../../../fred"
}

variable cs_version {
    type = string
    default = "3.10.2"
}

variable cs_password {
    type = string
    sensitive = true
    default = "changeit"
}