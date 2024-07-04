dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y
#update redis config file
systemctl enable redis
systemctl restart redis