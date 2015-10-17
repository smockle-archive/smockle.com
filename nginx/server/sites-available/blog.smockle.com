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

    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    resolver 8.8.8.8 8.8.4.4;

    ssl_certificate /etc/nginx/ssl/blog.smockle.com.chain.crt;
    ssl_certificate_key /etc/nginx/ssl/blog.smockle.com.key;

    # Enable OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/nginx/ssl/smockle.com.root.crt;

    # HTTP Public Key Pinning
    add_header Public-Key-Pins 'pin-sha256="Zy7rIFdgdM0BgwVKiUMnUpTxkKsf/9DTTr2+TeBTsOY="; pin-sha256="l5kN3B4JQi57VN26too5Es7ZlIojhdcOCNq/wURx3SE="; pin-sha256="ZQKWeBNIiWZkzvmZlC82aBf1sZjAAL79xMfgUZykZBo="; pin-sha256="Usgl7Qgo0rS4Se9NSJWBf9qeTeSaLve6VkJR1L0FF8s="; max-age=5184000';

    # Strict Transport Security
    add_header Strict-Transport-Security "max-age=31536000";

    # config to allow the browser to render the page inside an frame or iframe
    add_header X-Frame-Options DENY;

    # disable content-type sniffing in some browsers
    add_header X-Content-Type-Options nosniff;

    # Re-enable the XSS filter for if it was disabled by the user.
    add_header X-XSS-Protection "1; mode=block";

    expires 1M;

    location / {
      return 301 https://medium.com/@smockle$request_uri;
      # proxy_pass https://medium.com/@smockle;
      #
      # proxy_set_header X-Real-IP         $remote_addr;
      # proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
      # proxy_set_header Host              $http_host;
      # proxy_set_header X-Forwarded-Proto $scheme;
      # proxy_set_header X-NginX-Proxy     true;
      #
      # proxy_pass_header X-CSRF-TOKEN;
      # proxy_buffering off;
      # proxy_redirect off;
    }
}
