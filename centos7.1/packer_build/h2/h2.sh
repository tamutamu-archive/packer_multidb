CURDIR=$(cd $(dirname $0); pwd)

wget http://www.h2database.com/h2-2016-01-21.zip -O /tmp/h2.zip
unzip /tmp/h2.zip -d /var/lib/

cp $CURDIR/conf/initd/h2 /etc/init.d/
chmod a+x /etc/init.d/h2
##sudo systemctl enable h2
