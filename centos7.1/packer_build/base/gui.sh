CURDIR=$(cd $(dirname $0); pwd)

yum -y groupinstall "GNOME Desktop" "X Window System" "Japanese Support"

yum -y install ibus-kkc vlgothic-*
localectl set-locale LANG=ja_JP.UTF-8

systemctl set-default graphical.target
