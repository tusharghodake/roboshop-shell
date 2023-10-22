source common.sh

component=dispatch
schema_load=false

if [ -z "${roboshop_rabbitmq_password}" ]; then
  echo "Variable roboshop_rabbitmq_password is missing"
  exit 1
fi

print_head "Install golang"
dnf dnf install golang -y &>>${LOG}
status_check

APP_PREREQ

print_head "Download the dependencies & build the software"
cd /app
go mod init dispatch
go get
go build
status_check

SYSTEMD_SETUP