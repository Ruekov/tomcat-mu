#!/bin/sh

remove_tomcat() {
	echo "Removing $1"
	# Shuting down apache tomcat server
	$HOME/tomcat-server/bin/shutdown.sh
	# We must kill java instances related to user
	# TODO LIST
	# Removing apache-tomcat server
	rm -Rf $HOME/tomcat-server/
	# Removing changes on jkmod
	cp /usr/local/apache/conf/userdata/std/2/$1/$2/cp_jkmount.conf.old  /usr/local/apache/conf/userdata/std/2/$1/$2/cp_jkmount.conf
	cp /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf.old  /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf
	cp /usr/local/apache/conf/userdata/ssl/2/$1/$2/cp_jkmount.conf.old  /usr/local/apache/conf/userdata/ssl/2/$1/$2/cp_jkmount.conf
	cp /usr/local/apache/conf/userdata/ssl/1/$1/$2/cp_jkmount.conf.old  /usr/local/apache/conf/userdata/ssl/1/$1/$2/cp_jkmount.conf
	# Removing changes on workers.propierties
	sed -i 's/worker.'$1'//' /usr/local/jakarta/tomcat/conf/workers.propierties
	sed -i 's/# ------- TOMCAT WORKER FOR USER '$user_tomcat' ----------//' /usr/local/jakarta/tomcat/conf/workers.propierties
	sed -i 's/'$user_tomcat',//' /usr/local/jakarta/tomcat/conf/workers.propierties
		# maybe it's the last one
	sed -i 's/,'$user_tomcat'//' /usr/local/jakarta/tomcat/conf/workers.propierties
}

echo "Chose action:"
echo "1.- Remove an User"
echo "2.- Change an User"
read selection

case selection in
"1") echo "write user name:"
	read user_tomcat
	 echo "write user domain:"
	read user_domain
	remove_tomcat $user_tomcat $user_domain
	;;
"2") echo "write user name:"
	read user_tomcat
	echo "write user domain:"
	read user_domain
	remove_tomcat $user_tomcat $user_domain
	./tomcat_setup_interactive.sh
	;;
esac
