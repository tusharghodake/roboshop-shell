script_location=$(pwd)

cp ${script_location}/files/mongodb.repo  /etc/yum.repos.d/mongodb.repo

dnf install mongodb-org -y

systemctl enable mongod
systemctl start mongod
systemctl restart mongod