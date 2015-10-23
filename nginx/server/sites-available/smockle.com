#
# Redirect encrypted www to encrypted non-www
#
server {
    server_name www.smockle.com;
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    # resolver 8.8.8.8 8.8.4.4 valid=300s;
    # resolver_timeout 5s;

    ssl_certificate /etc/nginx/ssl/smockle.com.chain.crt;
    ssl_certificate_key /etc/nginx/ssl/smockle.com.key;

    # Enable OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/nginx/ssl/smockle.com.root.crt;

    # HTTP Public Key Pinning
    add_header Public-Key-Pins 'pin-sha256="bHx8nd2uGDqtx5yCju/pZieOirdYR/NfPwsXAxmtHec="; pin-sha256="xGKXju2QkRjkNMkjjkFK+GZ8IPh58uopt8djE8pjrPY="; pin-sha256="/xlbX3P+POOnWu9GTqB/hJaLOsSfg59NMCNvkX2iBRQ="; pin-sha256="8wtFe6mr1NoCTZNEqfyrgPyxzul3R4fJ1q+TN5S05aY="; max-age=5184000';

    # Strict Transport Security
    add_header Strict-Transport-Security "max-age=31536000";

    # config to allow the browser to render the page inside an frame or iframe
    add_header X-Frame-Options DENY;

    # disable content-type sniffing in some browsers
    add_header X-Content-Type-Options nosniff;

    # Re-enable the XSS filter for if it was disabled by the user.
    add_header X-XSS-Protection "1; mode=block";

    # With Content Security Policy (CSP) enabled  you can tell the browser that it
    # can only download content from the domains you explicitly allow
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; img-src 'self' data:; style-src 'self'; font-src 'self'; object-src 'none'";

    return 301 https://smockle.com$request_uri;
}

#
# Redirect unencrypted (www|non-www) to encrypted non-www
#
server {
    server_name www.smockle.com smockle.com;
    listen 80;
    listen [::]:80;

    return 301 https://smockle.com$request_uri;
}

#
# Serve static files
#
server {
    server_name smockle.com;
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    # resolver 8.8.8.8 8.8.4.4 valid=300s;
    # resolver_timeout 5s;

    ssl_certificate /etc/nginx/ssl/smockle.com.chain.crt;
    ssl_certificate_key /etc/nginx/ssl/smockle.com.key;

    # Enable OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/nginx/ssl/smockle.com.root.crt;

    # HTTP Public Key Pinning
    add_header Public-Key-Pins 'pin-sha256="bHx8nd2uGDqtx5yCju/pZieOirdYR/NfPwsXAxmtHec="; pin-sha256="xGKXju2QkRjkNMkjjkFK+GZ8IPh58uopt8djE8pjrPY="; pin-sha256="/xlbX3P+POOnWu9GTqB/hJaLOsSfg59NMCNvkX2iBRQ="; pin-sha256="8wtFe6mr1NoCTZNEqfyrgPyxzul3R4fJ1q+TN5S05aY="; max-age=5184000';

    # Strict Transport Security
    add_header Strict-Transport-Security "max-age=31536000";

    # config to allow the browser to render the page inside an frame or iframe
    add_header X-Frame-Options DENY;

    # disable content-type sniffing in some browsers
    add_header X-Content-Type-Options nosniff;

    # Re-enable the XSS filter for if it was disabled by the user.
    add_header X-XSS-Protection "1; mode=block";

    # With Content Security Policy (CSP) enabled  you can tell the browser that it
    # can only download content from the domains you explicitly allow
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; img-src 'self' data:; style-src 'self'; font-src 'self'; object-src 'none'";

    expires 1M;

    location ~ /.*(\.(css|js|xml|txt|jpg|jpeg|gif|png|webp|jpf|ico|gz|svg|svgz|ttf|otf|woff|woff2|eot|mp4|ogg|ogv|webm))$ {
      expires max;
      root /var/www/static;
      access_log off;
    }

    location / {
      root /var/www/static;
      rewrite ^ /index.html break;
    }

    # opt-in to the future
    add_header "X-UA-Compatible" "IE=Edge,chrome=1";

    # location / {
    #   proxy_pass http://www:8080;
    #
    #   proxy_set_header X-Real-IP         $remote_addr;
    #   proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    #   proxy_set_header Host              $http_host;
    #   proxy_set_header X-Forwarded-Proto $scheme;
    #   proxy_set_header X-NginX-Proxy     true;
    #
    #   proxy_pass_header X-CSRF-TOKEN;
    #   proxy_buffering off;
    #   proxy_redirect off;
    # }
}
