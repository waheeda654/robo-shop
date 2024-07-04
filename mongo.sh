cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
sed -i '/protected mode/ c protected mode no' /etc/redis/redis.conf
systemctl enable mongod
systemctl start mongod
#update mongo.repo file
systemctl restart mongod