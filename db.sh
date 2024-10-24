#!/bin/bash
sql_slave_user='CREATE USER "REPLACEME"@"%" IDENTIFIED BY "REPLACEME"; GRANT REPLICATION SLAVE ON *.* TO "REPLACEME"@"%"; FLUSH PRIVILEGES; CREATE USER 'REPLACEME'@'%' IDENTIFIED BY 'password'; GRANT ALL PRIVILEGES ON wordpress.* TO 'REPLACEME'@'%'; ALTER USER 'REPLACEME'@'%' IDENTIFIED WITH mysql_native_password BY 'REPLACEME';'
docker exec db_master sh -c "mysql -u root -pREPLACEME -e '$sql_slave_user'"
MS_STATUS=`docker exec db_master sh -c 'mysql -u root -pREPLACEME -e "SHOW MASTER STATUS"'`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`
sql_set_master="CHANGE MASTER TO MASTER_HOST='db_master',MASTER_USER='replication_user',MASTER_PASSWORD='REPLACEME',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
start_slave_cmd='mysql -u root -pREPLACEME -e "'
start_slave_cmd+="$sql_set_master"
start_slave_cmd+='"'
docker exec db-slave sh -c "$start_slave_cmd"docker exec db-slave sh -c "mysql -u root -pREPLACEME -e 'SHOW SLAVE STATUS \G'"