dnf install nginx -y &>>/tmp/exp.log
systemctl enable nginx &>>/tmp/exp.log
systemctl start nginx &>>/tmp/exp.log

cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/exp.log
rm -rf /usr/share/nginx/html/* &>>/tmp/exp.log
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/exp.log

cd /usr/share/nginx/html &>>/tmp/exp.log
unzip /tmp/frontend.zip &>>/tmp/exp.log

systemctl enable  nginx &>>/tmp/exp.log
systemctl restart nginx &>>/tmp/exp.log
