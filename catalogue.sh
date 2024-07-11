LOG_FILE=/tmp/roboshop.log
source common.sh

component=catalogue
cp mongo.repo /etc/yum.repos.d/mongo.repo
cp catalogue.service /etc/systemd/system/{$component}.service
{
  echo "Setting up NodeJS environment..." &>>$LOG_FILE
  # Add NodeJS setup commands here
}

dnf install mongodb-mongosh -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
    echo Sucess
  else
      echo Failure
  fi
mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js &>>$LOG_FILE
if [ $? -eq 0 ]; then
    echo Sucess
  else
      echo Failure
  fi