script_location=$(pwd)
LOG=/tmp/roboshop.log
echo -e "\e[35m Install Nginx\e[0m"
dnf install nginx -y &>>${LOG}

echo -e "\e[35m Remove Nginx Old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}

echo -e "\e[35m Download frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}

cd /usr/share/nginx/html &>>${LOG}

echo -e "\e[35m Extract wnload frontend content\e[0m"
unzip /tmp/frontend.zip &>>${LOG}

echo -e "\e[35m Copy Roboshop Nginx config file\e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

echo -e "\e[35m Enable Nginx\e[0m"
systemctl enable nginx &>>${LOG}

echo -e "\e[35m Start Nginx\e[0m"
systemctl restart nginx &>>${LOG}
