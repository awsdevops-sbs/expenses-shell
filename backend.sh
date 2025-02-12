source common.sh

print "disable nodejs"
dnf module disable nodejs -y &>>$LOG
 echo $?

 print "enabling nodejs version 20"
dnf module enable nodejs:20 -y &>>$LOG
 echo $?

 print "install nodejs"
dnf install nodejs -y &>>$LOG
 echo $?

 print "copying backend service"
 cp backend.service /etc/systemd/system/backend.service &>>$LOG
  echo $?
useradd expense

mkdir /app &>>$LOG
 echo $?

 print "downloading backend components"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$LOG
 echo $?
cd /app &>>$LOG

print "extracting backend components"
unzip /tmp/backend.zip
 echo $?
cd /app &>>$LOG
 echo $?
 print "installing nodejs"
npm install
 echo $?
 print "reloading DB"
systemctl daemon-reload &>>$LOG
 echo $?
 print "enable backend service"
systemctl enable backend &>>$LOG
 echo $?

 print "start backend service"
systemctl start backend &>>$LOG
 echo $?
mysql -h 172.31.32.100  -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG
 echo $?
