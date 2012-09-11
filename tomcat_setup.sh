#!/bin/sh

# Config file on /usr/local/jakarta/conf/tomcatusers.cfg

# VARS
# $user_domain
# $user_tomcat
# $user_port
# $user_jdk

############################################
#     Checking the required variables      #
############################################

#if [ "$JAVA_HOME" = "" ]; then
#	echo "you must install a jdk and define JAVA_HOME envoirement variable"
#	exit 0
#fi

# simply parser

if [ $# != 4 ]; then
	echo "you must give 4 arguments: user, user_domain, tomcat version and jdk version"
	exit 0
fi

user_tomcat=$1
user_domain=$2
user_version=$3
user_jdk=$4

############################################
#Choice of the apache-tomcat server version#
############################################

case user_version in
"1") 
	echo "Installing tomcat 7.0.30"
	versionbar="7.0.30"
	# Fastest download link for Ukraine to get tomcat
	wget http://apache-mirror.telesys.org.ua/tomcat/tomcat-7/v7.0.30/bin/apache-tomcat-7.0.30.tar.gz
	;;
"2") 
	echo "Installing tomcat 7.0.29"
	versionbar="7.0.29"
	# Fastest download link for Ukraine to get tomcat
	wget http://apache.vc.ukrtel.net/tomcat/tomcat-7/v7.0.29/bin/apache-tomcat-7.0.29.tar.gz
	;;
"3") 
	echo "Installing tomcat 6.0.35"
	versionbar="6.0.35"
	# Fastest download link for Ukraine to get tomcat
	wget http://apache.vc.ukrtel.net/tomcat/tomcat-6/v6.0.35/bin/apache-tomcat-6.0.35.tar.gz
	;;
"4")
	echo "Installing tomcat 5.5.35"
	versionbar="5.5.35"
	# Fastest download link for Ukraine to get tomcat	
	wget http://apache.cp.if.ua/tomcat/tomcat-5/v5.5.35/bin/apache-tomcat-5.5.35.tar.gz
	;;
*)	
	echo "You must give choice between 1-4"
	exit 0
	;;
esac

############################################
#		Choice of the java jdk version	   #
############################################

# In this case, we need also to unpack or install jdk in a different ways

case user_jdk in
"1") 
	echo "Installing JDK 7"
	versionjdk="jdk7"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz"
	# Unpack JDK
	tar xvzf jdk-7-linux-x64.tar.gz
	rm jdk-7-linux-x64.tar.gz
	cp -Rf jdk-1.7.0 /usr/local/java/
	rm -Rf jdk-1.7.0
	export JAVA_HOME=/usr/local/java/
	;;
"2") 
	echo "Installing JDK 6"
	versionjdk="jdk6"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk6-downloads-1637591.html;" http://download.oracle.com/otn-pub/java/jdk/6u33-b03/jdk-6u33-linux-x64.bin
	# Unpack JDK
	chmod 755 jdk-6u33-linux-x64.bin 
	./jdk-6u33-linux-x64.bin 
	rm jdk-6u33-linux-x64.bin 
	cp -Rf cp jdk1.6.0_33 /usr/local/java/
	rm -Rf jdk1.6.0_33
	export JAVA_HOME=/usr/local/java/
	;;
"3") 
	echo "Installing tomcat 6.0.35"
	versionjdk="jdk5"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavasebusiness%2Fdownloads%2Fjava-archive-downloads-javase5-419410.html;" http://download.oracle.com/otn-pub/java/jdk/1.5.0_14/jdk-1_5_0_14-linux-i586.bin
	# Unpack JDK
	chmod 755 jdk-1_5_0_14-linux-i586.bin 
	./jdk-1_5_0_14-linux-i586.bin
	rm jdk-1_5_0_14-linux-i586.bin
	export JAVA_HOME=/usr/local/java/
	;;
"4")
	echo "Write the path to JDK"
	read javahome
	export JAVA_HOME=$javahome
	;;
*)	
	echo "You must give choice between 1-4"
	exit 0
	;;
esac

############################################
#installing and config apache-tomcat server#
############################################

# make directories and untar the apache tomcat server 

mkdir $HOME/tomcat-server/
cd $HOME/tomcat-server/
mv ../apache-tomcat-$versionbar.tar.gz ./
tar xvzf apache-tomcat-.tar.gz --strip-components=1
rm apache-tomcat-$versionbar.tar.gz

# install jsvc

cd bin
tar xvzf commons-daemon-native.tar.gz
cd commons-daemon-*
cd unix
chmod +x configure
./configure
make
cp jsvc ..

############################################
# making Workers.Propierties config files  #
############################################

# securty copy

