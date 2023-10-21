source common.sh

echo -e "\e[35m Install Nginx\e[0m"
dnf install nginx -y &>>${LOG}
status_check

echo -e "\e[35m Remove Nginx Old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

echo -e "\e[35m Download frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

echo -e "\e[35m Extract Download frontend content\e[0m"
cd /usr/share/nginx/html &>>${LOG}
unzip /tmp/frontend.zip &>>${LOG}
status_check

echo -e "\e[35m Copy Roboshop Nginx config file\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

echo -e "\e[35m Enable Nginx\e[0m"
systemctl enable nginx &>>${LOG}
status_check

echo -e "\e[35m Start Nginx\e[0m"
systemctl restart nginx &>>${LOG}
status_check