CURDIR=$(cd $(dirname $0); pwd)


tar zxvf $CURDIR/install/*expc*.gz -C /usr/local/src/
tar zxvf $CURDIR/install/*nlpack*.gz -C /usr/local/src/expc
cp $CURDIR/install/db2expc.rsp /usr/local/src/expc/


cd /usr/local/src/expc
sudo ./db2setup -r db2expc.rsp -f nobackup

rm -rf /usr/local/src/expc

su - db2inst1 -c "db2 -tvf $CURDIR/createdb.sql"
