#!/bin/bash -eux

export BASEDIR=/var/packer_build

# Import Setting
. $BASEDIR/settings.conf


# sed script for DB Settings
sed -e "s/%DATABASE%/$DATABASE/" $BASEDIR/sed_createdb.lst.tmpl > $BASEDIR/sed_createdb.lst
sed -i "s/%DB_USER%/$DB_USER/" $BASEDIR/sed_createdb.lst
sed -i "s/%DB_PASSWORD%/$DB_PASSWORD/" $BASEDIR/sed_createdb.lst


# common
bash -l $BASEDIR/common_dev/common_dev.sh
bash -l $BASEDIR/java/java_dev.sh


# database
bash -l $BASEDIR/h2/h2.sh
bash -l $BASEDIR/mysql/mysql.sh
bash -l $BASEDIR/postgresql/postgresql.sh
bash -l $BASEDIR/db2/db2.sh
bash -l $BASEDIR/oracle12c/oracle.sh


# terminate
bash -l $BASEDIR/base/cleanup.sh
bash -l $BASEDIR/base/zerodisk.sh
