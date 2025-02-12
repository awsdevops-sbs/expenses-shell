
source common.sh
component=frontend
app_dir=/usr/share/nginx/html

print "Install nginx "
dnf install nginx -y &>>$LOG
check_status $?


print "copy config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

app_req
 
print "Start nginx service"
systemctl enable  nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?