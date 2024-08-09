#!/bin/bash
# nginx startup script

## Update default.conf file
CONFIG_FILE="/etc/nginx/conf.d/default.conf"

## Set default values of environment variables
if [[ -z "${LISTEN_PROTOCOL}" ]]; then
	export LISTEN_PROTOCOL='http'
fi
## Set default values of environment variables

## Protocol set
if [[ "$LISTEN_PROTOCOL" = "http" ]]; then
	## Only HTTP
	sed -i 's/----LISTEN_PROTOCOL_CONF----/listen '"${LISTEN_PORT_HTTP}"';\n listen  [::]:'"${LISTEN_PORT_HTTP}"';/g' $CONFIG_FILE
elif [[ "$LISTEN_PROTOCOL" = "https" ]]; then
	## Only HTTPS
	sed -i 's/----LISTEN_PROTOCOL_CONF----/listen '"${LISTEN_PORT_HTTPS}"' ssl;\n listen  [::]:'"${LISTEN_PORT_HTTPS}"' ssl;/g' $CONFIG_FILE
elif [[ "$LISTEN_PROTOCOL" = "both" ]]; then
	sed -i 's/----LISTEN_PROTOCOL_CONF----/listen '"${LISTEN_PORT_HTTP}"';\n listen  [::]:'"${LISTEN_PORT_HTTP}"';\n listen '"${LISTEN_PORT_HTTPS}"' ssl;\n listen  [::]:'"${LISTEN_PORT_HTTPS}"' ssl;/g' $CONFIG_FILE
fi


## Certificate path check
if [[ "$LISTEN_PROTOCOL" = "https" || "$LISTEN_PROTOCOL" = "both" ]]; then
	## HTTPS 
	## using @ as delimiter instead of /
	sed -i 's@----SSL_CERT_CONF----@ssl_certificate /etc/ssl/certificates/server.crt;\n ssl_certificate_key /etc/ssl/certificates/server.key;@g' $CONFIG_FILE
else
	## HTTP
	## using @ as delimiter instead of /
	sed -i 's@----SSL_CERT_CONF----@###SSL Configuration###@g' $CONFIG_FILE
fi


## Launch NGINX now
nginx -g 'daemon off;'