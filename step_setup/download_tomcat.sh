#!/bin/sh

# $2 = $user_tomcat

############################################
#Choice of the apache-tomcat server version#
############################################

case $1 in
"1") 
	echo "Installing tomcat 7.0.30"
	export versionbar="7.0.30"
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo  "Lynx is installed, now doing request to know the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-70.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-7.0.30.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat
		wget http://apache-mirror.telesys.org.ua/tomcat/tomcat-7/v7.0.30/bin/apache-tomcat-7.0.30.tar.gz
	fi
	cp apache-tomcat-7.0.30.tar.gz /home/$2/
	;;
"2") 
	echo "Installing tomcat 7.0.29"
	export versionbar="7.0.29"
	# Fastest download link for Ukraine to get tomcat
	wget http://apache.vc.ukrtel.net/tomcat/tomcat-7/v7.0.29/bin/apache-tomcat-7.0.29.tar.gz
	cp apache-tomcat-7.0.29.tar.gz /home/$2/
	;;
"3") 
	echo "Installing tomcat 6.0.35"
	export versionbar="6.0.35"
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo "Lynx is installed, now doing request to know the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-60.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-6.0.35.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat
		wget http://apache.vc.ukrtel.net/tomcat/tomcat-6/v6.0.35/bin/apache-tomcat-6.0.35.tar.gz
	fi
	cp apache-tomcat-6.0.35.tar.gz /home/$2/
	;;
"4")
	echo "Installing tomcat 5.5.35"
	export versionbar="5.5.35"
	if [ -x /usr/bin/lynx ] || [ -x /usr/sbin/lynx ];then
		echo "Lynx is installed, now asking for the best download place"
		wget $(lynx --dump http://tomcat.apache.org/download-55.cgi | grep -o "http:.*" | sed -e '\/apache-tomcat-5.5.35.tar.gz$/!d')
		else
		# Fastest download link for Ukraine to get tomcat	
		wget http://apache.cp.if.ua/tomcat/tomcat-5/v5.5.35/bin/apache-tomcat-5.5.35.tar.gz
	fi
	cp apache-tomcat-5.5.35.tar.gz /home/$2/
	;;
*)	
	echo "You must give choice between 1-4"
	exit 0
	;;
esac
