source common.sh

print "disable nodejs"
dnf module disable nodejs -y &>>/tmp/exp.log
 echo $?

 print "enabling nodejs version 20"
dnf module enable nodejs:20 -y &>>/tmp/exp.log
 echo $?

 print "install nodejs"
dnf install nodejs -y &>>/tmp/exp.log
 echo $?

 print "copying backend service"
 cp backend.service /etc/systemd/system/backend.service &>>/tmp/exp.log
  echo $?
useradd expense

mkdir /app &>>/tmp/exp.log
 echo $?

 print "downloading backend components"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/exp.log
 echo $?
cd /app &>>/tmp/exp.log

print "extracting backend components"
unzip /tmp/backend.zip
 echo $?
cd /app &>>/tmp/exp.log
 echo $?
 print "installing nodejs"
npm install
 echo $?
 print "reloading DB"
systemctl daemon-reload &>>/tmp/exp.log
 echo $?
 print "enable backend service"
systemctl enable backend &>>/tmp/exp.log
 echo $?

 print "start backend service"
systemctl start backend &>>/tmp/exp.log
 echo $?
mysql -h 172.31.32.100  -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/exp.log
 echo $?
