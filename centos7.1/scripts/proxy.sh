#!/bin/bash -eux

export http_proxy=http://[proxyhost]:[port]

cat << EOT > /etc/profile.d/proxy.sh
export http_proxy=$http_proxy
export https_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
EOT
