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


cat << 'EOT' > /etc/profile.d/oracle.sh
export ORACLE_BASE=/opt/oracle12c/app
export ORACLE_HOME=$ORACLE_BASE/oracle/product/12.1.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH
EOT

echo "export ORACLE_SID=$DATABASE" >> /etc/profile.d/oracle.sh


rm -rf /opt/database

cp $CURDIR/conf/initd/oracle /etc/init.d
chmod a+x /etc/init.d/oracle
systemctl enable oracle
systemctl disable oracle

sed -i -e "s/dbhome_1:N/dbhome_1:Y/" /etc/oratab


### Clean up
## rm $CURDIR/install/*.* -f

JRE_LOC="$(cd $(cd $(dirname $(readlink -e `which java`));pwd)/../;pwd)"


cat << EOT > /opt/database/ora_inst_jpn.sh
./runInstaller -jreLoc $JRE_LOC
EOT

chdmo a+x /opt/database/ora_inst_jpn.sh
