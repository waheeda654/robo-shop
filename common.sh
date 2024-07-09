# shellcheck disable=SC2275
&>>$LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

PRINT(){
  echo &>>$LOG_FILE
  echo &>>$LOG_FILE
  echo "###############$*######################" &>>$LOG_FILE
  echo $*
}

NODEJS(){
  PRINT disable nodejs default version
  dnf module disable nodejs -y >$LOG_FILE
  echo $?

  PRINT node js 20 module
  dnf module enable nodejs:20 -y >$LOG_FILE
  echo $?

  PRINT install nodejs
  dnf install nodejs -y >$LOG_FILE
  echo $?

  PRINT copy service file
  cp {$component}.service /etc/systemd/system/{$component}.service >$LOG_FILE
  echo $?

  #cp mongo.repo /etc/yum.repos.d/mongo.repo
  PRINT adding application user
  useradd roboshop >$LOG_FILE
  echo $?

  PRINT cleaning old file
  rm -rf /app >$LOG_FILE
  echo $?

  PRINT create app dorectory
  mkdir /appy >$LOG_FILE
  echo $?

  PRINT download app content
  curl -o /tmp/{$component}.zip https://roboshop-artifacts.s3.amazonaws.com/{$component}-v3.zip >$LOG_FILE
  echo $?

  PRINT extract app content
  cd /app
  unzip /tmp/{$component}.zip >$LOG_FILE
  echo $?

  PRINT download nodejs dependencies
  cd /app
  npm install >$LOG_FILE
  echo $?

PRINT start service
  systemctl daemon-reload >$LOG_FILE
  systemctl enable {$component} >$LOG_FILE
  systemctl start {$component} >$LOG_FILE
  echo $?
}