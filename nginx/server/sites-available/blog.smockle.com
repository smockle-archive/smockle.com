#
# Redirect all non-encrypted to encrypted
#
server {
    server_name blog.smockle.com;

    listen 80;
    listen [::]:80;

    return 301 https://blog.smockle.com$request_uri;
}

#
# Proxy to blog address
#
server {
    server_name blog.smockle.com;

    listen 443 ssl spdy;
    listen [::]:443 ssl spdy;
    resolver 8.8.8.8 8.8.4.4;

    ssl_certificate /etc/nginx/ssl/blog.smockle.com.chain.crt;
    ssl_certificate_key /etc/nginx/ssl/blog.smockle.com.key;

    # Enable OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/nginx/ssl/smockle.com.root.crt;

    # Strict Transport Security
    add_header Strict-Transport-Security "max-age=31536000";

    expires 1M;

    location / {
      proxy_pass http://blog:2368;

      proxy_set_header X-Real-IP         $remote_addr;
      proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
      proxy_set_header Host              $http_host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header X-NginX-Proxy     true;

      proxy_pass_header X-CSRF-TOKEN;
      proxy_buffering off;
      proxy_redirect off;
    }
}
