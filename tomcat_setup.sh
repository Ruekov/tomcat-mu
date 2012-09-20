#!/bin/sh

# Config file on /usr/local/jakarta/conf/tomcatusers.cfg

# VARS
# $user_domain
# $user_tomcat
# $user_port
# $user_jdk
# $user_mem

############################################
#     Checking the required variables      #
############################################

# Simple argparse

if [ $# != 5 ]; then
	echo "you must give 5 arguments: user, user_domain, tomcat version, jdk version and memory for the jvm"
	exit 0
fi

user_tomcat=$1 #without spaces and simbols
user_domain=$2 #domain with or not www (directory)
user_version=$3 #tomcat version to install
user_jdk=$4 #jdk version to install (if are installed, didn't install again)
user_mem=$5 #memory for jdk vm


############################################
#    Adding to cPanel new tomcat Domain    #
############################################

/scripts/addservlets --domain=$user_domain

############################################
#Choice of the apache-tomcat server version#
############################################

case user_version in
"1") 
	echo "Installing tomcat 7.0.30"
	versionbar="7.0.30"
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo  "Lynx is installed, now doing request to know the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-70.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-7.0.30.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat
		wget http://apache-mirror.telesys.org.ua/tomcat/tomcat-7/v7.0.30/bin/apache-tomcat-7.0.30.tar.gz
	fi
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
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo "Lynx is installed, now doing request to know the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-60.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-6.0.35.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat
		wget http://apache.vc.ukrtel.net/tomcat/tomcat-6/v6.0.35/bin/apache-tomcat-6.0.35.tar.gz
	fi
	;;
"4")
	echo "Installing tomcat 5.5.35"
	versionbar="5.5.35"
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo "Lynx is installed, now asking for the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-55.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-5.5.35.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat	
		wget http://apache.cp.if.ua/tomcat/tomcat-5/v5.5.35/bin/apache-tomcat-5.5.35.tar.gz
	fi
	;;
*)	
	echo "You must give choice between 1-4"
	exit 0
	;;
esac

############################################
#     Choice of the java jdk version       #
############################################

# In this case, we need also to unpack or install jdk in a different ways

case user_jdk in
"1") 
	if [-d "/usr/local/java/jdk-1.7.0"]; then
			echo "Already Installed"
			export JAVA_HOME=/usr/local/java/jdk-1.7.0
	fi
	echo "Installing JDK 7"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz"
	# Unpack JDK
	tar xvzf jdk-7-linux-x64.tar.gz
	rm jdk-7-linux-x64.tar.gz
	cp -Rf jdk-1.7.0 /usr/local/java/
	rm -Rf jdk-1.7.0
	export JAVA_HOME=/usr/local/java/jdk-1.7.0
	;;
"2") 
	if [-d "/usr/local/java/jdk1.6.0_33"]; then
			echo "Already Installed"
			export JAVA_HOME=/usr/local/java/jdk1.6.0_33
	fi
	echo "Installing JDK 6"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk6-downloads-1637591.html;" http://download.oracle.com/otn-pub/java/jdk/6u33-b03/jdk-6u33-linux-x64.bin
	# Unpack JDK
	chmod 755 jdk-6u33-linux-x64.bin 
	./jdk-6u33-linux-x64.bin 
	rm jdk-6u33-linux-x64.bin 
	cp -Rf cp jdk1.6.0_33 /usr/local/java/
	rm -Rf jdk1.6.0_33
	export JAVA_HOME=/usr/local/java/jdk1.6.0_33
	;;
"3") 
	if [-d "/usr/local/java/jdk1.6.0_33"]; then
			echo "Already Installed"
			export JAVA_HOME=/usr/local/java/jdk1.5.0_14
	fi	
	echo "Installing JDK5"
	# Link to get JDK
	wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavasebusiness%2Fdownloads%2Fjava-archive-downloads-javase5-419410.html;" http://download.oracle.com/otn-pub/java/jdk/1.5.0_14/jdk-1_5_0_14-linux-i586.bin
	# Unpack JDK
	chmod 755 jdk-1_5_0_14-linux-i586.bin 
	./jdk-1_5_0_14-linux-i586.bin
	rm jdk-1_5_0_14-linux-i586.bin
	cp -Rf cp jdk1.5.0_14 /usr/local/java/
	rm -Rf jdk1.5.0_14
	export JAVA_HOME=/usr/local/java/jdk1.5.0_14
	;;
"4")
	echo "Write the path to JDK"
	read javahome
	if [ "$JAVA_HOME" = "" ]; then
		echo "you must install a jdk and define JAVA_HOME envoirement variable"
		exit 0
	fi
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

