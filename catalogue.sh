LOG_FILE=/tmp/roboshop.log
source common.sh
cp catalogue.service /etc/systemd/system/catalogue.service
component=catalogue
{
  echo "Setting up NodeJS environment..." &>>$LOG_FILE
  # Add NodeJS setup commands here
}

dnf install mongodb-mongosh -y &>>$LOG_FILE
mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js &>>$LOG_FILE
echo $?