#!/bin/sh

############################################
#           Interactive Setup              #
############################################

echo "Choose JDK version"
echo "1. JDK 7 x64 \n"
echo "2. JDK 6 x64 \n"
echo "3. JDK 5 i586 \n"
echo "4. Other (write path to installed jdk) \n"

read jdk

echo "Which Version of Tomcat do you want install?"
echo "1. Tomcat 7.0.30 \n"
echo "2. Tomcat 7.0.29 \n"
echo "3. Tomcat 6.0.35 \n"
echo "4. Tomcat 5.5.35 \n"

read choice

echo "Name User"

read user_name

echo "User Domain"

read user_domain

echo "User Memory"

read mem

# user_tomcat=$1
# user_domain=$2
# user_version=$3
# user_jdk=$4
# user_mem=$5

./tomcat_setup.sh $user_name $user_domain $choice $jdk $mem
