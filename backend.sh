source common.sh
component=backend
App_dir=/app
mysql_root_password=$1

if [ -z "${mysql_root_passowrd}"  ]; then

echo "input password is missing"
exit 1
  fi


print "Disable default NodeJS Version Module"
dnf module disable nodejs -y &>>$LOG
check_status $?

print "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

print "install nodejs"
dnf install nodejs -y &>>$LOG
check_status $?

print "Adding application user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
useradd expense &>>$LOG
fi

 print "Copy Backend Service file"
 cp backend.service /etc/systemd/system/backend.service &>>$LOG
 check_status $?

app_req

print "Download NodeJS Dependencies"
cd /app &>>$LOG
npm install
check_status $?

print "Start backend service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

print "Install MySQL Client"
dnf install mysql -y &>>$LOG
Check_Status $?

mysql -h mysql-dev.awsdevops.sbs  -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
check_status $?
