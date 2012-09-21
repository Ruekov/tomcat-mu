#!/bin/sh

# $1 = $user_tomcat
# $2 = $user_mem

############################################
#          editing startup script          #
############################################

# Security copy

cp /home/$1/tomcat-server/tomcat/bin/startup.sh /home/$1/tomcat-server/bin/startup.sh.old

# Must force the config to have the correct JDK writing on startup.sh second line an export of new JAVA_HOME

sed -i '2iexport JAVA_HOME='${JAVA_HOME//'/'/'\/'}'' /home/$1/tomcat-server/bin/startup.sh

# We must to limit the java memory!
# http://stackoverflow.com/questions/2724820/tomcat-how-to-limit-the-maximum-memory-tomcat-will-use

sed -i '2iexport JAVA_OPTS="-Xmx'$2'm"' /home/$1/tomcat-server/bin/startup.sh
