yum install -y wget zip unzip
CURDIR=$(cd $(dirname $0); pwd)

### unzip installer ###
find $CURDIR/install -name *.zip | xargs -n1 unzip -q -d /opt/


### Oracle12c Install ###
export ORACLE_BASE=/opt/oracle12c/app
export ORACLE_INST=/opt/oracle12c


cd /etc/yum.repos.d/
wget http://public-yum.oracle.com/public-yum-ol7.repo
cd /etc/pki/rpm-gpg/
wget http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -O RPM-GPG-KEY-oracle

yum install -y oracle-rdbms-server-12cR1-preinstall
sudo echo "oracle:$DB_PASSWORD" | chpasswd


mkdir -p $ORACLE_INST
chown -R oracle:oinstall $ORACLE_INST

cat $CURDIR/conf/ora_inst.rsp.tmpl | sed -e "s@#ORACLE_INST#@$ORACLE_INST@g" -e "s@#ORACLE_BASE#@$ORACLE_BASE@g" > /opt/oracle12c/ora_inst.rsp
su - oracle -c "/opt/database/runInstaller -ignoreSysPrereqs -waitforcompletion -silent -responseFile /opt/oracle12c/ora_inst.rsp"


su - root -c "/opt/oracle12c/oraInventory/orainstRoot.sh"
su - root -c "/opt/oracle12c/app/oracle/product/12.1.0/dbhome_1/root.sh"

sed -f $BASEDIR/sed_createdb.lst $CURDIR/conf/createdb.rsp.tmpl > /opt/oracle12c/createdb.rsp


cat << 'EOT' > /etc/profile.d/oracle.sh
export ORACLE_BASE=/opt/oracle12c/app
export ORACLE_HOME=$ORACLE_BASE/oracle/product/12.1.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH
EOT

echo "export ORACLE_SID=$DATABASE" >> /etc/profile.d/oracle.sh


su - oracle -c ". /etc/profile.d/oracle.sh && dbca -silent -responseFile /opt/oracle12c/createdb.rsp"

rm -rf /opt/database

cp $CURDIR/conf/initd/oracle /etc/init.d
systemctl disable oracle
