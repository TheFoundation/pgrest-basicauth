#!/bin/bash
[[ -z ${REST_PASS} ]] && { 
 REST_PASS=$(for rounds in $(seq 1 24);do tr -cd '[:alnum:]_\-.' < /dev/urandom  |head -c48;echo ;done|grep -e "_" -e "\-" -e "\."|grep ^[a-zA-Z0-9]|grep [a-zA-Z0-9]$|tail -n1)
 echo "MISSING REST_PASS ... temporarily set  to: $REST_PASS"
 } 
echo "pgrest "$(caddy hash-password -p ${REST_PASS}) > /tmp/htpass

IFS='\n'
cat /etc/Caddyfile | while read line;do echo "$line"|grep -q HTPASS || echo "$line";echo "$line"|grep -q HTPASS && cat /tmp/htpass;done > /etc/caddy/Caddyfile

(cd /etc/caddy;caddy run ) &
postgrest 

