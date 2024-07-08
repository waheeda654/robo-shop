&>>$LOG_FILE==/tmp/roboshop.log
source common.sh
component=catalogue
dnf install mongodb-mongosh -y &>>$LOG_FILE
mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js