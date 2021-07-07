variable region {
	type = string
	default = "sgp1"
}
variable DO_token {
	type = string
	sensitive = true
	# set this variable by reading the environment variable
	default = env("DO_TOKEN")
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
		playbook_file = "playbook.yaml"
	}
}
