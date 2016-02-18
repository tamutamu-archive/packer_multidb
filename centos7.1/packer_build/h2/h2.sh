CURDIR=$(cd $(dirname $0); pwd)

df -h

echo "H2 Install Start"

wget http://www.h2database.com/h2-2016-01-21.zip -O /tmp/h2.zip
unzip -q /tmp/h2.zip -d /var/lib/

echo "H2 run db create"

mkdir -p /var/run/h2
mkdir -p /var/lib/h2/db

echo "H2 config init"

cp $CURDIR/conf/initd/h2 /etc/init.d/
chmod a+x /etc/init.d/h2

systemctl disable h2