cp /usr/local/jakarta/tomcat/conf/workers.properties  /usr/local/jakarta/tomcat/conf/workers.properties.old

# If config file exists, load the last line to get the last port used.

if [ -f "/usr/local/jakarta/conf/USERS.txt" ]; then
	last_port=$(cat /usr/local/jakarta/conf/USERS.txt | tail -n 1 | awk '{print $3}')
	let user_port=$last_port+10
	# adding new worker to workers list
	sed -i '/worker.list=/ s/$/,'$user_tomcat'/' /usr/local/jakarta/tomcat/conf/workers.properties 
	else
    $user_port=9000
    # for a fresh installations, we must keep original file
    cp /usr/local/jakarta/tomcat/conf/workers.propierties /usr/local/jakarta/tomcat/conf/workers.properties.original
    # if is it the first time, worker.propierties it's still with "default workers". Commenting it..
    sed -i '/worker.ajp13/ s/^/#/' /usr/local/jakarta/tomcat/conf/workers.propierties
    sed -i '/worker.ajp12/ s/^/#/' /usr/local/jakarta/tomcat/conf/workers.propierties
    #removing also from balances and workers and adding the new one
	sed -i 's/worker.list=/worker.list='$user_tomcat',/' /usr/local/jakarta/tomcat/conf/workers.propierties
fi

# adding the new worker
# Maybe it's better using sed:
#'# ------- TOMCAT WORKER FOR USER $user_tomcat ---------- \n worker.$user_tomcat.port = $user_tomcat \n worker.$user_tomcat.host = localhost \n worker.$user_tomcat.type = ajp13 \n'

echo "# ------- TOMCAT WORKER FOR USER $user_tomcat ----------
worker.$user_tomcat.port = $user_port
worker.$user_tomcat.host = localhost
worker.$user_tomcat.type = ajp13" >> /usr/local/jakarta/tomcat/conf/workers.propierties

# awk '/"tomcat worker"/{getline;print $0}' server.properties

############################################
#     editing servers.xml config file      #
############################################

# backup copy of the original server.xml file

cp $HOME/tomcat-server/conf/server.xml $HOME/tomcat-server/conf/server.xml.old

# removing HTTP service

sed -i '/protocol="HTTP\/1.1"/d' $HOME/tomcat-server/conf/server.xml.old

# adapting AJP service

sed -i 's/<Connector port="8009" protocol="AJP\/1.3" redirectPort="8443" \/>/<Connector port="'$numport'" protocol="AJP\/1.3"\/>/g' $HOME/tomcat-server/conf/server.xml.old

# adding new host service

sed -i 's/<\/Engine>/     <Host name="'$user_domain'" appBase="\/home\/'$user_tomcat'\/public_html">\n \t  \t <Alias>'$user_domain'<\/Alias>\n  \t  \t <Context path="" reloadable="true" docBase="\/home\/'$user_tomcat'\/public_html" debug="1" unpackWARs="true" autoDeploy="true"\/>\n  \t <\/Host>\n    <\/Engine>/g' $HOME/tomcat-server/conf/server.xml.old

############################################
# editing EasyApache's jkmod config files  #
############################################

# Security copy

cp /usr/local/apache/conf/userdata/std/2/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/2/$user_tomcat/$user_domain/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/ssl/2/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/2/$user_tomcat/$user_domain/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/ssl/1/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/1/$user_tomcat/$user_domain/cp_jkmount.conf.old

# Changes default EasyApache service by the new one

sed -i 's/ajp13/'$user_tomcat'/g' /usr/local/apache/conf/userdata/std/2/$user_tomcat/$user_domain/cp_jkmount.conf
sed -i 's/ajp13/'$user_tomcat'/g' /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf
sed -i 's/ajp13/'$user_tomcat'/g' /usr/local/apache/conf/userdata/ssl/2/$user_tomcat/$user_domain/cp_jkmount.conf
sed -i 's/ajp13/'$user_tomcat'/g' /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf

############################################
#          editing startup script          #
############################################

# Security copy

cp $HOME/tomcat-server/tomcat/bin/startup.sh $HOME/tomcat-server/bin/startup.sh.old

# Must force the config to have the correct JDK writing on startup.sh second line an export of new JAVA_HOME

sed -i '2iexport JAVA_HOME='${JAVA_HOME//'/'/'\/'}'' $HOME/tomcat-server/bin/startup.sh

# We must to limit the java memory!
# http://stackoverflow.com/questions/2724820/tomcat-how-to-limit-the-maximum-memory-tomcat-will-use

############################################
#   Saving all changes on the users file   #
############################################

echo "$tomcat_user $user_domain $user_port $user_version" >> /usr/local/jakarta/conf/tomcatusers.cfg
