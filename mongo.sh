cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
#update mongo.repo file
systemctl restart mongod