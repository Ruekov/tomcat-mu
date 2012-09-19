#!/bin/sh

############################################
#           Adding new service             #
############################################

# Simple argparse

if [ $# != 3 ]; then
	echo "you must give 3 arguments: user, user_domain, route to tomcat app from USER path"
	exit 0
fi

$1=user_tomcat
$2=user_domain
$3=tomcat_app

# copy of configfile

cp /usr/local/apache/conf/userdata/std/2/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/2/$user_tomcat/$user_domain/cp_jkmount.conf.copy
cp /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/1/$user_tomcat/$user_domain/cp_jkmount.conf.copy
cp /usr/local/apache/conf/userdata/ssl/2/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/2/$user_tomcat/$user_domain/cp_jkmount.conf.copy
cp /usr/local/apache/conf/userdata/ssl/1/$user_tomcat/$user_domain/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/1/$user_tomcat/$user_domain/cp_jkmount.conf.copy

# adding new route to services

sed -i 's/<\/IfModule>/JkMount ${tomcat_app//'/'/'\/'} $user_tomcat \n<\/IfModule>/g'
