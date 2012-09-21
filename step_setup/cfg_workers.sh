#!/bin/sh

# $user_tomcat = $1

############################################
#  making Workers.Properties config files  #
############################################

# If config file exists, load the last line to get the last port used.

if [ -f "/usr/local/jakarta/conf/tomcatusers.cfg" ]; then
	# security copy
	cp /usr/local/jakarta/tomcat/conf/workers.properties  /usr/local/jakarta/tomcat/conf/workers.properties.old
	# asking for the last port used 
	last_port=$(cat /usr/local/jakarta/conf/tomcatusers.cfg | tail -n 1 | awk '{print $3}')
	let user_port=$last_port+10
	# adding new worker to workers list
	sed -i '/worker.list=/ s/$/,'$1'/' /usr/local/jakarta/tomcat/conf/workers.properties 
	else
	$user_port=9000
	# for a fresh installations, we must keep original file
	cp /usr/local/jakarta/tomcat/conf/workers.properties /usr/local/jakarta/tomcat/conf/workers.properties.original
	cp workers.properties /usr/local/jakarta/tomcat/conf/workers.properties
	# Now using template of workers.properties
	# Adding the new one
	sed -i 's/worker.list=/worker.list='$1'/' /usr/local/jakarta/tomcat/conf/workers.properties
fi

# adding the new worker. This worker will have the same name as the user (will be easier to know who is)
# Long line: take care of \n!!!1

sed -i 's/# ----- USERS -----/# ----- USERS ----- \n# ------- TOMCAT WORKER FOR USER '$1' ---------- \nworker.'$1'.port = '$user_port' \nworker.'$1'.host = localhost \nworker.'$1'.type = ajp13 \n/' /usr/local/jakarta/tomcat/conf/workers.properties

# for the next scripts

export user_port
