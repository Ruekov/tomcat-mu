#!/bin/sh

#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

############################################
#           Interactive Setup              #
############################################

echo "Choose JDK version"
echo "1. JDK 7 x64 \n"
echo "2. JDK 6 x64 \n"
echo "3. JDK 5 x64 \n"
echo "4. Let me write \n"

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
