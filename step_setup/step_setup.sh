#!/bin/sh

# Config file on /usr/local/jakarta/conf/tomcatusers.cfg

# VARS
# $user_domain
# $user_tomcat
# $user_port
# $user_jdk
# $user_mem

############################################
#     SETUP STEP BY STEP (TO TEST IT)      #
############################################


############################################
#    Adding to cPanel new tomcat Domain    #
############################################

echo "User to install Apache Tomcat"
read user_tomcat
echo "User Domain to enable Apache Tomcat"
read user_domain
/scripts/addservlets --domain=$user_domain

############################################
#          Download Apache Tomcat          #
############################################

echo "Which Version of Tomcat do you want install?"
echo "1. Tomcat 7.0.30 \n"
echo "2. Tomcat 7.0.29 \n"
echo "3. Tomcat 6.0.35 \n"
echo "4. Tomcat 5.5.35 \n"
read user_version
./download_tomcat.sh $user_version $user_tomcat

############################################
#        Downloading Oracle Java JDK       #
############################################

echo "Choose JDK version"
echo "1. JDK 7 x64 \n"
echo "2. JDK 6 x64 \n"
echo "3. JDK 5 i586 \n"
echo "4. Other (write path to installed jdk) \n"
read user_jdk
./download_jdk.sh $user_jdk

############################################
#             Installing Tomcat            #
############################################

./setup_tomcat.sh $user_tomcat

############################################
#           Configuring workers            #
############################################

./cfg_workers.sh $user_tomcat

############################################
#         Configuring jkmod files          #
############################################

./cfg_jkmod.sh $user_tomcat $user_domain

############################################
#          Configuring server.xml          #
############################################

./cfg_server.sh $user_tomcat $user_domain

############################################
#          Configuring startup.sh          #
############################################

echo "User memory (in MB)"
read user_mem
./cfg_startup.sh $user_tomcat $user_mem

############################################
#        Configuring user rights           #
############################################

./cfg_rights.sh $user_tomcat

############################################
#   Saving all changes on the users file   #
############################################

echo "$user_tomcat $user_domain $user_port $user_version $user_mem" >> /usr/local/jakarta/conf/tomcatusers.cfg
