#!/bin/sh

# $user_tomcat = $1
# $user_domain = $2

############################################
#     editing servers.xml config file      #
############################################

# backup copy of the original server.xml file

cp /home/$1/tomcat-server/conf/server.xml /home/$1/tomcat-server/conf/server.xml.old

# removing HTTP service

sed -i '/protocol="HTTP\/1.1"/d' /home/$1/tomcat-server/conf/server.xml

# adapting AJP service

sed -i 's/<Connector port="8009" protocol="AJP\/1.3" redirectPort="8443" \/>/<Connector port="'$user_port'" protocol="AJP\/1.3"\/>/g' /home/$1/tomcat-server/conf/server.xml

# adding new host service

sed -i 's/<\/Engine>/     <Host name="'$2'" appBase="\/home\/'$1'\/public_html">\n \t  \t <Alias>'$2'<\/Alias>\n  \t  \t <Context path="" reloadable="true" docBase="\/home\/'$1'\/public_html" debug="1" unpackWARs="true" autoDeploy="true"\/>\n  \t <\/Host>\n    <\/Engine>/g' /home/$1/tomcat-server/conf/server.xml

# changing shutdown port (Also it's nice idea to change SHUTDOWN for another word)

let numport2=$user_port+10000
sed -i 's/<Server port="8005" shutdown="SHUTDOWN">/ <Server port="'$numport2'" shutdown="SHUTDOWN">/g' /home/$1/tomcat-server/conf/server.xml

