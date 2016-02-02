yum remove -y java-*

cd /tmp

##### oracle Java 8 #####
#wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.rpm -O /tmp/jdk-8u65-linux-x64.rpm
#rpm -ivh jdk-8u65-linux-x64.rpm


#cat << 'EOT' >> /etc/profile.d/java_env.sh
#export JAVA_HOME=/usr/java/default
#export JRE_HOME=/usr/java/default
#export PATH=$PATH:$JAVA_HOME/bin
#EOT

#. /etc/profile.d/java_env.sh


##### open jdk 8 #####
yum install -y java-1.8.0-openjdk-devel

echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' > /etc/profile.d/jdk.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/jdk.sh
. /etc/profile.d/jdk.sh

