#!/bin/sh

# $1 user_tomcat

############################################
#installing and config apache-tomcat server#
############################################

# make directories and untar the apache tomcat server 

mkdir /home/$1/tomcat-server/
cd /home/$1/tomcat-server/
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
