#!/bin/bash
 
OVMS_USER="ovms"
OVMS_USER_PASS="ovmsPass"
OVMS_DB_NAME="openvehicles"

EXPECTED_ARGS=0
E_BADARGS=65
MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS $OVMS_DB_NAME;"
Q2="GRANT ALL ON $OVMS_DB_NAME.* TO '$OVMS_USER'@'localhost' IDENTIFIED BY '$OVMS_USER_PASS';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
 
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0"
  exit $E_BADARGS
fi

echo "Enter mysql root password" 
$MYSQL -uroot -p -e "$SQL"

$MYSQL -u$OVMS_USER -p$OVMS_USER_PASS $OVMS_DB_NAME < ovms_server.sql
