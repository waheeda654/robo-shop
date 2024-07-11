#!/bin/bash
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT(){
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo "###############$*######################" &>>$LOG_FILE
  echo $?
}

STAT(){
  if [ $? -eq 0 ]; then
        echo -e "\e[32mSuccess\e[0m"
    else
          echo -e "\e[31mFailure\e[0m"
          exit
    fi
}

NODEJS(){
  PRINT Disable NodeJS default version
  dnf module disable nodejs -y &>>$LOG_FILE


  PRINT Enable NodeJS 20 module
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  STAT $?

  PRINT Install NodeJS
  dnf install nodejs -y &>>$LOG_FILE
  STAT $?

  PRINT Copy service file
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  STAT $?

  PRINT Adding application user
  useradd roboshop &>>$LOG_FILE
  STAT $?

  PRINT Cleaning old files
  rm -rf /app &>>$LOG_FILE
  STAT $?

  PRINT Create app directory
  mkdir /app &>>$LOG_FILE
  STAT $?

  PRINT Download app content
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  STAT $?

  PRINT Extract app content
  cd /app
  unzip /tmp/${component}.zip &>>$LOG_FILE
  STAT $?

  PRINT Download NodeJS dependencies
  cd /app
  npm install &>>$LOG_FILE
  STAT $?

  PRINT Start service
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  STAT $?
}
