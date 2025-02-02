#!/bin/bash
[[ -z ${REST_PASS} ]] && { 
 REST_PASS=$(for rounds in $(seq 1 24);do tr -cd '[:alnum:]_\-.' < /dev/urandom  |head -c48;echo ;done|grep -e "_" -e "\-" -e "\."|grep ^[a-zA-Z0-9]|grep [a-zA-Z0-9]$|tail -n1)
 echo "MISSING REST_PASS ... temporarily set  to: $REST_PASS"
 } 
echo "pgrest "$(caddy hash-password -p ${REST_PASS}) |tee > /tmp/htpass

(echo '	basic_auth @is-del {'
cat /tmp/htpass
echo '	}') /tmp/htpass.read


[[ "$PUBLIC_READ" = "TRUE" ]] && { 
	echo > /tmp/htpass.read
	 }
IFS='\n'
cat /etc/Caddyfile | while read line;do 
  echo "$line"|grep -q HTPASS || echo "$line";
  echo "$line"|grep -q READHTPASS && cat /tmp/htpass.read && line="";
  echo "$line"|grep -q HTPASS && cat /tmp/htpass;
done > /etc/caddy/Caddyfile

[[ -z "$LOKI_URL" ]] && {
(cd /etc/caddy;caddy run ) &
postgrest  ; } ;

[[ -z "$LOKI_URL" ]] || {
(cd /etc/caddy;caddy run 2>&1 |bash /bash-logger/log-to-grafana-loki.sh "$LOKI_URL" pgrest-caddy ) &
postgrest 2>&1 |bash /bash-logger/log-to-grafana-loki.sh "$LOKI_URL" pgrest  ; } ;

exit 0