mkdir /home/$user_tomcat/tomcat-server/
cd /home/$user_tomcat/tomcat-server/
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
#  making Workers.Properties config files  #
############################################

# If config file exists, load the last line to get the last port used.

if [ -f "/usr/local/jakarta/conf/tomcatusers.cfg" ]; then
	# securty copy
	cp /usr/local/jakarta/tomcat/conf/workers.properties  /usr/local/jakarta/tomcat/conf/workers.properties.old
	# asking for the last port used 
	last_port=$(cat /usr/local/jakarta/conf/tomcatusers.cfg | tail -n 1 | awk '{print $3}')
	let user_port=$last_port+10
	# adding new worker to workers list
	sed -i '/worker.list=/ s/$/,'$user_tomcat'/' /usr/local/jakarta/tomcat/conf/workers.properties 
	else
	$user_port=9000
	# for a fresh installations, we must keep original file
	cp /usr/local/jakarta/tomcat/conf/workers.properties /usr/local/jakarta/tomcat/conf/workers.properties.original
	cp workers.properties /usr/local/jakarta/tomcat/conf/workers.properties
	# Now using template of workers.properties
	# Adding the new one
	sed -i 's/worker.list=/worker.list='$user_tomcat'/' /usr/local/jakarta/tomcat/conf/workers.properties
fi

# adding the new worker
# Long line: take care of \n!!!1

sed -i 's/# ----- USERS -----/# ----- USERS ----- \n# ------- TOMCAT WORKER FOR USER '$user_tomcat' ---------- \nworker.'$user_tomcat'.port = '$user_port' \nworker.'$user_tomcat'.host = localhost \nworker.'$user_tomcat'.type = ajp13 \n/' /usr/local/jakarta/tomcat/conf/workers.properties

############################################
#     editing servers.xml config file      #
############################################

# backup copy of the original server.xml file

cp /home/$user_tomcat/tomcat-server/conf/server.xml /home/$user_tomcat/tomcat-server/conf/server.xml.old

# removing HTTP service

sed -i '/protocol="HTTP\/1.1"/d' /home/$user_tomcat/tomcat-server/conf/server.xml

# adapting AJP service

sed -i 's/<Connector port="8009" protocol="AJP\/1.3" redirectPort="8443" \/>/<Connector port="'$numport'" protocol="AJP\/1.3"\/>/g' /home/$user_tomcat/tomcat-server/conf/server.xml

# adding new host service

sed -i 's/<\/Engine>/     <Host name="'$user_domain'" appBase="\/home\/'$user_tomcat'\/public_html">\n \t  \t <Alias>'$user_domain'<\/Alias>\n  \t  \t <Context path="" reloadable="true" docBase="\/home\/'$user_tomcat'\/public_html" debug="1" unpackWARs="true" autoDeploy="true"\/>\n  \t <\/Host>\n    <\/Engine>/g' /home/$user_tomcat/tomcat-server/conf/server.xml

# changing shutdown port (Also it's nice idea to change SHUTDOWN for another word)

let numport2=$numport+10000
sed -i 's/<Server port="8005" shutdown="SHUTDOWN">/ <Server port="$numport2" shutdown="SHUTDOWN">/g' /home/$user_tomcat/tomcat-server/conf/server.xml

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

cp /home/$user_tomcat/tomcat-server/tomcat/bin/startup.sh /home/$user_tomcat/tomcat-server/bin/startup.sh.old

# Must force the config to have the correct JDK writing on startup.sh second line an export of new JAVA_HOME

sed -i '2iexport JAVA_HOME='${JAVA_HOME//'/'/'\/'}'' /home/$user_tomcat/tomcat-server/bin/startup.sh

# We must to limit the java memory!
# http://stackoverflow.com/questions/2724820/tomcat-how-to-limit-the-maximum-memory-tomcat-will-use

sed -i '2iexport JAVA_OPTS="-Xmx'$user_mem'm"' /home/$user_tomcat/tomcat-server/bin/startup.sh

############################################
#   Saving all changes on the users file   #
############################################

echo "$user_tomcat $user_domain $user_port $user_version $user_mem" >> /usr/local/jakarta/conf/tomcatusers.cfg

############################################
#        Rebooting Cpanel Tomcat           #
############################################

# Stop Apache Tomcat
/usr/sbin/stoptomcat

# Restart Apache Server
/usr/local/cpanel/scripts/restartsrv_apache

############################################
#  Changing Rights of the diferent files   #
############################################

# change rights of modification of server.xml 

chmod 755 /home/$user_tomcat/tomcat-server/bin/shutdown.sh

# change rights of modification of startup script

chmod 755 /home/$user_tomcat/tomcat-server/bin/startup.sh
