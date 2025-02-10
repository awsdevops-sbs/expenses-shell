dnf module disable nodejs -y &>>/tmp/exp.log
dnf module enable nodejs:20 -y &>>/tmp/exp.log

dnf install nodejs -y &>>/tmp/exp.log

 cp backend.service /etc/systemd/system/backend.service &>>/tmp/exp.log
useradd expense

mkdir /app

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/exp.log
cd /app &>>/tmp/exp.log
unzip /tmp/backend.zip

cd /app &>>/tmp/exp.log
npm install

systemctl daemon-reload &>>/tmp/exp.log
systemctl enable backend &>>/tmp/exp.log
systemctl start backend &>>/tmp/exp.log

mysql -h 172.31.32.100  -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/exp.log

