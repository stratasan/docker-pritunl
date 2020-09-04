#!/bin/sh
set -e

[ -d /dev/net ] || mkdir -p /dev/net
[ -c /dev/net/tun ] || mknod /dev/net/tun c 10 200

touch /var/log/pritunl.log
touch /var/run/pritunl.pid
/bin/rm /var/run/pritunl.pid

export PRITUNL_LOG_FILE=${PRITUNL_LOG_FILE:-"/var/log/pritunl.log"}
export PRITUNL_DEBUG=${PRITUNL_DEBUG:-"false"}
export PRITUNL_BIND_ADDR=${PRITUNL_BIND_ADDR:-"0.0.0.0"}

cat << EOF >/etc/pritunl.conf
{
    "mongodb_uri": "$PRITUNL_MONGODB_URI",
    "server_key_path": "/var/lib/pritunl/pritunl.key",
    "log_path": "$PRITUNL_LOG_FILE",
    "static_cache": true,
    "server_cert_path": "/var/lib/pritunl/pritunl.crt",
    "temp_path": "/tmp/pritunl_%r",
    "bind_addr": "$PRITUNL_BIND_ADDR",
    "debug": $PRITUNL_DEBUG,
    "www_path": "/usr/share/pritunl/www",
    "local_address_interface": "auto"
}
EOF

#detach the process, sleep for 5 min, then do the thing
# --quiet so passwords don't land in logs
nohup bash -c "sleep 300 && mongo  --host $PRITUNL_MONGODB_URI --quiet /mongo-attach-all.js" >>/var/log/pritunl_journal.log 2>&1 &
# do it again at 10 min in case you missed some at 5
nohup bash -c "sleep 600 && mongo  --host $PRITUNL_MONGODB_URI --quiet /mongo-attach-all.js" >>/var/log/pritunl_journal.log 2>&1 &


exec /usr/bin/pritunl start -c /etc/pritunl.conf
