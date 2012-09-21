#!/bin/sh

# $user_tomcat = $1
# $user_domain = $2

############################################
# editing EasyApache's jkmod config files  #
############################################

# Security copy

cp /usr/local/apache/conf/userdata/std/2/$1/$2/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/2/$1/$2/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf  /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/ssl/2/$1/$2/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/2/$1/$2/cp_jkmount.conf.old
cp /usr/local/apache/conf/userdata/ssl/1/$1/$2/cp_jkmount.conf  /usr/local/apache/conf/userdata/ssl/1/$1/$2/cp_jkmount.conf.old

# Changes default EasyApache service by the new one

sed -i 's/ajp13/'$1'/g' /usr/local/apache/conf/userdata/std/2/$1/$2/cp_jkmount.conf
sed -i 's/ajp13/'$1'/g' /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf
sed -i 's/ajp13/'$1'/g' /usr/local/apache/conf/userdata/ssl/2/$1/$2/cp_jkmount.conf
sed -i 's/ajp13/'$1'/g' /usr/local/apache/conf/userdata/std/1/$1/$2/cp_jkmount.conf

