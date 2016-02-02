yum install -y wget git zip unzip vim subversion telnet

if [ -n "$http_proxy" ]; then
  git config --global http.proxy $http_proxy
  git config --global https.proxy $http_proxy
fi