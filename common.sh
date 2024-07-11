#!/bin/bash
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT(){
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo "###############$*######################" &>>$LOG_FILE
  echo $?
}

NODEJS(){
  PRINT "Disable NodeJS default version"
  dnf module disable nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Enable NodeJS 20 module"
  dnf module enable nodejs:20 -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Install NodeJS"
  dnf install nodejs -y &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Copy service file"
  cp ${component}.service /etc/systemd/system/${component}.service &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Adding application user"
  useradd roboshop &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Cleaning old files"
  rm -rf /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Create app directory"
  mkdir /app &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Download app content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Extract app content"
  cd /app
  unzip /tmp/${component}.zip &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Download NodeJS dependencies"
  cd /app
  npm install &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi

  PRINT "Start service"
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${component} &>>$LOG_FILE
  systemctl start ${component} &>>$LOG_FILE
  if [ $? -eq 0 ]; then
      echo Success
  else
        echo Failure
  fi
}
