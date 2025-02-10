
source common.sh

print "Install nginx"
dnf install nginx -y &>>/tmp/exp.log
 echo $?
print "Enable nginx"
systemctl enable nginx &>>/tmp/exp.log
 echo $?
print "Start nginx"
systemctl start nginx &>>/tmp/exp.log
 echo $?
print "copy config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/exp.log
 echo $?
print "Removing default nginx files"
rm -rf /usr/share/nginx/html/* &>>/tmp/exp.log
 echo $?
print "Download frontend components"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/exp.log
 echo $?
cd /usr/share/nginx/html &>>/tmp/exp.log
 echo $?
print "extract frontend components"
unzip /tmp/frontend.zip &>>/tmp/exp.log
 echo $?
print "enable nginx"
systemctl enable  nginx &>>/tmp/exp.log
 echo $?
print "restart nginx"
systemctl restart nginx &>>/tmp/exp.log
 echo $?