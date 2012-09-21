#!/bin/sh

############################################
#     Choice of the java jdk version       #
############################################

# In this case, we need also to unpack or install jdk in a different ways

case $1 in
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
