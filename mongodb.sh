script_location=${pwd}

cd ${script_location}/files/mongodb.reppo  /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y

systemctl enable mongod
systemctl start mongod
systemctl restart mongod