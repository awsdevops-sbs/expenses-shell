source common.sh
mysql_root_password=$1
app_dir=/app
component=backend

# If password is not provided then we will exit
if [ -z "${mysql_root_password}" ]; then
  echo Input Password is missing.
  exit 1
fi

print "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>>$LOG
check_status $?

print "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

print "Install NodeJS"
dnf install nodejs -y &>>$LOG
check_status $?

print "Adding Application User"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
check_status $?

print "Copy Backend Service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

app_req

print "Download NodeJS Dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

print "Start Backend Service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

print "Install MySQL Client"
dnf install mysql -y &>>$LOG
check_status $?

print "Load Schema"
mysql -h mysql-dev.awsdevops.sbs -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
check_status $?