ssh-keygen -b 4096 -f keys/id_rsa -C tunnels@localhost

ssh -o StrictHostKeyChecking=no -i /tunnels_id_rsa tunnels@db1_master