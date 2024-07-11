#!/bin/bash
source common.sh
LOG_FILE=/tmp/roboshop.log
#source C:\Users\wahee\github-repos\robo-shop\common.sh  # Use the full path to common.sh

component=catalogue
NODEJS

cp mongo.repo /etc/yum.repos.d/mongo.repo
cp catalogue.service /etc/systemd/system/${component}.service




echo Install momgodb client
dnf install mongodb-mongosh -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
    echo Success
else
    echo Failure
fi

if [ ! -f /app/db/master-data.js ]; then
  echo "/app/db/master-data.js: No such file or directory" &>>$LOG_FILE
  exit 1
fi

mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js &>>$LOG_FILE
if [ $? -eq 0 ]; then
    echo Success
else
    echo Failure
fi
