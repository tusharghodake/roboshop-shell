source common.sh

print_head "Configuring NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head " Install NodeJS"
dnf install nodejs -y &>>${LOG}
status_check

print_head "Add Application User"
useradd roboshop &>>${LOG}
status_check

print_head "Create App Directory"
mkdir -p /app &>>${LOG}
status_check

print_head "Downloading App Content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

print_head "Cleanup Old Content"
rm -rf /app/* &>>${LOG}
status_check

print_head "Extracting App Content"
cd /app 2&>>${LOG}
unzip /tmp/catalogue.zip  &>>${LOG}
status_check

print_head "Installing NodeJS Dependencies"
cd /app 2>>${LOG}
npm install &>>${LOG}
status_check

print_head "Configuring Catalogue Service File"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

print_head "Reload SystemD"
systemctl daemon-reload &>>${LOG}
status_check

print_head "Enable catalogue Service"
systemctl enable catalogue &>>${LOG}
status_check

print_head "Start catalogue Service"
systemctl start catalogue &>>${LOG}
status_check

print_head "Configuring mongo repo"
cp ${script_location}/files/mongodb.repo  /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_head "Install mongo client"
dnf install mongodb-org-shell -y &>>${LOG}
status_check

print_head "Schema Loading"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
status_check