DEBUG=${DEBUG:-true}

cat << EOF >/taiga/taiga-front-dist/dist/conf.json
{
    "loginFormType": "ldap",
    "api": "/api/v1/",
    "eventsUrl": null,
    "eventsMaxMissedHeartbeats": 5,
    "eventsHeartbeatIntervalTime": 60000,
    "debug": ${DEBUG},
    "debugInfo": false,
    "defaultLanguage": "en",
    "themes": ["taiga"],
    "defaultTheme": "taiga",
    "publicRegisterEnabled": true,
    "feedbackEnabled": true,
    "privacyPolicyUrl": null,
    "termsOfServiceUrl": null,
    "maxUploadFileSize": null,
    "contribPlugins": []
}
EOF

cat << EOF >/etc/nginx/conf.d/taiga.conf
server {
    listen 80 default_server;
    server_name _;

    large_client_header_buffers 4 32k;
    client_max_body_size 50M;
    charset utf-8;

    # Frontend
    location / {
        root /taiga/taiga-front-dist/dist/;
        try_files \$uri \$uri/ /index.html;
    }

    # Backend
    location /api {
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Scheme \$scheme;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_pass http://taigaback:8001/api;
        proxy_redirect off;
    }

    # Django admin access (/admin/)
    location /admin {
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Scheme \$scheme;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_pass http://taigaback:8001\$request_uri;
        proxy_redirect off;
    }

    # Static files
    location /static {
        alias /taiga/static;
    }

    # Media files
    location /media {
        alias /taiga/media;
    }
}
EOF
