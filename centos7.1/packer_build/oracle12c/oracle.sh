yum install -y wget zip unzip
CURDIR=$(cd $(dirname $0); pwd)

### unzip installer ###
find $CURDIR/install -name *.zip | xargs -n1 unzip -d /opt/


### Oracle12c Install ###
export ORACLE_BASE=/opt/oracle12c


cd /etc/yum.repos.d/
wget http://public-yum.oracle.com/public-yum-ol7.repo
cd /etc/pki/rpm-gpg/
wget http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -O RPM-GPG-KEY-oracle

yum install -y oracle-rdbms-server-12cR1-preinstall
sudo echo "oracle:password" | chpasswd


mkdir -p $ORACLE_BASE
chown -R oracle:oinstall $ORACLE_BASE


cat << EOT > /opt/ora_inst.rsp
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v12.1.0
oracle.install.option=INSTALL_DB_SWONLY
ORACLE_HOSTNAME=localhost
UNIX_GROUP_NAME=oinstall
INVENTORY_LOCATION=$ORACLE_BASE/oraInventory
SELECTED_LANGUAGES=ja,en
ORACLE_BASE=$ORACLE_BASE/app
ORACLE_HOME=$ORACLE_BASE/app/oracle/product/12.1.0/dbhome_1
oracle.install.db.InstallEdition=EE
oracle.install.db.DBA_GROUP=dba
oracle.install.db.OPER_GROUP=dba
oracle.install.db.BACKUPDBA_GROUP=dba
oracle.install.db.DGDBA_GROUP=dba
oracle.install.db.KMDBA_GROUP=dba
DECLINE_SECURITY_UPDATES=true
EOT

su - oracle -c "/opt/database/runInstaller -ignoreSysPrereqs -waitforcompletion -silent -responseFile /opt/ora_inst.rsp"


su - root -c "/opt/oracle12c/oraInventory/orainstRoot.sh"
su - root -c "/opt/oracle12c/app/oracle/product/12.1.0/dbhome_1/root.sh"



cat << EOT > /opt/createdb.rsp
[GENERAL]
RESPONSEFILE_VERSION = "12.1.0"
OPERATION_TYPE = "createDatabase"

[CREATEDATABASE]
GDBNAME = "orcl"
SID = "orcl"
SYSPASSWORD = "password"
SYSTEMPASSWORD = "password"
SERVICEUSERPASSWORD = "password"
DBSNMPPASSWORD = "password"
TEMPLATENAME = "General_Purpose.dbc"
CHARACTERSET = "AL32UTF8"
NATIONALCHARACTERSET = "AL16UTF16"

CREATEASCONTAINERDATABASE = false
#NUMBEROFPDBS = 1
#PDBNAME = testpdb
EOT


cat << 'EOT' > /etc/profile.d/oracle.sh
export ORACLE_SID=orcl
export ORACLE_BASE=/opt/oracle12c
export ORACLE_HOME=$ORACLE_BASE/app/oracle/product/12.1.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH
EOT

su - oracle -c ". /etc/profile.d/oracle.sh && dbca -silent -responseFile /opt/createdb.rsp"

## rm -rf /opt/database

cp $CURDIR/conf/oracle /etc/init.d
systemctl disable oracle
