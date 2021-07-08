all:
    hosts:
        code-server:
            ansible_host: ${ipv4_address}
            ansible_user: root
            ansible_connection: ssh
            ansible_private_key_file: ${private_key}
            cs_password: ${cs_password}
            cs_domain: ${cs_domain}