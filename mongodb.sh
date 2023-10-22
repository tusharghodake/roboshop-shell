source common.sh

print_head "Copy Mongo Repo File"
cp ${script_location}/files/mongodb.repo  /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_head "Install Mongo"
dnf install mongodb-org -y &>>${LOG}
status_check

print_head "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
status_check

print_head "Enable Mongod Service"
systemctl enable mongod &>>${LOG}
status_check

print_head "Restart Mongod Service"
systemctl restart mongod &>>${LOG}
status_check