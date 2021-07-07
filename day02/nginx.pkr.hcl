variable region {
	type = string
}
variable DO_token {
	type = string
	sensitive = true
}

source digitalocean nginx {
	api_token = var.DO_token
	region = var.region
	image = "ubuntu-20-04-x64"
	size = "s-1vcpu-1gb"
	snapshot_name = "mynginx"
	ssh_username = "root"
}

build {
	sources = [ 
		"source.digitalocean.nginx"
	]

	provisioner ansible {
		playbook_file = "playbook_nginx.yaml"
	}
}
