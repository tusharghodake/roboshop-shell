source common.sh

print_head "Configuring NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

echo -e "\e[35m Install NodeJS\e[0m"
dnf install nodejs -y &>>${LOG}
status_check

echo -e "\e[35m Add Application User\e[0m"
useradd roboshop &>>${LOG}
status_check

echo -e "\e[35m Create App Directory\e[0m"
mkdir -p /app &>>${LOG}
status_check

echo -e "\e[35m Downloading App Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

echo -e "\e[35m Cleanup Old Content\e[0m"
rm -rf /app/* &>>${LOG}
status_check

echo -e "\e[35m Extracting App Content\e[0m"
cd /app 2&>>${LOG}
unzip /tmp/catalogue.zip  &>>${LOG}
status_check

echo -e "\e[35m Installing NodeJS Dependencies\e[0m"
cd /app 2>>${LOG}
npm install &>>${LOG}
status_check

echo -e "\e[35m Configuring Catalogue Service File\e[0m"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

echo -e "\e[35m Reload SystemD\e[0m"
systemctl daemon-reload &>>${LOG}
status_check

echo -e "\e[35m Enable catalogue Service\e[0m"
systemctl enable catalogue &>>${LOG}
status_check

echo -e "\e[35m Start catalogue Service\e[0m"
systemctl start catalogue &>>${LOG}
status_check

echo -e "\e[35m Configuring mongo repo\e[0m"
cp ${script_location}/files/mongodb.repo  /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

echo -e "\e[35m Install mongo client\e[0m"
dnf install mongodb-org-shell -y &>>${LOG}
status_check

echo -e "\e[35m Schema Loading\e[0m"
mongo --host localhost </app/schema/catalogue.js &>>${LOG}
status_check