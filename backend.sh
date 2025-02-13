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
Check_Status $?

print "Enable NodeJS module for V20"
dnf module enable nodejs:20 -y &>>$LOG
Check_Status $?

print "Install NodeJS"
dnf install nodejs -y &>>$LOG
Check_Status $?

print "Adding Application User"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
Check_Status $?

print "Copy Backend Service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
Check_Status $?

App_PreReq

print "Download NodeJS Dependencies"
cd /app &>>$LOG
npm install &>>$LOG
Check_Status $?

print "Start Backend Service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
Check_Status $?

print "Install MySQL Client"
dnf install mysql -y &>>$LOG
Check_Status $?

print "Load Schema"
mysql -h mysql-dev.awsdevops.sbs -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
Check_Status $?