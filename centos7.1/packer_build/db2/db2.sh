CURDIR=$(cd $(dirname $0); pwd)


tar -zxf $CURDIR/install/*expc*.gz -C /usr/local/src/
tar -zxf $CURDIR/install/*nlpack*.gz -C /usr/local/src/expc
cp $CURDIR/conf/db2expc.rsp /usr/local/src/expc/


cd /usr/local/src/expc
sudo ./db2setup -r db2expc.rsp -f nobackup

sed -f $BASEDIR/sed_createdb.lst $CURDIR/conf/createdb.sql.tmpl > $CURDIR/conf/createdb.sql

su - db2inst1 -c "db2 -tvf $CURDIR/conf/createdb.sql"
su - db2inst1 -c "db2stop"

rm -rf /usr/local/src/expc