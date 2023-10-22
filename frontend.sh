source common.sh

print_head "Install Nginx"
dnf install nginx -y &>>${LOG}
status_check

print_head "Remove Nginx Old content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "Download frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

print_head "Extract Download frontend content"
cd /usr/share/nginx/html &>>${LOG}
unzip /tmp/frontend.zip &>>${LOG}
status_check

print_head "Copy Roboshop Nginx config file"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "Enable Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "Start Nginx"
systemctl restart nginx &>>${LOG}
status_check