cp shipping.service /etc/yum.repos.d/mongo.repo
dnf install maven -y
useradd roboshop
mkdir /app
rm -rf /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip