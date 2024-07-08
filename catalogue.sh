source common.sh
component=catalogue
dnf install mongodb-mongosh -y
mongosh --host mongodb.dev.wdevops.fun </app/db/master-data.js