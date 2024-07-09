&>>$LOG_FILE == /tmp/roboshop.log
source common.sh
component=catalogue
dnf install mongodb-mongosh -y >/tmp/roboshop.log
mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js
echo $?