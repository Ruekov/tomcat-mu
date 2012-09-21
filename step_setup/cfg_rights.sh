#!/bin/sh

############################################
#  Changing Rights of the diferent files   #
############################################

# change rights of modification of server.xml 

chmod 755 /home/$1/tomcat-server/bin/shutdown.sh

# change rights of modification of startup script

chmod 755 /home/$1/tomcat-server/bin/startup.sh

############################################
#        Rebooting Cpanel Tomcat           #
############################################

# Stop Apache Tomcat
/usr/sbin/stoptomcat

# Restart Apache Server
/usr/local/cpanel/scripts/restartsrv_apache

