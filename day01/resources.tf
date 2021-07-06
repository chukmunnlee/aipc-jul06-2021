resource docker_image img_fortune {
    name = "chukmunnlee/fortune:v2"
}

resource docker_container cont_fortune {
    name = "fortune"
    image = docker_image.img_fortune.latest

    ports {
        internal = 3000
        external = 8080
    }
}