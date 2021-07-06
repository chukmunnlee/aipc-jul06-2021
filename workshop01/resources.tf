// write a docker_image using this image chukmunnlee/dov-bear:v4
// make the tag (after :) as parameter, interpolation, set the default to v4
resource docker_image img_dov {
    name = "chukmunnlee/dov-bear:${var.dov_tag}"
}

// deploy an instance of dov-bear image
resource docker_container cont_dov {
    // meta argument
    count = length(var.dov_instances)

    name = "dov-${count.index}"
    image = docker_image.img_dov.latest

    ports {
        internal = 3000
        // let docker assign the external port
    }

    env = [ "INSTANCE_NAME=${var.dov_instances[count.index]}" ]
}

resource digitalocean_ssh_key mykey {
    name = "default"
    public_key = file(var.public_key)
}

// create a droplet, ubuntu 20.04.x64, sgp1, s-1vcpu-1gb
// set the corresponding private key the above public key
// output the ipv4 address of the droplet
resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.droplet_image
    size = var.droplet_size
    region = var.droplet_region

    ssh_keys = [ digitalocean_ssh_key.mykey.fingerprint ]

    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.private_key)
        host = self.ipv4_address
    }

    // apt update -y
    // apt upgrade -y
    // apt install nginx -y
    provisioner remote-exec {
        inline = [
            "apt update -y", "apt upgrade -y",
            "apt install nginx -y",
            "systemctl enable nginx",
            "systemctl start nginx",
        ]
    }

    // generate the nginx.conf

    // copy the file to droplet /etc/nginx/nginx.conf

    // restart nginx
    // /usr/sbin/nginx -s reload
}

// local variables, not available outside of this 'module'
locals {
    // list comprehension
    ext_ports = [ for c in docker_container.cont_dov: "${c.ports[0].external}/${c.ports[0].protocol}" ]
}

// generate artefacts
resource local_file externl_ports {
    filename = "external_ports.txt"
    content = templatefile("./external_ports.txt.tpl", {
        ports = local.ext_ports
    })
}

// outputs
output image_name {
    description = "Container name"
    value = docker_container.cont_dov[*].name
}

output external_ports {
    value = docker_container.cont_dov[*].ports[0].external
}

output external_ports_v2 {
    value = local.ext_ports
}

output nginx_ipv4 {
    value = digitalocean_droplet.nginx.ipv4_address
}

/*
output single_external_port {
    // return only the port number
    //value = "${docker_container.cont_dov.ports[0].external}/${docker_container.cont_dov.ports[0].protocol}"
    value = docker_container.cont_dov.ports[0].external
}
*/