#!/bin/bash
ip_node=$1
sudo apt update
sudo apt-get install -y nginx
sudo systemctl enable nginx

cat << EOF > /etc/nginx/nginx.conf
load_module /usr/lib/nginx/modules/ngx_stream_module.so;
worker_processes 4;
worker_rlimit_nofile 40000;

events {
    worker_connections 8192;
}

http {
    server {
        listen         80;
        return 301 https://$host$request_uri;
    }
}

stream {
    upstream rancher_servers {
        least_conn;
        server ${ip_node}:443 max_fails=3 fail_timeout=5s;
    }
    server {
        listen     443;
        proxy_pass rancher_servers;
    }
}
EOF

echo "Loadbalancer configured"
exit 0
