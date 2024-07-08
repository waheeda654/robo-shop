LOG_FILE=LOG_FILE

NODEJS(){
  echo disable nodejs default version
  dnf module disable nodejs -y LOG_FILE

  echo node js 20 module
  dnf module enable nodejs:20 -y LOG_FILE

  echo install nodejs
  dnf install nodejs -y LOG_FILE

  echo copy service file
  cp {$component}.service /etc/systemd/system/{$component}.service LOG_FILE

  #cp mongo.repo /etc/yum.repos.d/mongo.repo
  echo adding application user
  useradd roboshop LOG_FILE

  echo cleaning old file
  rm -rf /app LOG_FILE

  echo create app dorectory
  mkdir /appy LOG_FILE

  echo download app content
  curl -o /tmp/{$component}.zip https://roboshop-artifacts.s3.amazonaws.com/{$component}-v3.zip LOG_FILE

  echo extract app content
  cd /app
  unzip /tmp/{$component}.zip LOG_FILE

  echo download nodejs dependencies
  cd /app
  npm install LOG_FILE

echo start service
  systemctl daemon-reload LOG_FILE
  systemctl enable {$component} LOG_FILE
  systemctl start {$component} LOG_FILE
}